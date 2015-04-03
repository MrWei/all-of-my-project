<?php
/** 
* 前端微信交互管理 
* @author  Weiyong <weiyong.me@qql.com> 
*/ 
namespace Home\Controller;
use Think\Weixin\Wechat;
use Think\Weixin\WechatAuth;
class WeixinController extends HomeController 
{
	/**
	 * 活动的id
	 * @var eid
	 */
	private $eid;
	/**
	 * 当前活动的微信信息
	 * @var $options
	 */
	private $options = array();
	public function _initialize()
	{
		parent::_initialize();
		//判断是不是有效的活动id
		isset( $_GET['eid'] ) ? $this->eid = intval($_GET['eid']) : $this->error('缺少参数');
		if( !F('activity_'.$this->eid) ){
			$this->activity_cache($this->eid);
		}
		$this->options = F('activity_'.$this->eid);
		if( empty($this->options) )$this->error('当前活动不存在');
		
	}
	/**
	 * 
	 */
    public function index()
    {
    	$wechat = new \Think\Weixin\Wechat( $this->options['wxtoken'] );
    	$data = $wechat->request();
    	list($content, $type) = $this->reply($data);
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
    					$text = label_replace($this->options, $this->options['placard']);
    					$this->save_wxuser( $data['FromUserName'] );
    					$reply = array( $text , 'text');
    					break;
    				case 'CLICK':
    					$reply = array( $data['Content'] , 'text');
    					break;
    			}
    			break;
    		case 'text':
    			$keywords = htmlspecialchars(trim($data['Content']));
    			$reply = $this->check_chat_record( $data['FromUserName'], $data['Content']);
    			break;
    	}
    	return $reply;
    }
    /**
     * 处理用户的信息
     * @param string $openid 用户对应微信的openid
     * @param string $keywords 用户发送的信息
     */
    protected function check_chat_record( $openid, $keywords ){
    	//查询出用户的uid
    	$data = array();
    	$uid = M('weixin_users')->where(array('openid'=>$openid))->getField('uid');
    	if( ! $uid ) return $data = array( '活动进行中，请重新关注我们', 'text' );
		// 判断用户是否已签到
		$res = M('wxuser_qiang')->where( array( 'uid'=>$uid,'eid'=>$this->eid) )->find();
		if( ! empty( $res ) )
		{
			$this->save_chat_record( $uid, $keywords, $this->eid );
			$url = 'http://' . $_SERVER['HTTP_HOST'] . U('home/Mobile/index',array('uid'=>$uid,'eid'=>$this->eid));
			$info = array();
			$info[0] = array( '微信上墙成功!请看现场大屏幕！' , $this->options['stitle'] , $url , 'http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a15f00518e.jpg' );
			$info[1] = array( '点击打开大屏障,查看所有的信息！' , $this->options['stitle'] , $url , 'http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a15f02da06.jpg' );
			$data = array( $info, 'news' );
		}
		else
		{
			$this->save_chat_record( $uid, $keywords );
			//判断用户的命令是不是上墙命令
			if( $keywords == $this->options['regis_cmd'] )
			{
				//保存用户信息到当前活动
				M('wxuser_qiang')->add( array( 'uid'=>$uid,'eid'=>$this->eid));
				//默认关注提示
				$str = '签到成功！'.PHP_EOL . PHP_EOL .'接下来您可以发送文字、表情、图片上墙咯，发送的信息将实时展示到现场大屏幕上！'.PHP_EOL . PHP_EOL .'提示：文字信息请控制在45个汉字以内！' ;
				$text = $this->options['regis_tips'] ? $this->options['regis_tips'] : $str;
				$data = array( $text, 'text' );
			}
			else
			{
				$text = label_replace($this->options, $this->options['placard']);
				$data = array( $text, 'text' );
			}
		}
    	return $data;
    }
    /**
     * 用户关注时保存用户信息
     * @param string $openid 用户的openid
     */
    protected function save_wxuser( $openid){
    	$data = array();
    	$data['nickname'] = '用户'.date('mdhi');
    	$data['openid'] = $openid;
    	$data['sex'] = 0;
    	$data['create_time'] = time;
    	M('weixin_users')->add($data);
    }
   
    /**
     * 保存用户的聊天信息
     * @param string $openid 用户对应微信的openid
     * @param integer $eid 用户签到后参加的活动
     * @param string $keywords 用户发送的信息
     */
    protected function  save_chat_record( $uid, $keywords, $eid=0 ){
    	$data = array('uid'=>$uid , 'eid'=>$eid , 'keywords'=>$keywords, 'create_time'=>time() ) ;
    	M('chat_record')->add($data);
    }
	/**    
	 * 信息测试
	 */
    public function test(){
    	
    }
    

}