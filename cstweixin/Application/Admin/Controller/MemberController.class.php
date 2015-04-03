<?php
namespace Admin\Controller;
use User\Api\UsersApi;
class MemberController extends AdminController {
	private $_id;
	private $_status= array();
	public function _initialize(){
		parent::_initialize();
		$this->_id = I('id',NULL,'intval');
		$this->_status = array(
				'status'=>array(
						0=>'<font color="red">待处理</font>',
						1=>'<font color="#0066cc">正在处理</font>',
						2=>'<font color="green">已回复</font>')
		);
		//显示公司信息
		$this->company = M('company')->field('id,title')->where(array('status'=>1,'pid'=>0))->select();
		//标签
		
	}
	
	
    public function index(){
    	$gid = isset( $_GET['gid'] ) ? intval($_GET['gid']) : 1;
    	$this->gid = $gid;
    	$this->meta_title = $gid==1 ? '普通用户' : '内部用户';
    	$map['gid'] = $gid;
    	if(isset($_GET['realname'])){
    		$map['realname']    =   array('like', '%'.(string)I('realname').'%');
    	}
    	$list = $this->lists('Users', $map,'id DESC');
    	int_to_string($list, array('status'=>array(0=>'禁用', 1=>'启用')));
    	$this->assign('indexlist', $list);
    	//
    	cookie('__forward__',$_SERVER['REQUEST_URI']);
    	$this->display();
    }
    
    public function view(){
    	$User = new UsersApi();
    	$this->meta_title = '查看用户信息';
		$id = I( 'id', '' , 'intval' );
		if( $id ){
			$userinfo = $User->info( $id );
			$this->assign( 'field' , $userinfo );
		}else{
			$this->error('参数有误');
		}
		$this->display();
    }
	/**
	 * 微信关注用户
	 */
	
