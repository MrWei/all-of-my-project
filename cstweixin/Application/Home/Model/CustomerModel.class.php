<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: huajie <banhuajie@163.com>
// +----------------------------------------------------------------------

namespace Home\Model;
use Think\Model;
class CustomerModel extends Model {
    /* 自动验证规则 */
    protected $_validate = array(
    	array('realname', 'require', '客户姓名不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),

    	array('companyid', 'require', '客户公司不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    		
    	array( 'mobile'	  ,	'/^[1][3578]\d{9}$/'  , '电话为必填' , self::VALUE_VALIDATE ),
    	array( 'mobile'   , '' 		  , '手机号已经存在' , self::VALUE_VALIDATE , 'unique' ),
    		
//     	array( 'email'    , 'email'   , '邮箱格式有误' , self::VALUE_VALIDATE ),
//     	array( 'email'    , '' 		  , '邮箱已经存在' , self::VALUE_VALIDATE , 'unique' ),
    		
    );
    /* 自动完成规则 */
    protected $_auto = array(
    	array('sex', 1, self::MODEL_INSERT, 'string'),
        array('create_time', 'time', self::MODEL_INSERT, 'function'),
    	array('update_time', 'time', self::MODEL_UPDATE, 'function'),
    );
	/**
	 * 新增或更新一个文档
	 * @return boolean fasle 失败 ， int  成功 返回完整的数据
	 * @author huajie <banhuajie@163.com>
	 */
	public function update( $data ){
		/* 添加或新增基础内容 */
		if(empty($data['id'])){ //新增数据
			$id = $this->add(); //添加基础内容
			if(!$id){
				$this->error = '新增失败！';
				return false;
			}else{
				return $id;
			}
		} else { //更新数据
			$status = $this->save(); //更新基础内容
			if(false === $status){
				$this->error = '更新失败！';
				return false;
			}else{
				return $data['id'];
			}
		}
	}	
}
