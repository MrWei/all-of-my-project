<?php
/** 
* 信息交互大屏幕显示
* @author  Weiyong <weiyong.me@qql.com> 
*/ 
namespace Home\Controller;
class MobileController extends HomeController 
{
	/**
	 * 活动的id
	 * @var $eid
	 */
	private $eid;
	/**
	 * 参与活动的用户id
	 * @var $uid
	 */
	private $uid;
	/**
	 * 当前活动的微信信息
	 * @var $options
	 */
	private $options = array();
	
	public function _initialize()
	{
		parent::_initialize();
		//判断用户是否参已签到参与	
		$this->eid = isset($_GET['eid']) ? intval($_GET['eid']) : $this->error('缺少参数');	
		$this->uid = isset($_GET['uid']) ? intval($_GET['uid']) : $this->error('缺少参数');
		//
		$isPartake = M('wxuser_qiang')->where(array('uid'=>$this->uid,'eid'=>$this->eid))->find();
		if( ! $isPartake )$this->error( '当前用户未参与此活动' );
		//缓存活动信息
		if( !F('activity_'.$this->eid) ){
			$this->activity_cache($this->eid);
		}
		$this->options = F('activity_'.$this->eid);
		//分配信息
		$this->assign( 'eid', $this->eid );
		$this->assign( 'uid', $this->uid );
	}
    public function index(){
		$map = array();
		$table = "{$this->prefix}chat_record AS cr ";
		$join ="LEFT JOIN {$this->prefix}weixin_users AS wu ON cr.uid=wu.uid";
		$map['cr.eid'] = $this->eid ;
		$map['cr.reply_id'] = 0;
		
		$field = "cr.id,cr.keywords,cr.reply_name,cr.reply_id,cr.create_time,wu.nickname,wu.uid,wu.avatar";
		$model = M('')->table($table)->join($join);
		$chatList = $this->lists( $model, $map, "cr.create_time ASC", NULL, $field  );

    	$this->assign( 'chatList', $chatList );
    	$this->assign( 'field', $this->options );
    	$this->display();
    }
    
    public function ajaxData(){
    	if( IS_AJAX ){
    		
    		$table = "{$this->prefix}chat_record AS cr ";
			$join ="LEFT JOIN {$this->prefix}weixin_users AS wu ON cr.uid=wu.uid";
			$map['cr.eid'] = $this->eid ;
			$map['cr.reply_id'] = 0;
			
			$field = "cr.id,cr.keywords,cr.reply_name,cr.reply_id,cr.create_time,wu.nickname,wu.uid,wu.avatar";
			$model = M('')->table($table)->join($join);
			$chatList = $this->lists( $model, $map, "cr.create_time ASC", NULL, $field  );
			$this->ajaxReturn(array('status'=>1,'info'=>$chatList),'json');
    	}else{
    		$this->ajaxReturn(array('status'=>0),'json');
    	}
    	
    }
    
    
    
    public function test()
    {
//     	$data = M('chat_record')->where(array('id'=>11))->find();
//     	array_shift($data);
//     	$data['create_time'] = time();
//     	for ( $i=0 ;  $i<100;$i++  ){
//     		M('chat_record')->add($data);
//     	}
    	
    }

}