	public function Weixinuser(){
		$this->meta_title = "关注用户列表";
		//查询的关键字
		if(isset($_GET['nickname'])){
			$map['nickname']    =   array('like', '%'.(string)I('nickname').'%');
		}
		//list方法查询信息
		$list = $this->lists('weixin_users', $map,'id DESC');
		foreach ( $list as &$v ){
			$v['uid'] = $v['is_reg'] ? M('users')->where(array('openid'=>$v['openid']))->getField('id'):'';
		}
		int_to_string( $list , array('sex'=>array(1=>'男',2=>'女')) );
		$this->assign('indexlist', $list);
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	
	/**
	 * 设为注册用户
	 */
	public function setreg(){
		$old_id = intval($_REQUEST['old_id']);//关注用户的id
		$gid = intval($_REQUEST['gid']);//加为用户的分组的id
		if( IS_POST ){
			$User = new UsersApi();
			$uid = $User->register();
			if( $uid>0 ){
				M('weixin_users')->where(array('id'=>$old_id))->setField('is_reg',1);
				M('getcode')->where(array('openid'=>I('openid')))->setField('status',1);
				$this->success('添加成功!' , U('Member/index',array('gid'=>$gid)));
			}else {
				$this->error($this->showRegError($uid));
			}
		}else{
			//标题
			$this->meta_title = $gid==1 ? '添加普通用户' : '添加内部用户';
			//用户openid
			$this->openid = M('weixin_users')->where(array('id'=>$old_id))->getField('openid');
			//标签列表
			$this->usertags = $this->usersLabel();
			$this->display();
		}
	}
	/**
	 * 修改用户信息
	 */
	public function edit(){
		$User = new UsersApi();
		$id = intval($_REQUEST['id']);
		if( IS_POST ){
			$User = new UsersApi();
			$uid = $User->register();
			if( $uid>0 ){
				$this->success('编辑成功!' , cookie( '__forward__' ));
			}else {
				$this->error($this->showRegError($uid));
			}
		}else{
			$field = $User->info( $id ) ;
			//标题
			$this->meta_title = $field['gid']==1 ? '编辑普通用户' : '编辑内部用户';
			//标签列表
			$this->usertags = $this->usersLabel();
			$this->assign( 'field' , $field );
			$this->display();
		}
		
	}
	
	private function usersLabel(){
		$table = "{$this->prefix}label AS l";
		$join = "{$this->prefix}user_label AS ul ON l.id=ul.labelid";
		return M('')->table($table)->field('l.id,l.title,count(ul.labelid) AS num')->join($join)->group('l.title')->order('num DESC')->limit(10)->select();
// 		return var_dump(M('')->getLastSql());
	}
	
	#################################################################################
	/**
	 * 用户搜索条件
	 * @return 
	 */
	protected function conditon(){
		$data = array();
		if( F('userCondition') ){
			$data = F('userCondition');
		}else{
			//单位
			$data['company'] = M('company')->field('id,title')->where(array('pid'=>0))->select();
			//标签
			$data['label'] = M('label')->field('id,title')->where(array('pid'=>0))->select();
			//状态
			$data['label'] = M('label')->field('id,title')->where(array('pid'=>0))->select();
			$data['status'] = array(1=>'启用',0=>'禁用');
			F( 'userCondition' , $data );
		}
		return $data;
	}
	/**
	 * 用户搜索
	 */
	public function Membersearch(){	
		$this->meta_title = '用户信息搜索 ';
		//模型 
		$table = "{$this->prefix}users AS u";
		//查询字段
		$field = "u.id,u.realname,u.email,u.mobile,u.gid,u.reg_time,u.status,u.companyid";
		//组合关联条件
		$join = "";
		$where = array();
		//姓名
		$realname = I('realname',null);
		$where['u.realname'] =$realname ? array('like',"%".$realname."%") : '';
		//手机号
		$mobile = I('mobile',null);
		$where['u.mobile'] = $mobile ? array('like',"%".$mobile."%") : '';
		//邮箱
		$email = I('email',null);
		$where['u.email'] = $email? array('like',"%".$email."%") : '';
		//状态
		$where['u.status'] = I('status');
		//按公司查询
		$companyid = I('companyid',null,'intval');
		if( $companyid ){
			$field .=",c.title AS company";
			$join  .=" JOIN {$this->prefix}company AS c ON u.companyid=c.id";
			$where['c.id']=$companyid;
		}
		//按标签查询
		$labelid = I('labelid',null,'intval');
		if( $labelid ){
			$field .=",l.title AS label";
			$join .=" JOIN {$this->prefix}user_label AS la ON u.id=la.uid";
			$join .=" JOIN {$this->prefix}label AS l ON la.labelid=l.id";
			$where['l.id'] = $labelid;
		}
		//模型
		$model = M('')->table($table)->join($join);
		$users = $this->lists($model,$where, "u.id DESC" ,null,$field);
		//用户搜索未选择公司
		if( !$companyid){
			foreach ( $users as &$v ){
				$compnay = $this->get_user_company( $v['companyid']);
				$v['company'] = $compnay ? $compnay : '用户未选择公司' ;
			}
		}
		//如果没有指定标签则查全部
		if( $labelid == false ){
			foreach ( $users as &$v ){
				//用户标签
				$userlabel = get_user_label($v['id']);
				$v['label'] = empty($userlabel) ? "用户暂无标签" : arr2str( $userlabel );
			}	
		}
		int_to_string( $users );
		//筛选条件
		//搜索条件
		$data = $this->conditon();
		//公司选中
		foreach ( $data['company'] as &$v ){
			$v['selected'] = $v['id'] == $companyid ? "selected='selected'"	: '';
		}
		//标签选中
		foreach ( $data['label'] as &$v ){
			$v['selected'] = $v['id'] == $labelid ? "selected='selected'"	: '';
		}
		$this->assign('status',I('status'));
		$this->assign('field',$data);
		$this->assign( 'indexlist' , $users );
		$this->display();
	}
	/**
	 * 查询用户的公司
	 * @param int $companyid 公司id
	 */
	protected function get_user_company( $companyid){
		return M('company')->where(array('id'=>$companyid))->getField('title');
	}
	
	/**
	 * 将用户移至普通或者内部 
	 */
		
	public function setgroup(){
		$id = I('id',null,'intval');
		$gid = I('gid',null,'intval');
		if( $id && $gid ){
			M('users')->where(array('id'=>$id))->setField('gid', $gid);
			$this->success( '操作成功', cookie('__forward__'));
		}else{
			$this->error('参数有误');
		}
	}
	#################################################################################
	/**
	 * 邮件订阅
	 */
	public function subscribe(){
		$this->meta_title = '邮件订阅列表';
		$map['order'] = 1;
		$list = $this->lists('Users', $map, null , null ,'id,email,realname');
		$this->assign('indexlist', $list);
		$this->display();
	}
	
	public function copyAll(){
		$data = array();
		$ids = I('id');
		if( $ids && is_array($ids) ){
			$data['status'] = 1;
			$data['msg'] = '';
			$map['id'] = array( 'in', $ids );
			$email = M('users')->where($map)->getField('email',true);//查询所选用户的的邮箱
			foreach ( $email as $v ){
				$data['msg'] .= $v . ',';
			}
		}else{
			$data['status'] = 0;
			$data['msg'] = '请选择要复制的内容'; 
		}
		exit( json_encode($data));
	}
	/**
	 * 用户申请列表
	 */
	public function getcode(){
		$map = array();
		$this->meta_title = '用户申请邀请码管理 ';
		if(isset($_GET['username'])){
			$map['username']    =   array('like', '%'.(string)I('username').'%');
		}
		$list = $this->lists('Getcode', $map,'id DESC');
		int_to_string( $list , $this->_status );
		int_to_string( $list , array('gid'=>C('APPLY_TYPE')) );
		$this->assign('indexlist', $list);
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	/**
	 * 审核用户申请处理
	 */
	public function check(){
		$this->usergroup = C('USER_GROUP');//配置里的用户分组类型
		$this->meta_title = '用户申请邀请码审核 ';
		$model = D('Users');
		$applyid = I('applyid');
		if( IS_POST ){
			if( $model->update() ){
				M('getcode')->where(array('id'=>$applyid))->setField('status',1);
				M('weixin_users')->where(array( 'openid'=>I('openid')) )->setField( 'is_reg', 1 );
				$this->success( '新增成功' , U(cookie( '__forward__')) );
			}else{
				$this->error( $model->getError() );
			}
		}else{
			$this->field = M('getcode')->where(array('id'=>$applyid))->find();
			$this->display();
		}
	}
	/**
	 * 获取用户注册错误信息
	 * @param  integer $code 错误编码
	 * @return string        错误信息
	 */
	private function showRegError($code){
		switch ($code) {
			case -1:  $error = '真实姓名不能为空'; break;
			case -2:  $error = '手机号不能为空'; break;
			case -3:  $error = '手机号格式有误'; break;
			case -4:  $error = '手机号已经存在'; break;
			case -5:  $error = '邮箱不能为空'; break;
			case -6:  $error = '邮箱格式有误'; break;
			case -7:  $error = '邮箱已经存在'; break;
			case -8:  $error = '请选择公司'; break;
			case -9:  $error = '请选择部门'; break;
			case -10: $error = '用户已存在'; break;
			case -11: $error = '请输入用户的工业电子id！'; break;
			case -12: $error = '请选择用户分组'; break;
			case -13: $error = '请输入邀请码'; break;
			case -14: $error = '邀请码至少6个字符！'; break;
			case -15: $error = '邀请码已存在'; break;
			default:  $error = $code;
		}
		return $error;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 客户资料管理
	 */
	public function customer(){
		$this->meta_title = '客户资料';
		if(isset($_GET['keywords'])){
			$map['c.realname']    =   array('like', '%'.(string)I('keywords').'%');
			$map['co.title'] = array('like', '%'.(string)I('keywords').'%');
			$map['_logic'] = 'OR';
		}
		//关联查询客户信息
		$field="c.id,c.realname,c.sex,c.mobile,c.create_time,co.title AS company";
		$table ="{$this->prefix}customer AS c";
		$join ="JOIN {$this->prefix}company AS co ON c.companyid=co.id";
		$model =M('')->table($table)->join($join);
		$lists = $this->lists( $model, $map, 'c.id DESC', null,$field);
		$this->assign( 'indexlist' , $lists );
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	/**
	 * 增加客户资料
	 */
	public function Addcustomer(){
		$this->meta_title = '增加客户资料 ';
		$this->customerlabel = $this->customerlabel();
		$this->display();
	}
	/**
	 * 编辑客户资料
	 */
	public function Editcustomer(){
		$this->meta_title = '编辑客户资料 ';
		$id = intval($_REQUEST['id']);
		$field=M('customer')->where(array('id'=>$id))->find();
		$field['department'] = get_user_company( $field['departmentid'] );
		$field['cust_label'] = get_customer_label($field['id']);
		$this->field = $field ;
		$this->customerlabel = $this->customerlabel();
		$this->display('addcustomer');
	}
	/**
	 * 更新或保存客户的信息
	 */
	public function Updatecustomer(){
		$label = I('label',null);
		if( substr_count($label, ',') >10 ){
			$this->error('客户标签最多10个');
		}else{
			$company = I('add_company', null );  //
			$department = I('add_department', null );
			$customer_id = I('id',null,'intval');//客户的id，
			$companyid = I('companyid',null);
			$id = D('Customer')->update();
			if( $id>0 ){
				$customer_id ? $this->add_customer_company($company,$companyid ,$department, $customer_id) : $this->add_customer_company($company,$companyid, $department, $id);
				$this->success('操作成功!' , cookie('__forward__'));
			}else {
				$this->error($this->showRegError($id));
			}
		}
		
	}
	/**
	 * 查看客户资料
	 */
	public function viewcustomer(){
		$this->meta_title = '查看客户资料 ';
		$id = intval($_REQUEST['id']);
		//关联查询出用户的基本信息
		$userinfo = M('customer')->where(array('id'=>$id))->find();
		$userinfo['company'] = get_user_company( $userinfo['companyid'] );
		$userinfo['department'] = get_user_company( $userinfo['departmentid'] );
		$userinfo['cust_label'] = get_customer_label($userinfo['id']);
		$this->assign('field',$userinfo);
		$this->display();
	}
	/**
	 * 
	 * 执行公司和部门的手工输入并保存客户公司信息
	 * @param string $company	输入的公司
	 * @param string $department 输入的部门
	 * @param int $customer_id 客户id
	 * @param int $post_company_id 选择了公司没有选部门
	 */
	private function add_customer_company( $company,$post_company_id, $department, $customer_id ){
		$add_company['title'] = $company;
		$add_company['create_time'] = time();
		$add_department['title'] = $department;
		$add_department['create_time'] = time();
		//先判断是否输入了公司
		if( $company ){
			//查询输入的公司是否存在
			$is_companyid = M('company')->where( array('title'=>$company) )->getField('id');
			//公司的id
			$companyid = $is_companyid ? $is_companyid :  M('company')->add( $add_company );
			M('customer')->where(array('id'=>$customer_id))->setField( 'companyid', $companyid); //更新客户的公司id
			if( $department ){//先判断是否输入了部门
				$add_department['pid'] = $companyid;//部门平归属公司的id
				$departmentid = M('company')->where($add_department)->getField('id');//判断部门是否存在
				$department_id = $departmentid ? $departmentid : M('company')->add( $add_department );//保存部门
				M('customer')->where(array('id'=>$customer_id))->setField( 'departmentid', $department_id); //更新客户的部门id
			}
		}elseif($post_company_id){
			if( $department ){//先判断是否输入了部门
				$add_department['pid'] = $post_company_id;//部门平归属公司的id
				$departmentid = M('company')->where($add_department)->getField('id');//判断部门是否存在
				$department_id = $departmentid ? $departmentid : M('company')->add( $add_department );//保存部门
				M('customer')->where(array('id'=>$customer_id))->setField( 'departmentid', $department_id); //更新客户的部门id
			}
		}
	}
	/**
	 *客户标签
	 */
	private function customerlabel(){
		$table = "{$this->prefix}customerlabel AS c";
		$join = "{$this->prefix}customer_label AS cl ON c.id=cl.labelid";
		return  M('')->table($table)->field('c.id,c.title,count(cl.labelid) AS num')->join($join)->group('c.title')->order('num DESC')->limit(10)->select();
// 		 return var_dump( M('')->getLastSql());
	}
}
