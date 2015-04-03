<?php
namespace Admin\Controller;
use Think\Page;
class ProductkeyController extends AdminController {
	protected $model ;
	protected $id;
	private $_status=array();
	private $_type = array();
	public function _initialize(){
		parent::_initialize();
		$this->model = D('Productkey');
		$this->id = I('id');
		$this->_status = array(
				'status'=>array(
						0=>'<font color="red">待处理</font>',
						1=>'<font color="#0066cc">正在处理</font>',
						2=>'<font color="green">已回复</font>')
		);
		$this->_type = array( 'type' => C('PRODUCT_TYPE') );
	}
	public function index(){
	
		$this->meta_title = '产品问题关键词';
		$lists = $this->lists( $this->model , null , 'id DESC' , null ,'title,id' );
		$this->assign( 'indexlist' , $lists );
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	public function add(){
		$this->meta_title = '新增产品问题关键词';
		$this->display();
	}
	public function edit(){
		$this->meta_title = '编辑产品问题关键词';
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
	
	public function detail()
	{
		//标签名
		$labelname = M('productkey')->where(array('id'=>$this->id))->getField('title');
		$this->meta_title = "关键词：". $labelname . '问题列表';
		$table = "{$this->prefix}product AS p";
		$join  = " JOIN {$this->prefix}document AS d ON p.product_id=d.id";
		$join .= " JOIN {$this->prefix}users AS u ON p.uid=u.id";
		$join .= " JOIN {$this->prefix}pro_key AS pk ON p.id=pk.pid";
		$join .= " JOIN {$this->prefix}productkey AS pkey ON pk.kid=pkey.id";
		$where['pkey.id']=$this->id;
		$field = "p.id,d.title AS title,p.status,p.p_description,p.create_time,p.type,pkey.title AS keywods,u.realname";
		$model = M('')->table($table)->join($join)->where($where);
		//查询结果
		$lists = $this->lists( $model , null , null , null , $field);
		//状态
		int_to_string( $lists , $this->_status );
		int_to_string( $lists , $this->_type );
		$this->assign( 'indexlist' , $lists );
		//当前地址加入cookie方便返回
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	
	/**
	 * 从标签中移除
	 */
	public function remove(){
		$pid=I('pid',null,'intval');
		if( $pid && $this->id){
			M('pro_key')->where(array('kid'=>$this->id,'pid'=>$pid))->delete();
			$this->success('移除成功' , cookie('__forward__'));
		}else{
			$this->error('非法操作');
		}
	}
	
}
