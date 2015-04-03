<?php

namespace Admin\Controller;
class FeedbackController extends AdminController {
	private $feedback_type;
	private $feedback_time;
	private $_status= array();
	public function _initialize(){
		parent::_initialize();
		$this->_status = array(
				'status'=>array(
					0=>'<font color="red">待处理</font>',
					1=>'<font color="#0066cc">正在处理</font>',
					2=>'<font color="green">已回复</font>')
				);
		$this->feedback_type = C('FEEDBACK_TYPE');
		$this->feedback_time = C('FEEDBACK_TIME');
	}
	/////////////////////////////////////分割线/////////////////////////////////////////////////
	/**
	 * 技术资料反馈
	 */
	
	private function technologyModel(){
		$model = array();
		$table ="{$this->prefix}technology AS t ";
		$join ="JOIN {$this->prefix}users AS u ON t.uid=u.id ";
		$model['field'] ="t.id,t.title,t.status,t.p_description,t.create_time,t.type,u.realname";
		$model['order']="t.id DESC";
		$model['model'] = M('')->table($table)->join($join);
		return $model;
	}
	
	public function technology(){
		$this->meta_title = "技术资料反馈";
		$model = $this->technologyModel();
		$list = $this->lists( $model['model'] , null , $model['order'] , null , $model['field']);
		int_to_string($list , $this->_status );
		$this->assign( 'indexlist' , $list );
		//返回链接地址写入cookie
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}

	/////////////////////////////////////分割线/////////////////////////////////////////////////
	/**
	 * 产品问题
	 */
	private function productModel(){
		$model = array();
		$table ="{$this->prefix}product AS p ";
		$join ="JOIN {$this->prefix}document AS d ON p.product_id=d.id ";//先和产品表关联 产品id=文档id
		$join .="JOIN {$this->prefix}users AS u ON p.uid=u.id "; //和用户表关联 
		$model['field'] = "p.id,d.title,p.p_description,p.status,p.create_time,p.ptype,p.type,p.time,u.realname,u.mobile,u.email";
		$model['order']="p.id DESC";
		$model['model'] = M('')->table($table)->join($join);
		return $model;
	}
	public function product(){
		$this->meta_title = "产品问题反馈";
		//组合查询语句
		//关联组合模型
		$model = $this->productModel();
		$list = $this->lists( $model['model'] , null , $model['order'] , null , $model['field']);
		//echo M('')->getLastSql();
		int_to_string($list , array('ptype'=>C('PRODUCT_TYPE')) );
		int_to_string($list , $this->_status );
		$this->assign( 'indexlist' , $list );
		//返回链接地址写入cookie
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
		
	}
	/////////////////////////////////////分割线/////////////////////////////////////////////////
	
	/**
	 * 用户反馈
	 */
	public function experience(){
		$this->meta_title = "用户体验反馈";
		$this->display();
	}

	public function view(){
		$method = isset($_GET['methond'])? $_GET['methond'] : null;
		$this->method = $method;
		$id = isset( $_GET['id'] ) ? intval($_GET['id']) : null;
		if( $method && $id ){
			$keywords = array();
			switch ( $method ){
				case 'technology': 
					$this->meta_title = "查看技术资料反馈信息";
					$model = $this->technologyModel();
					$field = $model['model']->where(array('t.id'=>$id))->find();
					$table = "{$this->prefix}technologykey AS t";
					$join = "{$this->prefix}tech_key AS tk ON t.id=tk.kid";
					$keywords = M('')->table($table)->join($join)->where(array('tk.tid'=>$id))->getField('title',true);
					break;
				case 'product': 
					$this->meta_title = "查看产品问题反馈信息";
					$model = $this->productModel();
					$field = $model['model']->where(array('p.id'=>$id))->find();
					$table = "{$this->prefix}productkey AS p";
					$join = "{$this->prefix}pro_key AS pk ON p.id=pk.kid";
					$keywords = M('')->table($table)->join($join)->where(array('pk.pid'=>$id))->getField('title',true);
					break;
			}
			$field['keywords'] = $keywords ? arr2str($keywords) : '无关键字';
			$field['type_text'] = $this->feedback_type{$field['type']};//类型转字符
			$field['time_text'] = $this->feedback_time{$field['time']};
			$this->field = $field;
			$this->display();
		}
	}
}
