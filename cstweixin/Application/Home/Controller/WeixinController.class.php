<?php
namespace Home\Controller;
use Think\Weixin\Wechat;
use Think\Weixin\WechatAuth;
/**
 * 前台首页控制器
 * 主要获取首页聚合数据
 */
class WeixinController extends HomeController {
	//初始化
	private $token;
	private $appid; //微信appid
	private $secret; //微信appsecret
	public function _initialize(){
		parent::_initialize();
		$this->token = trim(C('WX_TOKEN'));
		$this->appid = trim(C('WX_APPID'));
		$this->secret = trim(C('WX_APPSECRET'));
	}
	public function index(){
		/* 加载微信SDK */
		$wechat = new \Think\Weixin\Wechat( $this->token );
		/* 获取请求信息 */
		$data = $wechat->request();
		/* 获取回复信息 */
		list($content, $type) = $this->reply($data);
		/* 响应当前请求 */
		$wechat->response($content, $type);
	}
	/**
	 * 组合响应类型+数据
	 * @param  $data  类型  和 数据
	 * @return 响应的数据
	 */
	private function reply($data){
		$reply = array();
		switch ( $data['MsgType'] ){
			//接收到的微信信息的类型为事件时
			case 'event':
					switch ( $data['Event'] ){
						//用户关注事件
						case 'subscribe':
							$this->save_user( $data['FromUserName'] );
							$reply = $this->get_subscribe();
							break;
						case 'CLICK':
							$reply = $this->get_keywords_data( $data['EventKey'] );
							break;	
					}
				break;
			case 'text':
				$keywords = htmlspecialchars(trim($data['Content']));
				$data['openid'] = $data['FromUserName'] ;
				$data['content'] = $keywords;
				$data['create_time'] = NOW_TIME;
				M('chat')->add($data);
				M('weixin_uesrs')->add($data);
				$reply = $this->get_keywords_data( $keywords , $data['FromUserName'] );
				break;
		}
		return $reply;
	}
	
