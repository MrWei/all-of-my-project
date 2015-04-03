<?php
namespace Home\Controller;

/**
 * 文档模型控制器
 * 文档模型列表和详情
 */
class ArticleController extends HomeController {
	public function _initialize(){
		parent::_initialize();
		
	}
	/* 文档模型列表页 */
	public function lists($p = 1){
		/* 分类信息 */
		$category = $this->category();

		/* 获取当前分类列表 */
		$Document = D('Document');
		$list = $Document->page($p, $category['list_row'])->lists($category['id']);
		if(false === $list){
			$this->error('获取列表数据失败！');
		}
		/* 模板赋值并渲染模板 */
		$this->assign('category', $category);
		$this->assign('list', $list);
		$this->display($category['template_lists']);
	}

	/**
	 * 技术资资料搜索下载
	 */
	public function resource(){
		//当前页面加入cookie，登录成功时返回页面
		cookie('__forward__',$_SERVER['REQUEST_URI']);
		$userid = cookie('user_id') ? cookie('user_id') : redirect(U('Public/login'));
		/* 分类信息 */
		$category = $this->category( ACTION_NAME );
		//get得到的参数
		$time = I('get.time');
		$this->assign( 'time' , $time );
		$cateid = I('get.cateid');
		$this->assign( 'cateid' , $cateid );
		//组合分配数据开始
		$data= array();
		//产品资料分类下拉列表
		$data['time_search'] = C('TIME_SEARCH');
		$data['product_class'] = M('category')->field('id,title')->where(array('pid'=>$category['id']))->select();
		//查询模型
		$table = "{$this->prefix}document AS d";
		$join = " JOIN {$this->prefix}document_download AS dd ON d.id=dd.id";
		$field = "d.title,d.id,dd.vision";
		if( $time ){
			switch ( $time ){
				case 1:
					
				break;
				case 2:
					$where['d.create_time'] = array( 'egt' , NOW_TIME-60*60*24*30 );
				break;	
			}
		}
		//分类的子集
		//组合查询条件
		$ids  = array();
		foreach ( $data['product_class'] as $k=>$v ){
			$ids[$k] = $v['id'];
		}
		if( $cateid ){
			$where['d.category_id'] = $cateid;
		}else{
			$where['d.category_id'] = array( 'in' , $ids );
		}
		$model = M('')->table($table)->join($join);
		$resource = $this->infolists( $model , $where , null , null , $field , 20 );
		$this->assign( 'info' , $resource );
		$data['classname'] = '技术资料';
		$this->data = $data;
		$this->display($category['template_lists']);
	}
	
	
	
	/* 文档模型详情页 */
	public function detail($id = 0, $p = 1){
		/* 标识正确性检测 */
		if(!($id && is_numeric($id))){
			$this->error('文档ID错误！');
		}
		$this->id = $id;
		/* 页码检测 */
		$p = intval($p);
		$p = empty($p) ? 1 : $p;
		/* 获取详细信息 */
		$Document = D('Document');
		$info = $Document->detail($id);
		if(!$info){
			$this->error($Document->getError());
		}

		/* 分类信息 */
		$category = $this->category($info['category_id']);

		/* 获取模板 */
		if(!empty($info['template'])){//已定制模板
			$tmpl = $info['template'];
		} elseif (!empty($category['template_detail'])){ //分类已定制模板
			$tmpl = $category['template_detail'];
		} else { //使用默认模板
			$tmpl = 'Article/'. get_document_model($info['model_id'],'name') .'/detail';
		}

		/* 更新浏览数 */
		$map = array('id' => $id);
		$Document->where($map)->setInc('view');
		/* 模板赋值并渲染模板 */
		$this->assign('category', $category);
		$this->assign('info', $info);
		$this->assign('page', $p); //页码
		$this->display($tmpl);
	}

	/**
	 * 查看分类的信息
	 * @param number $id
	 * @return 当前分类
	 */
	private function category($id = 0){
		/* 标识正确性检测 */
		$id = $id ? $id : I('get.category', 0);
		if(empty($id)){
			$this->error('没有指定文档分类！');
		}

		/* 获取分类信息 */
		$category = D('Category')->info($id);
		if($category && 1 == $category['status']){
			switch ($category['display']) {
				case 0:
					$this->error('该分类禁止显示！');
					break;
				//TODO: 更多分类显示状态判断
				default:
					return $category;
			}
		} else {
			$this->error('分类不存在或被禁用！');
		}
	}

}
