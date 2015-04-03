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
use User\Api\UserApi;

/**
 * 文档基础模型
 */
class GetcodeModel extends Model{
	
	protected $_validate = array(
		array('username', 'require', '请输入您的姓名',  self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
		array('email',    'require', '请输入您的邮箱',  self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
		array('email', 'email','邮箱格式不正确', self::EXISTS_VALIDATE), //邮箱格式不正确
		array('email', '1,32', '邮箱长度不合法', self::EXISTS_VALIDATE, 'length'), //邮箱长度不合法
		array('email', '', '邮箱已存在', self::EXISTS_VALIDATE, 'unique'), //邮箱被占用		
		array('gid', 'require', '请选择类型',  self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
	);
	
	/**
	 * 自动填充
	 */
    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('status', 0, self::MODEL_INSERT),
    );


}
