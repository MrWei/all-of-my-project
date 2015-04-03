<?php
namespace Admin\Controller;
use Admin\Model\WeixinmenuModel;
use Think\Page;
use Think\Weixin\WechatAuth;
/**
 * 后台用户控制器
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
class WeixinController extends AdminController {
	private $_Menu;
	private $token;
	private $appid; //微信appid
	private $secret; //微信appsecret
	public function _initialize(){
		parent::_initialize();
		$this->_Menu = D('Weixinmenu');
		$this->assign( 'ActionName', ACTION_NAME );
		$this->token = trim(C('WX_TOKEN'));
		$this->appid = trim(C('WX_APPID'));
		$this->secret = trim(C('WX_APPSECRET'));
	}
	/**
	 * 关注回复
	 */
	public function subscribe(){
		$id = 1;
		if( IS_POST ){
			$data['content'] = htmlspecialchars($_POST['content']);
			$res = M('weixin_subscribe')->where(array('id'=>$id))->save($data);
			$this->success( '保存成功' , U('subscribe') ,true );
		}
		$subscribe = M('weixin_subscribe')->where(array('id'=>$id))->getField('content');
		$this->content = $subscribe;
		$this->display();
			
	}
	############################################################################################	
	public function menu(){
		$listmenu = $this->_Menu->order('sort ASC')->select();
		$this->listmenu = list_to_tree($listmenu);
		//返回地址保存到cookie
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->display();
	}
	 public function addmenu(){
	        if(IS_POST){
	        	if( $_POST['pid']){
	        		$count = $this->_Menu->where(array('pid'=>intval($_POST['pid'])))->count('id');
	        		if( $count>4 )$this->error('二级菜单最多5个');
	        	}else{
	        		$count = $this->_Menu->where(array('pid'=>0))->count('id');
	        		if( $count>2 )$this->error('一级菜单最多3个');
	        	}
	        	if( $_POST['type']=='click' ){
	        		if( $_POST['key']==false )$this->error('请输入菜单的key值');
	        	}
	        	if( $_POST['type']=='view'  ){
	        		$preg = "/^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/";
	        		if($_POST['url']==false || preg_match($preg, $_POST['url'])==false) $this->error('菜单的链接为空或者格式有误');
	        	}
        		if( $this->_Menu->create() ){
        			$this->_Menu->add();
        			$this->success('操作成功',U('menu'));
        		}else{
        			$this->error( $this->_Menu->getError() );
	        	}
	        } else {
	        	$id = isset($_GET['id']) ? intval($_GET['id']) : null;
	        	$this->menu_one($id);
	        	$this->assign( 'responseTyep' , C('WX_RESPONSE_TYPE') );
	            $this->display();
	        }
	    }
	
	public function editmenu(){
		$id = I('id');
		if(IS_POST){
			if( $_POST['type']=='click' ){
				if( $_POST['key']==false )$this->error('请输入菜单的key值');
			}
			if( $_POST['type']=='view'  ){
				$preg = "/^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/";
				if($_POST['url']==false || preg_match($preg, $_POST['url'])==false) $this->error('菜单的链接为空或者格式有误');
			}
			if( $this->_Menu->create() ){
				$this->_Menu->where(array('id'=>$id))->save();
				$this->success('操作成功',U('menu'));
			}else{
				$this->error( $this->_Menu->getError() );
			}
		}else{
			$field = $this->_Menu->where(array('id'=>$id))->find();
			$this->menu_one($field['pid']);
			$this->assign( 'responseTyep' , C('WX_RESPONSE_TYPE') );
			$this->field = $field;
			$this->display();
		}
	}
	
	public function createmenu(){
		$submenu = array();//用于生成菜单的数组
		$field = "id,name,type,key,url";
		//查询所有的一级菜单
		$menu = M('weixin_menu')->field($field)->where(array('pid'=>0,'status'=>1))->order('sort ASC')->select();
		foreach ( $menu as $k=>$v ){
			//遍历一级菜单查询其下面子菜单
			$subnav = M('weixin_menu')->field($field)->where(array('pid'=>$v['id'],'status'=>1))->order('sort ASC')->select();
			if( empty($subnav) ){
				// 没有子菜单 的组合一级菜单
				$submenu[$k]['type'] = $v['type'];
				$submenu[$k]['name'] = $v['name'];
				if( $v['type'] == "click" ){
					$submenu[$k]['key'] = $v['key'];
				}else{
					$submenu[$k]['url'] = htmlspecialchars_decode($v['url']) ;
				}
				$submenu[$k]['sub_button'] = array();
			}else{
				//有子菜单时组合子菜单
				$submenu[$k]['name'] = $v['name'];
				foreach ( $subnav as $m=>$n ){
					$submenu[$k]['sub_button'][$m]['type'] = $n['type'];
					$submenu[$k]['sub_button'][$m]['name'] = $n['name'];
					if( $n['type'] == "click" ){
						$submenu[$k]['sub_button'][$m]['key'] = $n['key'];
					}else{
						$submenu[$k]['sub_button'][$m]['url'] = htmlspecialchars_decode($n['url']);
					}
					$submenu[$k]['sub_button'][$m]['sub_button'] = array();
				}
			}
		}
		//加载微信类
		$weixin = new WechatAuth( $this->appid, $this->secret );
		$weixin->getAccessToken();
		$res = $weixin->menuCreate($submenu);
		if( $res['errcode'] == 0 ){
			$this->success('生成菜单成功');
		}else{
			$this->error('生成菜单失败');
		}
	}
	/**
	 * 
	 * @param string $pid
	 */
	private function menu_one($pid=null){
		$menu = $this->_Menu->where(array('pid'=>0))->select();
		if( $pid ){
			foreach ($menu as &$v){
				$v['selected'] = $pid==$v['id'] ? "selected='selected'" : '' ;
			}
		}
		$this->assign('menu_one' , $menu);
	}
	
	////////////////////////////////////////////分割线//////////////////////////////////////////////////////////
	/**
	 * 关键字列表
	 */
	public function keywords(){
		if(isset($_GET['title'])){
            $map['title']    =   array('like', '%'.(string)I('title').'%');
        }
        //关键词列表
        $list = $this->lists('weixin_keywords',$map , 'id DESC');
        $this->assign('indexlist',$list);
        //返回链接地址写入cookie
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		//每次进入关键列表时清空session['key_nfo] 关键词
		unset($_SESSION['key_info']);
		$this->display();
	}

	/**
	 * 增加关键字，目前分两种 文本 ， 图文明 通过地址栏目传参type值
	 */
	public function addkeywords(){
		//通过type传参得到类型
		$type = trim(strip_tags(I('type')));
		//分配类型数据到页面
		$this->assign('type',$type);
		if(IS_POST){
			//当类型为text时
			if( $type == 'text' )
			{
				$dbText = D('KeyText');
				//通过表单验证 并执行增加数据，同时成功返回成功否则为假
				if( $dbText->create() && $dbText->add() ){ 
					$this->success('操作成功',U('keywords'));
				}else{
					$this->error($dbText->getError());
				}
			//当类型为news时
			}elseif( $type == 'news' )
			{
				//选 验证提交的图文信息的列表 是否为空
				$aid = array_unique($_POST['aid']);
				if( $aid  ){
					if(count($aid)>9) $this->error('图文列表最多9个');
				}else{
					$this->error('请选择图文的列表');
				}
				$dbNews = D('KeyNews');
				if( $dbNews->create() && $id = $dbNews->add() ){
					$data = array();
    				foreach ( $aid as $k=>$v ){
    					$data[$k]['kid']= $id;
    					$data[$k]['aid']= $v;
    				}
    				M('keywords_article')->addAll($data);
    				$this->success('操作成功', U('keywords'));
				}else{
					$this->error($dbNews->getError());
				}
			}
		}else{
			if( $type == 'text' )
			{
				$this->catetitle = '新增文本关键字';
				$this->display('addkeywords_text');
				
			}elseif( $type == 'news' )
			{
				$this->catetitle = '新增图文关键字';
				//通过前端地址栏传的关键字搜索信息
				if( !empty($_SESSION['key_info']) ){
					$this->assign( 'key_info' , $_SESSION['key_info'] );
				}
				$this->indexlist();
		        //返回链接地址写入cookie
				cookie('__forward__',$_SERVER['REQUEST_URI']);
				$this->display('addkeywords_news');
			}
				
		}
	}
	
	public function editkeywords(){
		$id = I('id');
		$type = trim(strip_tags(I('type')));
		$this->assign('type',$type);
		if(IS_POST){
			if( $type == 'text' )
			{
				$dbText = D('KeyText');
				if( $dbText->create() && $dbText->where(array('id'=>$id))->save() ){
					$this->success('操作成功',U('keywords'));
				}else{
					$this->error($dbText->getError());
				}
		
			}elseif( $type == 'news' )
			{
				//选 验证提交的图文信息的列表 是否为空
				$aid = array_unique($_POST['aid']);
				if( $aid  ){
					if(count($aid)>9) $this->error('图文列表最多9个');
				}else{
					$this->error('请选择图文的列表');
				}
				$dbNews = D('KeyNews');
				if( $dbNews->create() && $dbNews->where(array('id'=>$id))->save() ){
					M('keywords_article')->where(array('kid'=>$id))->delete();
					$data = array();
					foreach ( $aid as $k=>$v ){
						$data[$k]['kid']= $id;
						$data[$k]['aid']= $v;
					}
					M('keywords_article')->addAll($data);
					$this->success('操作成功', U('keywords'));
				}else{
					$this->error($dbNews->getError());
				}
			}
		}else{
			$field = M('weixin_keywords')->where(array('id'=>$id))->find();
			if( $type == 'text' )
			{
				$this->catetitle = '编辑文本关键字';
				$this->field = $field;
				$this->display('addkeywords_text');
		
			}elseif( $type == 'news' )
			{	
				$this->catetitle = '编辑图文关键字';
				//
				$prefix =C('DB_PREFIX');
				$table = "{$prefix}document AS d ";
				$join = "JOIN {$prefix}keywords_article AS ka ON d.id=ka.aid";
				$fields = "d.id,d.title";
				$where['ka.kid']=$id;
				//当前关键词加的信息加入seesion
				$key_info = M('')->table($table)->field($fields)->join($join)->where($where)->select();
				foreach ( $key_info as $v ){
					$_SESSION['key_info'][$v['id']] = array(
						'id' 	=> $v['id'],
						'title' => $v['title'] ,	
					);
				}
				//seesion[key_info]不为空时，分配图文信息
				if( !empty($_SESSION['key_info']) ){
					$this->assign( 'key_info' , $_SESSION['key_info'] );
				}
		       //信息列表
				$this->indexlist();
				$this->field = $field;
				$this->display('addkeywords_news');
			}
		
		}
	}
	//显示信息
	private function indexlist(  ){
		if(isset($_GET['title'])){
			$map['d.title']    =   array('like', '%'.(string)I('title').'%');
		}
		$map['d.cover_id'] = array('gt',0);
		//组合模型
		$table = "{$this->prefix}document AS d ";
		$join = "JOIN {$this->prefix}category AS c ON d.category_id=c.id";
		$field ="d.id,d.title,c.title AS category";
		$model =M('')->table($table)->join($join);	
		$order = "d.id DESC";
		$list = $this->lists( $model , $map , $order , null , $field);
		$this->assign('indexlist',$list);
	}
	/**
	 * 用户聊天记录
	 */
	public function chat(){
		$this->meta_title = "用户聊天记录";
		$order = "id DESC";
		$this->assign_users();
		
		$list = $this->lists( 'chat' , null , $order , null );
		$this->assign('indexlist',$list);
		$this->display();
	}
	/**
	 * 聊天信息搜索
	 */
	public function chatsearch(){
		//标题
		$this->meta_title = "搜索用户聊天记录";
		//排序方式
		$order = "id DESC";
		//请求的用户
		$map['openid'] = I('openid',null);
		//时间
		$statTime = strtotime(I('startTime'));
		$endTime = strtotime(I('endTime'));
		if( $statTime && $endTime ){
			$map['create_time'] = array('between' , array( $statTime , $endTime ));
		}
		//分配数据到
		//信息内容模糊匹配
		$keywords = htmlspecialchars(I('keywords'));
		$map['content'] = array( 'like',"%".$keywords."%" );
		//查询结果
		$list = $this->lists( 'chat' , $map , $order , null );
		$this->assign_users( $map['openid'] );
		$this->assign('indexlist',$list);
		$this->display();
	}
	/**
	 * 异步添加图文的文章 
	 */
	public function addnews()
	{
		if( IS_AJAX ){	
			$id = I('id','','intval');
			$data = M('document')->field('id,title')->where(array('id'=>$id))->find();
			//信息写入seesion
			if(!isset($_SESSION['key_info'][$id])){
					$_SESSION['key_info'][$id] = array(
						'id'	=>	$id,
						'title'	=>  $data['title'],
				);
			}			
			$this->ajaxReturn($data);
		}else{
			$this->error('页面不存在');
		}
	}
	/**
	 * 异步添加图文的文章
	 */
	public function removenews()
	{
		if( IS_AJAX ){
			$aid = I('aid',NULL,'intval');//文章id
			$kid = I('kid',NULL,'intval');//关键词id
			//清除加入SESSSION里文章id
			if(isset($_SESSION['key_info'][$aid])){
				unset($_SESSION['key_info'][$aid]);
			}
			//有关键词id里删除关键词
			if( $kid ){
				$data = M('keywords_article')->where(array('aid'=>$aid,'kid'=>$kid))->delete();
			}
		}else{
			$this->error('页面不存在');
		}
	}
	private function assign_users( $openid ){
		//分配用户列表
		$users = M('users')->field('openid,realname')->select();
		if( $openid ){
			foreach ( $users AS &$v ){
				$v['selected'] = $v['openid'] == $openid ? "selected='selected'" : '';
			}
		}
		$this->assign('users',$users);
	}
	
}
