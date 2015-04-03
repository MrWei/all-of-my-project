<?php
namespace Admin\Model;
use Think\Model;

/**
 * 分类模型
 */
class UsersModel extends Model{
	/* 用户模型自动验证 */
	protected $_validate = array(
			array('realname', 'require', "真实姓名不能为空",  self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
			array('email',    '/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/', 	 "邮箱格式有误",   self::VALUE_VALIDATE, 'regex',   self::MODEL_BOTH),
			array('email',    '',       '邮箱已经存在',     self::VALUE_VALIDATE, 'unique', self::MODEL_BOTH),
			array('gid', 'require', "请选择用户分组",        self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
			array('code', 'require', "请输入邀请码",        self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
			array('code', '6,18',    '邀请码至少6个字符',         self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
			array('code',   '', '邀请码已存在', self::VALUE_VALIDATE, 'unique'), //手机号被占用
	);
	
	/* 用户模型自动完成 */
	protected $_auto = array(
			array('status', '1', self::MODEL_INSERT, 'string'),
			array('reg_time', 	 'time' , self::MODEL_INSERT , 'function'),
			array('update_time', 'time' , self::MODEL_UPDATE , 'function'),
	);
	/**
	 *
	 * @return Ambigous <number, boolean, unknown>|string
	 */
	public function update(){
		/* 获取数据对象 */
		$data = $this->create();
		if(empty($data)){
			return false;
		}
		$id = $this->add(); //添加基础内容
		if(!$id){
			$this->error = '新增失败！';
			return false;
		}
		//内容添加或更新完成
		return $data;
	}

}