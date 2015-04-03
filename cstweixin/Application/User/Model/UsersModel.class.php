<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------
namespace User\Model;
use Think\Model;
/**
 * 会员模型
 */
class UsersModel extends Model{
	/**
	 * 数据表前缀
	 * @var string
	 */
	protected $tablePrefix = UC_TABLE_PREFIX;
	protected $tableName = 'users';
	/**
	 * 数据库连接
	 * @var string
	 */
	protected $connection = UC_DB_DSN;

	/* 用户模型自动验证 */
	protected $_validate = array(
		array('realname', 'require', -1,  self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
// 		array('mobile',   'require', -2,  self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
		array('mobile',   '/^[1][3578]\d{9}$/', -3, self::VALUE_VALIDATE), //手机格式不正确 
		array('mobile',   '', -4, self::VALUE_VALIDATE, 'unique'), //手机号被占用
// 		array('email',    'require',  -5,  self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
		array('email',    '/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/', 	 -6,   self::VALUE_VALIDATE, 'regex',   self::MODEL_BOTH),
		array('email',    '',        -7,  self::VALUE_VALIDATE, 'unique', self::MODEL_BOTH),
// 		array('companyid',   'require', -8,  self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
// 		array('departmentid', 'require', -9,  self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
		//array('eid',   'require', -11, self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH), //用户已存在
		array('gid', 'require',  -12,        self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
		array('code', 'require', -13,        self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
		array('code', '6,18',    -14,         self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
		array('code',   '',  -15 , self::VALUE_VALIDATE, 'unique'), //手机号被占用
	);

	/* 用户模型自动完成 */
	protected $_auto = array(
		array('status', '1', self::MODEL_INSERT, 'string'),
		array('reg_time', 	 'time' , self::MODEL_INSERT , 'function'),
		array('update_time', 'time' , self::MODEL_UPDATE , 'function'),
		array('order','is_order',  self::MODEL_UPDATE, 'callback'), 
	);
	/**	
	 * 用户是否订阅或是取消订阅邮件
	 */
	protected function is_order(){
		if( $_POST['order'] ){
			return $_POST['order'];
		}else{
			return 0;
		}
	}		
	/**
	 * 
	 * @return Ambigous <number, boolean, unknown>|string
	 */
	public function register(){
		/* 添加用户 */
		$data = $this->create();
		if($this->create()){
			if(empty($data['id']) ){
				 if ( $uid = $this->add() ) {
				 	$this->save_users_label($uid);
				 }
				
			}else{
				if( $uid = $this->save() ){
					$this->save_users_label( $data['id'] );
				}
			}
			return $uid ? $uid : 0;
		} else {
			return $this->getError(); //错误详情见自动验证注释
		}
	}
	/**
	 * 获取用户信息
	 * @param  string  $uid         用户ID
	 * @return array                用户信息
	 */
	public function info($uid){
		$map = array();
		$user = $this->field('id,realname,email,mobile,eid,companyid,save,departmentid,reg_time,gid,openid,order,code')->where(array('id'=>$uid))->find();
		$user['company'] = get_user_company($user['companyid']);
		$user['department'] = get_user_company($user['departmentid']);
		$label = get_user_label($uid);
		$user['label'] = arr2str( $label );
		return  $user;
	}
	/**
	 * 保存用标签
	 */
	private function save_users_label( $uid ){
		$label = I( 'post.label' , NULL , 'trim,htmlspecialchars');
		$userlabel = array();
		if( $label ){
			$tags = str2arr( $label );
			$tags = array_unique($tags);//去重
			$old_tags = get_user_label($uid);
			///对比用户标签和原来的标签是否相同
			if( array_compare($tags, $old_tags) == false   ){
				//先删除用户旧的标签
				$res = M('user_label')->where(array('uid'=>$uid))->delete();
				foreach ( $tags as $k=>$v ){
					$lableid = M('label')->where(array('title'=>$v))->getField('id');
					$userlabel[$k]['labelid'] = $lableid ? $lableid : M('label')->add( array('title'=>$v) );
					$userlabel[$k]['uid'] = $uid;
				}
				M('user_label')->addAll($userlabel);
			}
		}
		return true;
	}
	/**
	 * 更新用户登录信息
	 * @param  integer $uid 用户ID
	 */
	protected function updateLogin($uid){
		$data = array(
			'id'              => $uid,
			'last_login_time' => NOW_TIME,
			'last_login_ip'   => get_client_ip(1),
		);
		$this->save($data);
	}
	
}
