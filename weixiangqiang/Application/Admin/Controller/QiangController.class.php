<?php
namespace Admin\Controller;
/**
 * 微信墙内容控制器
 * @author Weiyong <weiyong.me@qq.com>
 */
class QiangController extends AdminController 
{
	/**
	 * 活动列表
	 */
	public function index()
	{
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$dataList = $this->lists('Qiang');
		$this->assign( 'dataList', $dataList );
		$this->display();
	}
	/**
	 * 添加活动
	 */
	public function add()
	{
		
		$this->display();
	}
	/**
	 * 添加活动
	 */
	public function edit()
	{
		
		$this->display('add');
	}
	public function update(){
		if(IS_POST)
		{
			$regis = I('post.regis');
			$is_dev = I('post.is_dev');
			if( $regis == 1 ){
				if ( empty( $is_dev ) ) $this->error('请选择组合条件'); 
			}
			$model = D('Qiang');
			$res = $model->update();
			if( !$res ){
				$this->error($model->getError());
			}else{
				if( $res['id'] ){
					$this->success('修改活动成功', U('index'));
				}else {
					$this->success('新增活动成功', cookie('__forward__'));
				}
			}
		}else{
			$this->error('页面不存在');
		}
	}
}
