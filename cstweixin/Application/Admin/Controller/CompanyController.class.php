<?php
namespace Admin\Controller;
use Think\Page;
class CompanyController extends AdminController {
	protected $model ;
	protected $id;
	public function _initialize(){
		parent::_initialize();
		$this->model = D('Company');
		$this->id = I('id',null,'intval');
	}
	public function index(){
		$map=array();
		$this->meta_title = '公司或部门管理';
		//get地址栏参数，查询
		if(isset($_GET['keywords'])){
			$map['title']    =   array('like', '%'.(string)I('keywords').'%');
		}
		$lists = $this->lists( 'Company' , $map , 'id DESC');
		$lists = list_to_tree( $lists , 'id' , 'pid' , '_child' , 0 );//无级级分类
		$this->assign( 'indexlist' , $lists );
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	public function add(){
		$pid = I('pid',null,'intval');
		$this->meta_title = '新增公司或部门管理';
		$company = $this->model->field('id,title')->where(array('pid'=>0))->select();
		//公司列表
		foreach ( $company as $k=>&$v ){
			$v['selected'] = $v['id'] ==  $pid ? "selected='selected'" : '';
		}
		$this->company = $company;
		$this->display();
	}
	public function edit(){
		$this->meta_title = '编辑公司或部门管理';
		$field = $this->model->find($this->id);
		//公司列表
		$company = $this->model->field('id,title')->where(array('pid'=>0))->select();
		foreach ( $company as $k=>&$v ){
			$v['selected'] = $v['id'] ==  $field['pid'] ? "selected='selected'" : '';
		}
		$this->field = $field ;
		$this->company = $company;
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
}
