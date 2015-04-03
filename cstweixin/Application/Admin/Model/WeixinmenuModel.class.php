<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: huajie <banhuajie@163.com>
// +----------------------------------------------------------------------

namespace Admin\Model;
use Think\Model;

/**
 * 行为模型
 * @author huajie <banhuajie@163.com>
 */

class WeixinmenuModel extends Model {
	protected $tableName = 'weixin_menu';
    /* 自动验证规则 */
    protected $_validate = array(
       	array('name', 'require', '标识不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        	array('name', '', '标识已经存在', self::VALUE_VALIDATE, 'unique', self::MODEL_BOTH),
    	array('sort', '/^\d+$/', '排序格式有误', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
    );
    /* 自动完成规则 */
    protected $_auto = array(
        array('create_time', 'time', self::MODEL_INSERT, 'function'),
    	array('update_time', 'time', self::MODEL_UPDATE, 'function'),
    );

}
