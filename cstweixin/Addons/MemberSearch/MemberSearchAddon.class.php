<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: yangweijie <yangweijiester@gmail.com> <code-tech.diandian.com>
// +----------------------------------------------------------------------


namespace Addons\MemberSearch;
use Common\Controller\Addon;

/**
 * 系统环境信息插件
 * @author thinkphp
 */

    class MemberSearchAddon extends Addon{

        public $info = array(
            'name'=>'MemberSearch',
            'title'=>'用户搜索',
            'description'=>'后台首页全部用户搜索',
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
		protected function conditon(){
			$data = array();
			if( F('userCondition') ){
				$data = F('userCondition');
			}else{
				//单位
				$data['company'] = M('company')->field('id,title')->where(array('pid'=>0))->select();
				//标签
				$data['label'] = M('label')->field('id,title')->where(array('pid'=>0))->select();
				//状态
				$data['label'] = M('label')->field('id,title')->where(array('pid'=>0))->select();
				$data['status'] = array(1=>'启用',0=>'禁用');
				F( 'userCondition' , $data );
			}
			return $data;
		}
        //实现的AdminIndex钩子方法
        public function AdminIndex($param){
            $config = $this->getConfig();
			$data= $this->conditon();
			$this->assign( 'field' , $data );
            $this->assign('addons_config', $config);
            if($config['display']){
                $this->display('widget');
            }
        }
    }