<?php
namespace Admin\Model;
use Think\Model;
/**
 * 分类模型
 */
class ProductkeyModel extends Model{
	
	protected $_validate = array(
			array('title', 'require', '关键词不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
			array('title', '', '关键词已经存在', self::VALUE_VALIDATE, 'unique', self::MODEL_BOTH),
	);
	
	/* 自动完成规则 */
	 protected $_auto = array(
        array('create_time', 'time', self::MODEL_INSERT, 'function'),
    	array('update_time', 'time', self::MODEL_UPDATE, 'function'),
    );
	
	 
	 
	 
	protected function _after_find(&$result,$options) {
		$result['create_time'] = date('Y-m-d', $result['create_time']);
	}
	
	protected function _after_select(&$result,$options){
		foreach($result as &$record){
			$this->_after_find($record,$options);
		}
	}
	
	/* 获取编辑数据 */
	public function detail($id){
		$data = $this->find($id);
		return $data;
	}
	
	/* 禁用 */
	public function forbidden($id){
		return $this->save(array('id'=>$id,'status'=>'0'));
	}
	
	/* 启用 */
	public function off($id){
		return $this->save(array('id'=>$id,'status'=>'1'));
	}
	
	/* 删除 */
	public function del($id){
		return $this->delete($id);
	}
	
	/**
	 * 新增或更新一个文档
	 * @return boolean fasle 失败 ， int  成功 返回完整的数据
	 * @author huajie <banhuajie@163.com>
	 */
	public function update(){
		/* 获取数据对象 */
		$data = $this->create();
		if(empty($data)){
			return false;
		}
		/* 添加或新增基础内容 */
		if(empty($data['id'])){ //新增数据
			$id = $this->add(); //添加基础内容
			if(!$id){
				$this->error = '新增产品问题关键词出错！';
				return false;
			}
		} else { //更新数据
			$status = $this->save(); //更新基础内容
			if(false === $status){
				$this->error = '更新产品问题关键词出错！';
				return false;
			}
		}
	
		//内容添加或更新完成
		return $data;
	
	}	

}