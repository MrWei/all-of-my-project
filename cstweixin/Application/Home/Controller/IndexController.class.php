<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;
use OT\DataDictionary;

/**
 * 前台首页控制器
 * 主要获取首页聚合数据
 */
class IndexController extends HomeController {
	public function _initialize(){
		parent::__destruct();
	}
	//系统首页
    public function index(){
//     	cookie('user_id',10);
//     	cookie('openid','o2AIEtzDbzdvaFHmaPk2pdTwxQbM');
    	$this->nav = 'nav1';
    	$this->display();
    }
}