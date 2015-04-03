<?php
namespace Admin\Model;
use Think\Model;
/**
 * 分类模型
 */
class CustomerlabelModel extends Model{
	
	protected $_validate = array(
			array('title', 'require', '标签名不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
			array('title', '', '标签已经存在', self::VALUE_VALIDATE, 'unique', self::MODEL_BOTH),
	);
	
	/* 自动完成规则 */
	 protected $_auto = array(
//         array('create_time', 'time', self::MODEL_INSERT, 'function'),
//     	array('update_time', 'time', self::MODEL_UPDATE, 'function'),
    );
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
				$this->error = '新增标签出错！';
				return false;
			}
		} else { //更新数据
			$status = $this->save(); //更新基础内容
			if(false === $status){
				$this->error = '更新标签出错！';
				return false;
			}
		}
	
		//内容添加或更新完成
		return $data;
	
	}	

}