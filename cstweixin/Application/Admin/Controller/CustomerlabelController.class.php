<?php
namespace Admin\Controller;
use Think\Page;
class CustomerlabelController extends AdminController {
	protected $model ;
	protected $id;
	public function _initialize(){
		parent::_initialize();
		$this->model = D('Customerlabel');
		$this->id = I('id',null,'intval');
	}
	public function index(){
	
		$this->meta_title = '客户标签';
		$lists = $this->lists( $this->model , null , 'id DESC' , null ,'title,id' );
		$this->assign( 'indexlist' , $lists );
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	public function add(){
		$this->meta_title = '新增客户标签';
		$this->display();
	}
	public function edit(){
		$this->meta_title = '编辑客户标签';
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
		$labelname = M('customerlabel')->where(array('id'=>$this->id))->getField('title');
		$this->meta_title = "标签：". $labelname . '客户列表';
		$tabel = "{$this->prefix}customer AS c";
		$join = " JOIN {$this->prefix}customer_label AS cl ON c.id=cl.customer_id ";
		$join .=" JOIN {$this->prefix}customerlabel AS l ON cl.labelid=l.id ";
		//搜索条件
		$where['l.id']=$this->id;
		//按姓名搜索
		if(isset($_GET['realname'])){
			$where['c.realname']    =   array('like', '%'.(string)I('realname').'%');
		}
		//搜索字段
		$field = "c.id,c.realname,c.create_time,l.title";
		$model = M('')->table($tabel)->join($join)->where($where)->group('c.id');
		//查询结果
		$userlist = $this->lists( $model , null , 'c.id DESC' , null , $field );
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
		$customer_id=I('customer_id',null,'intval');
		if( $customer_id && $this->id){	
			M('customer_label')->where(array('customer_id'=>$customer_id,'labelid'=>$this->id))->delete();
			$this->success('移除成功' , cookie('__forward__'));
		}else{
			$this->error('非法操作');
		}
	}
	
}
