<?php
namespace Home\Controller;
use User\Api\UsersApi;
class PublicController extends HomeController{
	public function _initialize(){
		parent::_initialize();
		$this->nav = 'nav1';
	}
	/**
	 * 前台用户登录
	 */
	public function login(){
		if( !empty(cookie('user_id')))$this->redirect(U('User/index'));
		if( IS_POST ){
			//判断邀请码，给用户分组
			$code = I('post.code','htmlspecialchars');
			if( $code == false ){
				$this->error('请输入邀请码');
			}
			//通过邀请码查询用户的信息
			$user = M('users')->field('id,gid,openid')->where( array( 'code'=>$code ) )->find();
			if( $user ){
				if( $user['openid'] ){//用户信息存在时， 对openid进行比较,相等则匹配
					if( cookie('openid') != $user['openid']){
						$this->error( '邀请码有误，请重新输入' );
					}
				}else{
					//没有Openid则保存用户的openid
					M('usrs')->where( array( 'code'=>$code ) )->setField( 'openid' , cookie( 'openid') );
				}
				cookie( 'user_gid' , $user['gid'] , 60*60*24*90 );
				cookie( 'user_id' , $user['id'] , 60*60*24*90 );
				$this->success( '成功' , cookie('__forward__')? cookie('__forward__') : U('User/index') );
			}else{
				$this->error( '请先申请邀请码' );
			}
		}else{
			cookie('login' , U('Public/login'));
			if(  cookie('openid')==false ){
				$link = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=".trim(C('WX_APPID'))."&redirect_uri=";
				$link .= urlencode(  C('SITE_DOMAIN') . U('Weixin/User') ) . "&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
				redirect( $link );
			}
			$this->display();
		}
	
	}
	/**
	 * 前台申请获取邀请码
	 */
	public function getcode(){
		if( IS_POST ){
			$model = D('Getcode');
			if( $model->create() ){
				if( $id = $model->add() ){
					session( 'getcode_id' , $id);//加申请成功的用户信息id加入sesstion
					$this->success( '提交成功' , U('getcodeok') );
				}else{
					$this->error('提交失败');
				}
			}else{
				$this->error($model->getError());
			}
		}else{
			$this->applyType = C('APPLY_TYPE');
			$this->display();
		}
	}
	/**
	 * 获取邀请码成功
	 */
	public function getcodeok(){
		if( session('getcode_id') ){
			$this->display();
		}else {
			redirect( U('getcode') );
		}
	}
	/**
	 * 退出登录
	 */
	public function loginOut(){
		cookie( 'user_gid' , null );
		cookie( 'user_id' , null );
		$this->success('退出成功', U('Public/login'));
	}
	
}