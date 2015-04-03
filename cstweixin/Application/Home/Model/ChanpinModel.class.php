<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Model;
use Think\Model;
use Think\Page;

/**
 * 文档基础模型
 */
class ChanpinModel extends Model{

	/* 自动验证规则 */
	protected $_validate = array(
	);

	/* 自动完成规则 */
	protected $_auto = array(
		array('create_time', NOW_TIME, self::MODEL_INSERT),
	);

    public $page = '';

	/**
	 * 获取详情页数据
	 * @param  integer $id 文档ID
	 * @return array       详细数据
	 */
	public function detail($id){
		echo 1;
		exit;
		/* 获取基础数据 */
		$info = $this->field(true)->find($id);
		if(!(is_array($info) || 1 !== $info['status'])){
			$this->error = '文档被禁用或已删除！';
			return false;
		}

		/* 获取模型数据 */
		$logic  = $this->logic($info['model_id']);
		$detail = $logic->detail($id); //获取指定ID的数据
		if(!$detail){
			$this->error = $logic->getError();
			return false;
		}

		return array_merge($info, $detail);
	}
}
