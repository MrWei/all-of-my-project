<?php
namespace Home\Model;
use Think\Model;
/**
 * 文档基础模型
 */
class ProductModel extends Model{

	/* 自动验证规则 */
	protected $_validate = array(
		array( 'pid' , 'require' , '请选择产品' , self::EXISTS_VALIDATE  ),
		array( 'ptype' , 'require' , '请选择产品类型' , self::EXISTS_VALIDATE  ),
		array( 'p_desciption' , 'require' , '请输入产品问题咨询的描述' , self::EXISTS_VALIDATE  ),
	);
	/* 自动完成规则 */
	protected $_auto = array(
		array('title', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
		array('description', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
		array('create_time', NOW_TIME, self::MODEL_INSERT),
	);

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
	 * 
	 * @param $id 反馈信息的id
	 * @return boolean|string
	 */
	protected function save_keywords( $id ){
		$keywords = $_POST['keywords'];
		if( $keywords ){
			$keylist = str2arr( $keywords );
			$keylist = array_unique($keylist);//去除重复元素
			$kids = array();
			foreach ( $keylist as $k=>$v ){
				$kid = M('productkey')->where(array('title'=>$v))->getField('id');//查询关键字是否存在
				//不存在增加关键字
				$data['title'] = $v;
				$data['create_time'] = NOW_TIME;
				$kids[$k]['kid'] = $kid ? $kid : M('productkey')->add($data);
				$kids[$k]['pid'] = $id;
			}
			if(M('pro_key')->addAll($kids)){
				return true;
			}else{
				return $this->getError();
			}
		}else{
			return true;
		}
	}
	
}
