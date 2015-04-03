<?php
namespace Home\Model;
use Think\Model;
/**
 * 文档基础模型
 */
class TechnologyModel extends Model{

	/* 自动验证规则 */
	protected $_validate = array(
		array( 'title' , 'require' , '请输入技术问题咨询的标题' , self::EXISTS_VALIDATE  ),
		array( 'p_description' , 'require' , '请输入技术问题咨询的描述' , self::EXISTS_VALIDATE  ),
	);

	/* 自动完成规则 */
	protected $_auto = array(
		array('title', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
		array('description', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
		array('create_time', NOW_TIME, self::MODEL_INSERT),
	);
	/**
	 * 保存用户的反馈信息
	 */
	public function update(){
		if( $this->create()){
			$id = $this->add();
			$this->save_keywords($id);
			return $id;
		}else{
			$this->getError();
		}
	}
	/**
	 * 反馈信息的关键字
	 */
	protected function save_keywords( $id ){
		$keywords = $_POST['keywords'];
		if( $keywords ){
			$keylist = str2arr( $keywords );
			$keylist = array_unique($keylist);//去除重复元素
			$kids = array();
			foreach ( $keylist as $k=>$v ){			
				$kid = M('technologykey')->where(array('title'=>$v))->getField('id');//查询关键字是否存在
				//不存在增加关键字
				$data['title'] = $v;
				$data['create_time'] = NOW_TIME; 
				$kids[$k]['kid'] = $kid ? $kid : M('technologykey')->add($data);
				$kids[$k]['tid'] = $id;
			}
			if(M('tech_key')->addAll($kids)){
				return true;
			}else{
				return $this->getError();
			}
		}else{
			return true;
		}
	}
	
}
