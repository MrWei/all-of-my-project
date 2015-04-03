<?php
namespace Admin\Controller;
use Think\Page;
class TechnologykeyController extends AdminController {
	protected $model ;
	protected $id;
	private $_status=array();
	public function _initialize(){
		parent::_initialize();
		$this->model = D('Technologykey');
		$this->id = I('id');
		$this->_status = array(
				'status'=>array(
					0=>'<font color="red">待处理</font>',
					1=>'<font color="#0066cc">正在处理</font>',
					2=>'<font color="green">已回复</font>')
				);
	}
	public function index(){
	
		$this->meta_title = '技术问题关键词';
		$lists = $this->lists( $this->model , null , 'id DESC' , null ,'title,id' );
		$this->assign( 'indexlist' , $lists );
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	public function add(){
		$this->meta_title = '新增技术问题关键词';
		$this->display();
	}
	public function edit(){
		$this->meta_title = '编辑技术问题关键词';
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
		$labelname = M('technologykey')->where(array('id'=>$this->id))->getField('title');
		$this->meta_title = "关键词：". $labelname . '问题列表';
		$tabel = "{$this->prefix}technology AS t";
		$join ="JOIN {$this->prefix}users AS u ON t.uid=u.id";
		$join .= " JOIN {$this->prefix}tech_key AS tk ON t.id=tk.tid ";
		$join .=" JOIN {$this->prefix}technologykey AS tkey ON tkey.id=tk.kid ";
		//搜索条件
		$where['tkey.id']=$this->id;
		//搜索字段
		$field = "t.id,t.title,t.status,t.p_description,t.create_time,t.type,tkey.title AS keywods,u.realname";
		$model = M('')->table($tabel)->join($join)->where($where)->group('t.id');
		//查询结果
		$lists = $this->lists( $model , null , null , null , $field );
		int_to_string( $lists , $this->_status );
		$this->assign( 'indexlist' , $lists );
		//当前地址加入cookie方便返回
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	/**
	* 从标签中移除
	 */
	 public function remove(){
		$tid=I('tid',null,'intval');
		if( $tid && $this->id){
			M('tech_key')->where(array('kid'=>$this->id,'tid'=>$tid))->delete();
			$this->success('移除成功' , cookie('__forward__'));
		}else{
			$this->error('非法操作');
		}
	}
}
