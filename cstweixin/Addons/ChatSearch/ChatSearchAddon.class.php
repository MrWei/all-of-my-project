<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: yangweijie <yangweijiester@gmail.com> <code-tech.diandian.com>
// +----------------------------------------------------------------------


namespace Addons\ChatSearch;
use Common\Controller\Addon;

    class ChatSearchAddon extends Addon{

        public $info = array(
            'name'=>'ChatSearch',
            'title'=>'聊天信息搜索',
            'description'=>'后台首页聊天信息搜索',
            'status'=>1,
            'author' => 'pami',
            'version'=>'0.1'
        );

        public function install(){
            return true;
        }

        public function uninstall(){
            return true;
        }

        //实现的AdminIndex钩子方法
        public function AdminIndex($param){
            $config = $this->getConfig();
			//查询用户信息
            $users = M('users')->field('openid,realname')->select();
            $this->assign('users',$users);
            $this->assign('addons_config', $config);
            if($config['display']){
                $this->display('widget');
            }
        }
    }