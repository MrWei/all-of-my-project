<?php
namespace Admin\Controller;
/** 
* 活动大屏幕
* @author  Weiyong <weiyong.me@qql.com> 
*/ 
class ScreenController extends AdminController 
{
	/**
	 * 活动的id
	 * @var $eid
	 */
	private $eid;
	/**
	 * 当前活动的微信信息
	 * @var $options
	 */
	private $options = array();
	
	public function _initialize(){
		parent::_initialize();
		$this->eid = isset($_GET['eid']) ? intval($_GET['eid']) : $this->error('缺少参数');
		//缓存活动信息
		if( !F('activity_'.$this->eid) ){
			$this->activity_cache( $this->eid );
		}
		$this->options = F('activity_'.$this->eid);
		$this->assign( 'eid', $this->eid );
		$this->assign( 'field', $this->options );
	}
	
	/**
	 * 开幕墙
	 */
	public function index(){
		
		$this->display();		
	}
	
	


	public function weixinAjax(){
		var_dump(UID);
		//搜索字段
		$field = "cr.id,cr.keywords,cr.create_time,wu.nickname,wu.uid,wu.avatar";
		$map = array();
		$table = "{$this->prefix}chat_record AS cr ";
		$join ="LEFT JOIN {$this->prefix}weixin_users AS wu ON cr.uid=wu.uid";
		$map['cr.eid'] = $this->eid ;
		$map['cr.reply_id'] = 0;
		$model = M('')->table($table)->join($join);
		$listData = $this->lists( $model, $map, "cr.create_time ASC" , NULL, NULL, $field );
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////								//////////////////////////////////////////
/////////////////////////////								//////////////////////////////////////////
/////////////////////////////								//////////////////////////////////////////
/////////////////////////////								//////////////////////////////////////////
/////////////////////////////								//////////////////////////////////////////
/////////////////////////////								//////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	/**
	 * 许愿墙
	 */
	public function wish(){
		
		$this->display();
	}
	/**
	 * 微信墙
	 */
	public function Weixin(){
	
	
		$this->display();
	}
	/**
	 * 抽奖
	 */
	public function Luckdraw(){
		
		$this->display();
	}
	/**
	 * 评分
	 */
	public function score(){
	
		$this->display();
	}
	/**
	 * 闭幕墙
	 */
	public function closing(){
		$this->display();		
	}
	/**
	 * 要缓存活动信息的id
	 * @param integer $eid
	 */
	protected function activity_cache( $eid){
		$data = M('qiang')->where(array('id'=>$eid))->find();
		F('activity_'.$eid , $data );
	}
}
