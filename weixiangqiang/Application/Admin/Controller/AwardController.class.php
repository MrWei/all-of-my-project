<?php
namespace Admin\Controller;
/** 
* 奖项管理 
* @author  Weiyong <weiyong.me@qql.com> 
*/ 
class AwardController extends AdminController 
{
	/**
	 * 活动奖项
	 */
	public function index()
	{
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	/**
	 * 添加奖项
	 */
	public function add()
	{
		
		$this->display();
	}
	/**
	 * 添加奖项
	 */
	public function edit()
	{
		
		$this->display('add');
	}
	public function update(){
		
	}
}
