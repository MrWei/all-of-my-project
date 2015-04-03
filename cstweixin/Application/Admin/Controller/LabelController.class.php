<?php
namespace Admin\Controller;
use Think\Page;
class LabelController extends AdminController {
	protected $model ;
	protected $id;
	public function _initialize(){
		parent::_initialize();
		$this->model = D('Label');
		$this->id = I('id',null,'intval');
	}
	public function index(){
	
		$this->meta_title = '用户标签';
		$lists = $this->lists( $this->model , null , 'id DESC' , null ,'title,id' );
		$this->assign( 'indexlist' , $lists );
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	public function add(){
		$this->meta_title = '新增用户标签';
		$this->display();
	}
	public function edit(){
		$this->meta_title = '编辑用户标签';
		$this->field = $this->model->find($this->id) ;
		$this->display('add');
	}
	public function update(){
		$res = $this->model->update();
		if(!$res){
			$this->error( $this->model->getError());
		}else{
			if($res['id']){
				$this->success('更新成功', Cookie('__forward__'));
			}else{
				$this->success('新增成功', Cookie('__forward__'));
			}
		}
	}
	/**
	 * 查看标签下的用户
	 */
	public function detail()
	{	
		//标签名
		$labelname = M('label')->where(array('id'=>$this->id))->getField('title');
		$this->meta_title = "标签：". $labelname . '用户列表';
		$tabel = "{$this->prefix}users AS u";
		$join = " JOIN {$this->prefix}user_label AS ul ON u.id=ul.uid ";
		$join .=" JOIN {$this->prefix}label AS l ON ul.labelid=l.id ";
		//搜索条件
		$where['l.id']=$this->id;
		//按姓名搜索
		if(isset($_GET['realname'])){
			$where['u.realname']    =   array('like', '%'.(string)I('realname').'%');
		}
		//搜索字段
		$field = "u.id,u.realname,u.status,u.reg_time,l.title";
		$model = M('')->table($tabel)->join($join)->where($where)->group('u.id');
		//查询结果
		$userlist = $this->lists( $model , null , null , null , $field );
		int_to_string( $userlist );
		//		
		$this->assign( 'indexlist' , $userlist );
		//
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	/**
	 * 从标签中移除
	 */
	public function remove(){
		$uid=I('uid',null,'intval');
		if( $uid && $this->id){	
			M('user_label')->where(array('uid'=>$uid,'labelid'=>$this->id))->delete();
			$this->success('移除成功' , cookie('__forward__'));
		}else{
			$this->error('非法操作');
		}
	}
	
}
