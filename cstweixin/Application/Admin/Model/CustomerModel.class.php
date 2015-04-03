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
class CustomerModel extends Model {
    /* 自动验证规则 */
    protected $_validate = array(
    	array( 'realname' , 'require' , -1 , self::EXISTS_VALIDATE  ),
    		
    	array( 'mobile'	  ,	'require' , -2 , self::EXISTS_VALIDATE  ),
    	array( 'mobile'	  ,	'/^[1][3578]\d{9}$/'  , -3 , self::VALUE_VALIDATE ),
    	array( 'mobile'   , '' 		  , -4 , self::VALUE_VALIDATE , 'unique' ),
    		
    	array( 'email'    , 'email'   , -6 , self::VALUE_VALIDATE ),
    	array( 'email'    , '' 		  , -7 , self::VALUE_VALIDATE , 'unique' ),
    		
    );
    /* 自动完成规则 */
    protected $_auto = array(
    	array('sex', 1, self::MODEL_INSERT, 'string'),
        array('create_time', 'time', self::MODEL_INSERT, 'function'),
    	array('update_time', 'time', self::MODEL_UPDATE, 'function'),
    );
    public function update(){
    /* 添加用户 */
		$data = $this->create();
		if($this->create()){
			if(empty($data['id']) ){
				$uid = $this->add();
				$this->save_customer_label($uid);
			}else{
				$uid = $this->save();
				$this->save_customer_label( $data['id']);
			}
			return $uid ? $uid : 0; //0-未知错误，大于0-注册成功
		} else {
			return $this->getError(); //错误详情见自动验证注释
		}
    }
    /**
     * 客户标签
     */
    protected function save_customer_label( $id ){
    	$label = I('label',null);
    	M('customer_label')->where(array('customer_id'=>$id))->delete();
    	if( $label ){
    		$labellist = str2arr( $label );
    		$labellist = array_unique($labellist);//去除重复元素
    		$label = array();
    		foreach ( $labellist as $k=>$v ){
    			$labelid = M('customerlabel')->where(array('title'=>$v))->getField('id');//查询关键字是否存在
    			//不存在增加关键字
    			$data['title'] = $v;
    			$data['create_time'] = NOW_TIME;
    			$labels[$k]['labelid'] = $labelid ? $labelid : M('customerlabel')->add($data);
    			$labels[$k]['customer_id'] = $id;
    		}
    		M('customer_label')->where(array('customer_id'=>$data['id']))->delete();
    		if(M('customer_label')->addAll($labels)){
    			return true;
    		}else{
    			return $this->getError();
    		}
    	}
    	return true;
    }
    
    
}
