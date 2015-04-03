<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;
use User\Api\UsersApi;
class UserController extends HomeController {
	private $user_id;
	public function _initialize(){
		parent::_initialize();
		$this->user_id = cookie('user_id') ? cookie('user_id') : redirect(U('Public/login'));
		$this->feedback_type = C('FEEDBACK_TYPE');//反馈类型
		$this->feedback_time = C('FEEDBACK_TIME');//反馈时间
		$this->nav = 'nav5';
	}
	/* 用户中心首页 */
	public function index(){
		$User = new UsersApi();
		$userinfo = $User->info($this->user_id);
		$this->assign( 'field' , $userinfo );
		$this->display();
	}
	/**
	 * 修改用户资料
	 */
	public function edit(){
		$User = new UsersApi();
		if(IS_POST){
			$addcompany = I('addcompany', null);
			$companyid = I('companyid', null);
			$uid = $User->register();
			if( $uid > 0 ){
				if( $addcompany && $companyid==false)$this->user_Add_company($addcompany, $this->user_id);
				$this->success( '更新成功' , U('User/index') );
			}else{
				$this->error( $this->showRegError($uid)  );
			}
		}else{
			//显示公司信息
			$this->company = M('company')->field('id,title')->where(array('status'=>1,'pid'=>0))->select();
			//标签
			//显示部门信息
			//用户信息
			$userinfo = $User->info($this->user_id);
			$this->assign( 'field' , $userinfo );
			$this->usertags = $this->usersLabel();
			$this->display();
		}
	}
	
	private function usersLabel(){
		$table = "{$this->prefix}label AS l";
		$join = "{$this->prefix}user_label AS ul ON l.id=ul.labelid";
		return M('')->table($table)->field('l.id,l.title,count(ul.labelid) AS num')->join($join)->group('l.title')->order('num DESC')->limit(10)->select();
		// 		return var_dump(M('')->getLastSql());
	}
	/**
	 * 用户在前台页面手工输入单位,同时更新用户单位和部门
	 * @param string $addcompny
	 */
	private function user_Add_company( $addcompany, $uid){
		$data = array();
		$info = str2arr( $addcompany,' ');
		//公司
		$company = array(
				'title'	=>	$info[0],
				'create_time' => NOW_TIME,
		);
		//查看公司是否存在
		$companyid=M('company')->where(array('title'=>$info[0]))->getField('id');
		$data['companyid'] = $companyid ? $companyid : M('company')->add($company);
		//部门
		if( isset($info[1])){
			$department = array(
				'title'	=>	$info[1],
				'pid'	=> $data['companyid'],	
				'create_time' => NOW_TIME,
			);
			$data['departmentid'] = M('company')->add($department);
		}
		M('users')->where(array('id'=>$uid))->save($data);
	}
	/**
	 * 技术资料反馈
	 */
	public function technology(){
		if( IS_POST ){
			$db = D('Technology');
			if( $id = D('Technology')->update() ){
				session( 'request_action' , ACTION_NAME );
				$this->success( '成功' , U('Submitok') );
			}else{
				$this->error( $db->getError() );
			}
		}else{
			//查询热门关键词 top10:TODO
			$table = "{$this->prefix}technologykey AS t";
			$join = "{$this->prefix}tech_key AS tk ON t.id=tk.kid";
			$techkey = M('')->table($table)->field('t.title,count(tk.kid) AS num')->join($join)->group('t.title')->order('num DESC')->limit(10)->select();
// 			$techkey = M('technologykey')->field('title')->limit(10)->select();
			$this->assign( 'techkey' , $techkey );
			$this->display();
		}
	}
	/**
	 * 产品问题反馈
	 */
	public function product(){
		if( IS_POST ){
			$db = D('product');
			if( $id = D('product')->update() ){
				session( 'request_action' , ACTION_NAME );
				$this->success( '成功' , U('Submitok') );
			}else{
				$this->error( $db->getError() );
			}
		}else{
			$data = array();
			$data['product'] = M('document')->where(array('category_id'=>5,'status'=>1))->select();//产品
			$table = "{$this->prefix}productkey AS p";
			$join = "{$this->prefix}pro_key AS pk ON p.id=pk.kid";
			$data['techkey'] = M('')->table($table)->field('p.title,count(pk.kid) AS num')->join($join)->group('p.title')->order('num DESC')->limit(10)->select();
			$data['product_type'] = C('PRODUCT_TYPE');//产品问题的类型
			$this->assign( 'field' , $data );
			$this->display();
		}
	}
	/**
	 * 提交ok
	 */
	public function Submitok(){
		if( session('request_action') ){
			$this->assign( 'jumpurl' , U('User/'.session('request_action')) );
			$this->display();
		}
	}
	/**
	 *
	 */
	public function changeCompany(){
		if( IS_AJAX ){
			$companyid = I('companyid',null,'intval');
			$department = M('company')->field('id,title')->where(array('pid'=>$companyid,'status'=>1))->select();
			exit(json_encode( $department ));
		}else{
			$this->error('页面不存在');
		}
	}
	
}