	/**
	 * 关键词处理,反回匹配的信息
	 * 前台查询客户的资料		@张三
	 * 前台增加客户			姓名%电话%邮箱%公司%部门%职位%标签1&标签2&标签3&标签4&标签5&标签6&标签7&标签8&标签9&标签10
	 * 					yes 删除用户标签
	 * 					no  不修改标签
	 * 					张三%13888888888%13888888888@qq.com%北京索为高科系统技术有限公司
	 */
	protected function get_keywords_data( $keywords , $openid='' ){
		$reply = array();//返回的数据
		$length = mb_strlen($keywords, 'utf8');//字符串的长度
		//查询客户资料
		if( strpos($keywords, '@')===0 )
		{
			//如果只输入了@
			if( substr_count($keywords, '@')==1 && $length==1 ){
				
				$data = $this->get_all_company();
			}
			//如果入了@且同时字符串长度大于1
			elseif( substr_count($keywords, '@')==1 && $length>1 ){
				
				$data = $this->get_customer($keywords, $openid);
				
			}
			//如果入了@@且同时字符串长度大于1
			elseif ( substr_count($keywords, '@')==2 && $length>1 ){
				
				$data = $this->get_customer($keywords, $openid, $type=2 );
			}
				
		}
		//修改客户资料
		elseif(strpos($keywords, '#')===0)
		{
			if( substr_count($keywords, '#')==1 && $length>1 ){
		
				$keywords = mb_substr($keywords, 1);
				//模糊匹配条件
				$where['realname'] = array('like', '%'.$keywords.'%');
				$info = M('customer')->where($where)->select();
				echo M('')->getLastSql();
				$data['content'] = "";
				foreach ( $info  as $v ){
					$data['content'] .= $v['realname'] . "%".$v['mobile'] . "%".$v['email'] . "%".get_user_company($v['companyid']) . "%" . get_user_company($v['departmentid']);
					$data['content'] .= "%".$v['job'] . "%" . get_customer_label($v['id']) . "%" . $v['id'] . "\n";
				}
				$data['type'] = 'text';
		
			}else {
				$data['content'] = '请回复"#+姓名"获取模版，复制后修改相关信息';
				$data['type'] = 'text';
			}
				
		}		
		//增加客户
		elseif ( substr_count($keywords, '%')==6 )  
		{
			
			$data = $this->saveCustomer($keywords, $openid);
		}

		elseif ( substr_count($keywords, '%')==7 ){
			$userbase = $this->get_userbase($openid);
			if( $userbase['save']==1 )
			{
				$data = $this->saveCustomer($keywords, $openid)	;
			}else
			{
				$data['content'] = "对不起，您不具备该权限!";
				$data['type'] = 'text';
			}
		}
		else{
			//查询关键词的信息
			$data = M('weixin_keywords')->field('type,content')->where(array('title'=>$keywords))->find();
			if(empty($data) ){
				$data = M('weixin_keywords')->field('type,content')->where(array('title'=>'?'))->find();
			}
		}
		//返回匹配消息
		switch ($data['type']) {
			case 'text':
				$content = strip_selected_tags($data['content']);
				$reply = array( htmlspecialchars_decode($content) ,  $data['type'] );
				break;
			case 'news':
				$prefix = C('DB_PREFIX');
				$join =" JOIN {$prefix}keywords_article AS ka ON d.id=ka.aid";
				$field ="d.id,d.title,d.cover_id,d.description";
				$info = M('')->table("{$prefix}document AS d")->field($field)->join($join)->where(array('ka.kid'=>$data['id']))->select();
				$res[] = array();
				foreach ( $info as $m=>$n ){
					$cover = get_cover($n['cover_id']);
					$title = $n['title'];
					$description = $n['description'];
					$url = C('SITE_DOMAIN') . U('Article/detail',array('id'=>$n['id']));
					$thumb_media_id = C('SITE_DOMAIN') .'/cst' . $cover['path'];
					$res[$m] = array( $title , $description , $url , $thumb_media_id );
				}
				$reply = array( $res ,  $data['type'] );
				break;
		}
		return $reply;
	}
	/**
	 * 查询用户关注时响应的信息，写入缓存，缓存不存在，生成缓存
	 */
	private function get_subscribe(){
		if( !F('subscribe') ){
			$subscribe = M('weixin_subscribe')->where(array('id'=>1))->getField('content');
			F( 'subscribe' , $subscribe);
		}
		$subscribe = strip_selected_tags( F('subscribe') );
		return array( $subscribe , 'text' );
	}
	/**
	 * 获取用户的分组id
	 * @param 用户的$openid
	 */
	protected function get_userbase( $openid ){
		$data  = array();
		if($openid ){
			$data = M('users')->field('gid,save')->where(array('openid'=>$openid))->find();
		}
		return $data;
	}
	/**
	 * 查询出所有的公司
	 * @return 返回给微信端的信息
	 */
	protected function get_all_company(){
		$data = array();
		$data['content'] = '';
		$company = M('company')->field('id,title')->where(array('pid'=>0))->order('id ASC')->select();
		
		foreach ( $company as $v ){
			$data['content'] .= 'NO.'.$v['id'] .' '. $v['title'] . "\n";
		}
		$data['content'] .="回复“@@+公司编号”查看公司内客户信息\n回复“@+姓名”搜索客户";
		$data['type'] = 'text';
		return $data;
	}
	/**
	 * 查询客户
	 * @param 关键词 $keywords
	 * @param 用户信息 $openid
	 * @param number $type
	 * @return 返回匹配的信息
	 */
	protected function get_customer( $keywords , $openid, $type=1){

		//处理用户关键词时第一步先取用户的gid
		$userbase = $this->get_userbase($openid );
		//判读用户的类型,普通用户返回空信息
		if( $userbase['gid'] == 2 ){
			switch ( $type ){
				case 1:
					//截取字符串得到姓名
					$data['content'] = $this->checkCustomer(substr($keywords, 1));
				break;
				case 2:
					//截取字符串得到姓名
					$keywords = substr($keywords,2);
					if(preg_match( "/^\d*$/", $keywords ) ){
						$data['content'] = $this->checkCustomer( $keywords, "此公司客户列表\n", false);
					}else {
						///关联查询信息
						$order = "convert(title using gbk)";
						//模糊匹配条件
						$where['title'] = array('like', '%'.$keywords.'%');
						//$where['c.title'] = array('like', '%'.$keywords.'%');
						//$where['_logic'] = 'OR';
						$where['pid'] = 0;
						$info = M('company')->field('id,title')->where($where)->order($order)->select();
						if( !empty($info) ){
							$data['content'] = "您是要找公司\n"	;
							foreach ( $info as $v ){
								$data['content'] .=  "NO." .$v['id'].' '. $v['title']."\n";
							}
							$data['content'] .= "请回复@@+公司编号查询";
						}else{
							$data['content'] = '查无此公司';
						}
						break;
					}
			}			
		}else{
			$data['content'] = '查无此' . $type==1 ? '用户' : '公司';
		}
		$data['type'] = 'text';
// 		var_dump($data);
		return $data;
	}
	/**
	 * 查询客户名
	 */
	private function checkCustomer( $keywords, $tips="您是要找\n", $customer=true){
		$content = '';
		$info = array();
		///关联查询信息
		$field = "u.id,u.realname,u.mobile,u.email,u.sex,u.create_time,u.companyid,u.departmentid,u.job,c.title AS company";
		$table = "{$this->prefix}customer AS u";
		$join = " JOIN {$this->prefix}company AS c ON u.companyid=c.id";
		$order = "convert(u.realname using gbk)";
		if(preg_match( "/^\d*$/", $keywords ) ){
			$customer ? $where['u.id'] = $keywords :  $where['c.id']=$keywords;
		}else{
			//模糊匹配条件
			$where['u.realname'] = array('like', '%'.$keywords.'%');
			//$where['c.title'] = array('like', '%'.$keywords.'%');
			//$where['_logic'] = 'OR';
		}
		$info = M('')->table($table)->field($field)->join($join)->where($where)->select();
		//如果匹配的信息为空,返回查无此用户
		//统计信息数量，如果大于1，返回列表
		if( !empty($info) ){
			if( count($info)>1 ){
				$content = $tips;
				foreach ( $info as $v ){
					$content .=  "NO." .$v['id'].' '. $v['realname']."\n";
				}
				$content .= "请回复@+客户编号查询客户信息";
			}else{
				$info = current( $info );
				$label = get_customer_label($info['id']);
				$info['sex_text'] = $info['sex'] ? '先生' : '女士';
				$content = '姓名：' . $info['realname'] . "\n" .'性别：'.$info['sex_text']. "\n" .'手机号：'. $info['mobile'] . "\n" ;
				$content .= '邮箱：' .$info['email']. "\n" . '公司：'.$info['company'] . "\n" . '部门：' . get_user_department($info['departmentid']). "\n" ;
				$content .= '职位：'.$info['job'] ."\n" ;
				$content .= $label ?  '标签：'. $label : '';
			}
		}else{
			$content = M('weixin_keywords')->where(array('title'=>'@'))->getField('content');
		}
		return $content;
	}
	/**
	 * 增加客户
	 * @param 关键词 $keywords
	 * @param 用户信息 $openid
	 * @return 返回匹配的信息
	 * 姓名%电话%邮箱%公司%部门%职位%标签1&标签2&标签3&标签4&标签5&标签6&标签7&标签8&标签9&标签10
	 */
	protected function saveCustomer( $keywords , $openid ){
		$userbase = $this->get_userbase( $openid );
		if( $userbase['gid'] ==2 ){
			$temp = array();//临时数组
			//将关键字拆分成数组
			$info = str2arr( $keywords , "%");
			//先判断是更新还是增加
			if( (substr_count($info[6], '!')< 10)  ){
				if( $info[7] && $info[3]){
					$customer = M('customer')->where(array('id'=> $info['7']))->find();
					$temp['realname'] =  $info[0] ; 	//客户真实姓名
					$temp['mobile']	  =  $info[1] ;		//客户手机号
					$temp['email'] 	  =  $info[2] ;		//客户邮箱
					//公司
					$companyid = M('company')->where(array('title'=>$info[3]))->getField('id');	//先判断公司是否存在
					$temp['companyid'] = $companyid ? $companyid :  M('company')->add(array('title'=>$info[3])); //客户公司的id
					//部门
					$data= array('title'=>$info[4],'pid'=>$temp['companyid']);
					$departmentid = M('company')->where($data)->getField('id');
					$temp['departmentid'] = $departmentid ? $departmentid : M('company')->add($data);
					//职位
					$temp['job'] 	= $info[5] ;			
					$temp['id'] = $info[7];
				}
				else{
					//组合用户信息
						$temp['realname'] = $info[0]; 	//客户真实姓名
						$temp['mobile'] = $info[1];		//客户手机号
						$temp['email'] = $info[2];		//客户邮箱
						$companyid = M('company')->where(array('title'=>$info[3]))->getField('id');	//先判断公司是否存在
						$temp['companyid'] = $companyid ? $companyid :  M('company')->add(array('title'=>$info[3])); //客户公司的id
						//客户的部门，可以为空
						if( $info[4] ){
							$data= array('title'=>$info[4],'pid'=>$temp['companyid']);
							$departmentid = M('company')->where($data)->getField('id');
							$temp['departmentid'] = $departmentid ? $departmentid : M('company')->add($data);
						}
						$temp['job'] = $info[5];	//职位
				}
			}else{
				$data['content'] = "客户的公司为空或者标签超过10个";
			}
			//保存或增加信息
			$model = D('Customer');
			if( $model->create($temp) && $customer_id = $model->update($temp) ){
				$temp['id'] ? $this->customer_label($info[6], $temp['id']) : $this->customer_label($info[6], $customer_id);
				$data['content'] = "操作成功!";
			}else{
				$data['content'] = $model->getError();
			}			
		}else{
			$data['content'] = M('weixin_keywords')->where(array('title'=>'?'))->getField('content');
		}
		$data['type'] = 'text';
		return $data;
	}
	/**
	 * 保存、修改用户标签
	 * @param string $str 		微信端发送的用户标签信息
	 * @param int $customer_id	客户的id
	 */
	private function customer_label( $str, $customer_id ){
				M('customer_label')->where(array('customer_id'=>$customer_id))->delete();
				$tmp = array();
				$label = str2arr($str, '!');
				foreach ( $label as $k=>$v ){
					$is_labelid = M('customerlabel')->where(array('title'=>$v))->getField('id');
					$tmp['labelid'] = $is_labelid ? $is_labelid : M('customerlabel')->add(array('title'=>$v,'create_time'=>time()));
					$tmp['customer_id'] = $customer_id;
					M('customer_label')->add($tmp);
				}
	}
	/**
	 * 打印测试信息
	 */
	public function testinfo(){
		$openid="o2AIEtzDbzdvaFHmaPk2pdTwxQbM";
// // 		$keywords ="@魏永";
		$keywords ="张腾腾2%13812341234%%615所%系统部%工程师%直接用户,建模，仿真%11";
// // 		$keywords ="@@所";
// 		$keywords ="@@11";
// // 		$keywords = "魏永%13612340001%13400200@qq.com%北京帕米%php开发布%程序员%标签01!标签02";
// // 		$keywords = "#姓名%13212340000%1340000@qq.com%腾讯%大渝网%经理%标签01!标签02%45";
// // 		$keywords = "#李四%18888888888%N%N%N%N%N%8";
		$data = $this->get_keywords_data($keywords, $openid);
		var_dump($data);
// 		 $this->save_user();
	}	
	/**
	 * 向微信请求获取用户信息
	 */
	public function User(){
		header("Content-type:text/html;Charset=utf-8");
		if ( !empty($_REQUEST['code'])) {
			$code = $_REQUEST['code'];
			$url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" . C('WX_APPID') . "&secret=" . C('WX_APPSECRET') . "&code=$code&grant_type=authorization_code";
			$con = file_get_contents($url);
			if (empty($con)) {
				$this->error('未知的错误');
			}
			$rs = json_decode($con, true);
			$userURL = "https://api.weixin.qq.com/sns/userinfo?access_token=$rs[access_token]&openid=$rs[openid]";
			$user = file_get_contents($userURL);
			//通过微信获取到用用户的信息
			$userdata = json_decode($user, true);
			$openid = $userdata['openid'];
			//原用户的信息
			$res = M('weixin_users')->field('nickname,sex,openid')->where(array('openid'=>$openid))->find();
			//用户的新信息
			$data['nickname'] = $userdata['nickname'];
			$data['sex'] = $userdata['sex'];
			//对比用户信息
			if( array_compare( $res , $data ) == false  ){
				//更新关注者信息
				$data['openid'] = $userdata['openid'];
				$data['nickname'] = $userdata['nickname'];
				$data['sex'] = $userdata['sex'];
				M('weixin_users')->where(array('openid'=>$openid))->save($data);
			}
			//用户登录时需要用到openid
			cookie('openid', $openid , 60*60*24*90 );
			//用户微信id
			$this->redirect(cookie('login'));
		}
	}
	/**
	 * 用户关注时立即保存用户信息
	 * 
	 * @param 用户的微信 $openid        	
	 */
	protected function save_user($openid='o2AIEtzDbzdvaFHmaPk2pdTwxQbM') {
		
		$res = M ( 'weixin_users' )->where ( array (
				'openid' => $openid 
		) )->find ();
		
		
		if (empty ( $res )) {
			// 实列化微信类
			$weixin = new WechatAuth ( $this->appid, $this->secret );
			// 生成accesstoken
			$weixin->getAccessToken ();
			// 执行获取用户信息方法
			$tmp = $weixin->userInfo ( $openid );
			$data = array ();
			$data ['openid'] = $openid;
			$data['nickname'] = $tmp['nickname'];
			$data ['sex'] = $tmp['sex'];
			$data ['create_time'] = NOW_TIME;
			M ( 'weixin_users' )->add ( $data );
		}
	}


}