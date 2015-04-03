<?php
namespace Admin\Model;
use Think\Model;
/** 
* 微信墙模型 
* @author  Weiyong <weiyong.me@qql.com> 
*/ 
class QiangModel extends Model{
	
	/* 自动验证规则 */
	protected $_validate = array(
		array('title', 'require',	'活动名称不能为空', 	self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
		array('title', '1,120', 	'活动名称长度不能超过120个字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
		array('stitle', 'require', 	'大屏幕标题不能为空', 	self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
		array('stitle', '1,120', 	'大屏幕标题长度不能超过60个字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
		array('starttime', 'require', '活动开始时间不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
		array('starttime', 'chck_starttime', '活动开始时间不能小于当前时间', self::VALUE_VALIDATE, 'callback', self::MODEL_BOTH),
		array('endtime', 'require', '活动结束时间不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
		array('wxtoken', 'require', '微信token不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
			
	);
	/* 自动完成规则 */
	protected $_auto = array(
		array('is_dev', 'is_dev_auto', self::MODEL_BOTH, 'callback'),
	);
	/**
	 * 新增或更新一个行为
	 * @return boolean fasle 失败 ， int  成功 返回完整的数据
	 * @author huajie <banhuajie@163.com>
	 */
	public function update(){
		$data = $this->create();
		if(empty($data)){
			return false;
		}
		/* 添加或新增行为 */
		if(empty($data['id'])){ //新增数据
			$id = $this->add(); //添加行为
			if(!$id){
				$this->error = '新增出错！';
				return false;
			}
		} else { //更新数据
			$status = $this->save(); //更新基础内容
			if(false === $status){
				$this->error = '更新出错！';
				return false;
			}
		}
		return $data;
	}
	/**
	 * 开始时间判断
	 */
	protected function chck_starttime()
	{
		$starttime = I('post.starttime');
		return strtotime($starttime) > time() ? TRUE : FALSE;
	}
	/**
	 * 自动保存签到方式
	 */
	protected function is_dev_auto(){
		$is_dev = I('post.is_dev');
		return json_encode($is_dev);
	}
	
}