<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><?php echo ($field["title"]); ?></title>
<meta name="keywords" content="<?php echo ($field["stitle"]); ?>">
<meta name="description" content="">
<link rel="stylesheet" href="/Public/Screen/css/common.css" />
<!--通用CSS样式-->
<link rel="stylesheet" href="/Public/Screen/css/default.css" />
<!--布局默认样式-->
<script type="text/javascript" src="/Public/static/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="/Public/Screen/js/highcharts.js"></script>
<script type="text/javascript" src="/Public/Screen/js/exporting.js"></script>
<style>
#boxControl #boxControl_ul li {
	color: #ffffff !important
}
</style>
</head>

<body style="background:url(/Public/Screen/images/bg.jpg) center top no-repeat;" onload="screen_init();">
<script>
//快捷件
function hotkey(){ 
	var event = arguments[0]||window.event;
	var ex = navigator.appName;
	var a = ex == 'Microsoft Internet Explorer' ? window.event.keyCode : event.which; 
	if(event.altKey){
		switch(a){
			case 37 : ;	
			case 38 : clickControl('top'); break;	
			case 39 : ;	
			case 40 : clickControl('next'); break;	
			case 79 : clickControl('change'); break;	
			
			case 50 : topQR('wx'); break;	
			case 75 : boxConItem('kaimuqiang'); break;	
			
			case 88 : boxConItem('xuyuanqiang'); break;	
			case 67 : boxConItem('choujiang'); break;				
			case 80 : boxConItem('weipingfen'); break;	
			case 66 : boxConItem('bimuqiang'); break;
			case 65 : boxConItem('dapingmu'); break;	
			case 82 : boxConItem('datiban'); break;	
				
				
			
			case 57 : cj_scroll_set(); break;	
			
		}
	}
}
document.onkeydown = hotkey; 

var catid = 101;
var id = 755;
var getModule = 'dapingmu';//默认模块

//菜单打开关闭js
var boxConSta=0;
function boxCon(status){
	if(boxConSta==0){
		$("#boxControl").animate({height:'40px'},200);
		$("#boxContGuide").attr("src","/Public/Screen/images/menu_guide_down.png");
		boxConSta = 1;
	}else{
		$("#boxControl").animate({height:'10px'},200);
		$("#boxContGuide").attr("src","/Public/Screen/images/menu_guide_up.png");
		boxConSta = 0;
	}
}

var now_module_name = '';


function default_load(name){
	
}
//展示模块的名称 模块载入时动画效果
function boxConItem(name){
	if(name=='kaimuqiang' || name=='bimuqiang'){
		$("#boxTop").addClass("none");
		$("#boxContent").css("height","766px");
		$("#kmq").css("height","766px");
		$("#bmq").css("height","766px");
	}else{
		$("#boxTop").removeClass("none");
		$("#boxContent").css("height","666px");
		$("#kmq").css("height","666px");
		$("#bmq").css("height","666px");
	}
	
	var boxContent = $("#boxContent .boxitem");
	if(boxContent.size()!=1){
		for (var i = 0; i < boxContent.size(); i++) {
			$(boxContent.get(i)).slideUp("slow");
		}
		$("#"+name).slideDown("slow");
	}
	eval(name+"(0);");
	
	now_module_name = name;
	
	eval("detectClickControl();");
}

//取随机数
function GetRandomNum(Min,Max){
	var Range = Max - Min;
	var Rand = Math.random();
	return(Min + Math.round(Rand * Range));   
}
//获取不重复数据
function getNotRepeatArray(items, num) {
   
	var arr = new Array();
	for(var i=0; i<items; i++){
		arr[i] = i+1;
	}
    var temp_array = new Array();
    for (var index in arr) {
        temp_array.push(arr[index]);
    }
   
    var return_array = new Array();
    for (var i = 0; i<num; i++) {
       
        if (temp_array.length>0) {
        
            var arrIndex = Math.floor(Math.random()*temp_array.length);
           
            return_array[i] = temp_array[arrIndex];
          
            temp_array.splice(arrIndex, 1);
        } else {
          
            break;
        }
    }
    return return_array;
}
//格式化时间
function formatDateTime(now, format){
	var d = new Date(parseInt(now));
	var year = d.getYear();
	var month = d.getMonth()+1;
	var date = d.getDate();
	var hour = d.getHours();
	var minute = d.getMinutes();
	var second = d.getSeconds();
	if(month<10) month = '0'+month;
	if(date<10) date = '0'+date;
	if(hour<10) hour = '0'+hour;
	if(minute<10) minute = '0'+minute;
	if(second<10) second = '0'+second;
	
	if(format=='mdhm') return month+'.'+date+' '+hour+":"+minute;
	else if(format=='md') return month+'.'+date;
	else if(format=='hms') return hour+':'+minute+':'+second;
	else if(format=='hm') return hour+':'+minute;
	
	
}
</script>
<div id="top" style="height:0; line-height:0; font-size:1px; overflow:hidden;">&nbsp;</div>
<script language="javascript" type="text/javascript">
	var wh = window.screen.availHeight; //浏览器有效高度
	// alert(wh)
	if(wh>768){
		var setH = Math.round((wh-768)/2);
		
	}
</script>
<div id="boxMain">
  <div id="boxTop">
    <ul>
      <li id="boxTop_logo"><img src="/Public/Screen/images/logo.png" /></li>
      <li id="boxTop_scroll">
        <div style="white-space:nowrap; overflow:hidden;" id="boxTop_scroll_div" class="none">
          <div id="boxTop_scroll_begin" style="margin:0 auto;"><?php echo ($field["title"]); ?></div>
          <div id="boxTop_scroll_end"></div>
        </div>
      </li>
      <li id="boxTop_pic"> <img src="http://wall.49109.com/uploadfile/2015/0129/20150129012935372.jpg" onClick="topQR('wx')" style="max-height:80px; max-width:140px;" /> </li>
    </ul>
    <script>
		
		var qr_time = 500;
		var qr_status = 0;
		function topQR(type){
			//alert('topQR');
			if(qr_status){
				$("#boxQR_"+type).animate({width:'0px', height:'0px'},qr_time);
				qr_status = 0;
			}else{
				$("#boxQR_"+type).animate({width:'1024px', height:'666px'},qr_time);
				qr_status = 1;
			}
		}
		function boxQR(type){
			//alert('boxQR');
			qr_status = 0;
			$("#boxQR_"+type).animate({width:'0px', height:'0px'},qr_time);
		}
		
		function ScrollImgLeft(){
			
			var abt_boxTop_width = parseInt($("#boxTop ul").css("width"));
			var abt_boxTop_logo_width = parseInt($("#boxTop_logo").css("width"));
			//var abt_boxTop_time_width = parseInt($("#boxTop_time").css("width"));
			var abt_boxTop_time_width = 140;
			var abt_boxTop_scroll_width = abt_boxTop_width-abt_boxTop_logo_width-abt_boxTop_time_width-30;
			$("#boxTop_scroll").css("width",abt_boxTop_scroll_width+'px');
			
			//alert('abt_boxTop_width='+abt_boxTop_width+',abt_boxTop_logo_width='+abt_boxTop_logo_width+',abt_boxTop_time_width='+abt_boxTop_time_width+',abt_boxTop_scroll_width='+abt_boxTop_scroll_width);
			
			var abt_wait_time = 20; 
			var boxTop_scroll = document.getElementById("boxTop_scroll"); 
			var boxTop_scroll_begin = document.getElementById("boxTop_scroll_begin"); 
			var boxTop_scroll_end = document.getElementById("boxTop_scroll_end"); 
			var boxTop_scroll_div = document.getElementById("boxTop_scroll_div"); 
			//boxTop_scroll_end.innerHTML = boxTop_scroll_begin.innerHTML; 
			function Marquee(){ 
				// 向左滚动代码
				/*
				if(boxTop_scroll_end.offsetWidth-boxTop_scroll_div.scrollLeft<=0){
					boxTop_scroll_div.scrollLeft-=boxTop_scroll_begin.offsetWidth;
				}else{
					boxTop_scroll_div.scrollLeft++;
				}*/
				
				// 字体缩小代码
				var boxTop_scroll_begin_fontsize = parseInt($(boxTop_scroll_begin).css("font-size"));
				//alert(abt_boxTop_scroll_width+','+boxTop_scroll_begin.offsetWidth+','+boxTop_scroll_begin_fontsize);
				if(boxTop_scroll_begin.offsetWidth > boxTop_scroll.offsetWidth){
					while(boxTop_scroll_begin.offsetWidth > boxTop_scroll.offsetWidth && boxTop_scroll_begin_fontsize>1){
						//alert('while:'+boxTop_scroll_begin_fontsize);
						boxTop_scroll_begin_fontsize--;
						$("#boxTop_scroll_begin").css("font-size",boxTop_scroll_begin_fontsize+"px");
					}
				}else if(boxTop_scroll_begin.offsetWidth < boxTop_scroll.offsetWidth){
					while(boxTop_scroll_begin.offsetWidth > boxTop_scroll.offsetWidth && boxTop_scroll_begin_fontsize<80){
						//alert('while:'+boxTop_scroll_begin_fontsize);
						boxTop_scroll_begin_fontsize--;
						$("#boxTop_scroll_begin").css("font-size",boxTop_scroll_begin_fontsize+"px");
					}
				}
			}
			//var MyMar = setInterval(Marquee, abt_wait_time);
			Marquee();
			document.getElementById("boxTop_scroll_begin").style.display = 'block';
		}
		
		$(document).ready(function(){
			$("#boxTop_scroll_div").removeClass("none");
			//ScrollImgLeft();
		});
        </script> 
  </div>
  <div id="boxQR_wx" class="boxQR" onClick="boxQR('wx')">
    <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%" height="100%">
      <tr>
        <td valign="middle" align="center"><img src=""></td>
      </tr>
    </table>
  </div>
  <div id="boxQR_wb" class="boxQR" onClick="boxQR('wb')">
    <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%" height="100%">
      <tr>
        <td valign="middle" align="center"><img src=""></td>
      </tr>
    </table>
  </div>
  <div id="boxContent"> 
    <script src="/Public/Screen/js/json.js"></script>
    <div id="kaimuqiang" class="boxitem">
      <div id="kmq"><?php echo ($field["kaimuqiang"]); ?></div>
      <script language="javascript">
		/* 开幕墙 JS*/
		var KAIMUQIANG_SWITCH = 1;	// 开关
		var KAIMUQIANG_STATUS = 0;	// 状态，0表示停止，1表示正在运行
		
		function kaimuqiang(jsonStr){
			if(jsonStr.length>0 && jsonStr!=0){
				// 将JSON字符串转换为JSON对象
				var jsonObj = JSON.parse(jsonStr);
				var objUpdate = jsonObj.update;		// 更新数据
				var objType = jsonObj.type;		// 数据类型：empty空的，restart重载
				var objRemove = jsonObj.remove;		// 清除数据
				
				// 开始处理数据
				// 处理要更新的数据
				if(objUpdate!=''){
					$("#kmq").html(objUpdate);
					if(objType=='restart' && now_module_name=='kaimuqiang') boxConItem('kaimuqiang');
				}
				// 处理要删除的数据
				if(objRemove!=''){
				}
			}else if(jsonStr==0){
				kmq();
			}
		}
		
		function kmq(){
		}
		</script> </div>

    <div id="xuyuanqiang" class="boxitem"> 
      <!-- 回收式 -->
      <div id="xyq" class="xyq1">
        <div style="height:636px; overflow:hidden; background:url(/Public/Screen/images/xyq_bg.png) right bottom no-repeat;">
          <ul id="xyq_list_stop" class="none">
          </ul>
          <ul class="xyq_list">
          </ul>
        </div>
      </div>
      <script>
		/* 大屏幕 JS*/
		var XUYUANQIANG_SWITCH = 1;	// 开关
		var XUYUANQIANG_STATUS = 0;	// 状态，0停止，1正在运行
		var XUYUANQIANG_CLICK = 1;		// 底部控制栏播放器状态，0停止，1运行
		
		var xyq_sn = 1;
		var xyq_run_time = 500;	// 运行时间
		var xyq_wait_time = 5*1000;	// 等待时间
		var xyq_up_px = 636;
		
		//var xyq_show_time = 0;	// 内容前面是否显示时间
		
		$(document).ready(function(){
			//window.setTimeout(xyq, xyq_wait_time);
			setInterval("xyq();", xyq_wait_time); 
		});
				
		function xuyuanqiang(jsonStr){
			if(jsonStr.length>0 && jsonStr!=0){
				// 将JSON字符串转换为JSON对象
				var jsonObj = JSON.parse(jsonStr);
				var objUpdate = jsonObj.update;		// 更新数据
				var objType = jsonObj.type;		// 数据类型：empty空的，restart重载
				var objRemove = jsonObj.remove;		// 清除数据
				// 开始处理数据
				$("#test2").text('xuyuanqiang:'+jsonStr);
				$("#test_xuyuanqiang").text('进入xuyuanqiang()');
				// 处理要更新的数据
				if(objUpdate!=''){
					XUYUANQIANG_SWITCH = 0;
					$("#test5").text('遍历前'+new Date().getTime()+';');
					var qdq_update = 0;	// 是否更新过签到墙信息
					$.each(objUpdate, function(k, v){
						var info = '<li><p><img src="'+v.avatar+'" class="avatar" />'+v.nickname+'：'+v.content+'</p></li>';
						//$(info).prependTo(".xyq_list").hide().slideDown('slow');
						if(XUYUANQIANG_CLICK){
							$(".xyq_list").prepend(info);
						}else{
							$("#xyq_list_stop").prepend(info);
						}
						//$("#test5").text($("#test5").text()+'遍历中'+new Date().getTime());
						
						// 更新签到墙部分
						var qdq_uid = $("#qdq_list #uid"+v.uid+" dt").text();
						var avatar = '';
						if(qdq_uid=='none'){
							avatar = v.avatar;
							if(avatar.indexOf("avatar.gif")>0) avatar = 'none';
							//alert('大屏幕 更新'+v.uid+' 的头像'+avatar+',呢称'+v.nickname)
							$("#qdq_list #uid"+v.uid+" dt").text(avatar);
							$("#qdq_list #uid"+v.uid+" dd").text(v.nickname);
							qdq_update = 1;
						}
						
					});
					
					if(now_module_name=='qiandaoqiang' && qdq_update) qdq_player(1);
					
					$("#test5").text($("#test5").text()+';遍历后'+new Date().getTime());
					if(XUYUANQIANG_CLICK){
						xyq_del_xyq_list();
					}
				}
				// 处理要删除的数据
				if(objRemove!=''){
					$("#test_xuyuanqiang").text('objRemove存在 objRemove='+objRemove);
					
					XUYUANQIANG_SWITCH = 0;
					$.each(objRemove, function(k, v){
						$(".xyq_list #cid"+v.cid).remove();
					});
					//$("#test_xuyuanqiang").text(jsonStr);
					XUYUANQIANG_SWITCH = 1;
				}
				
			}else if(jsonStr==0){
				XUYUANQIANG_STATUS = 1;
			}
		}
		
		// 删除多余的内容，随着上墙内容的动态更新，越来越多的内容导致滚动次数过多，因此在这里只保留20个内容
		var retain_page = 20;
		retain_page = retain_page * 3;
		function xyq_del_xyq_list(){
			//alert(xyq_sn);
			for( ; $(".xyq_list li").size()>retain_page ; ){
				//$("#test4").text($(".xyq_list li").size());
				$(".xyq_list li:last").remove();
			}
			
			//$(".xyq_list").animate({'margin-top':'0px'},xyq_run_time);
			//$(".xyq_list").animate({'margin-top':'0px'},xyq_run_time);
			//xyq_sn=1;
			$(".xyq_list").animate({'margin-top':'0px'},xyq_run_time);
			var xyq_nowsn2 = xyq_sn-1;
			$(".xyq_list li:eq("+xyq_nowsn2+") p").css({"width":"700px","height":"auto","margin-left":"0","margin-top":"0","padding":"20px"});
			//window.setTimeout(xyq_restart, xyq_wait_time*1.1);
			xyq_sn=1;
		}
		
		var xyq_bug_px = 15;
		//if(!-[1,]) xyq_bug_px = 30;
		//alert(xyq_bug_px);
		
		
		function xyq_mt(){
			//alert('a');
			var xyq_nowsn = xyq_sn-1;
			var px = xyq_sn*xyq_up_px;
			$(".xyq_list").animate({'margin-top':'-'+px+'px'},xyq_run_time);
			setTimeout("xyq_mttt("+xyq_nowsn+");", xyq_run_time+50);
			xyq_sn++;
		}
		function xyq_mtt(){
			//alert('a');
			var xyq_nowsn = xyq_sn-1;
			$(".xyq_list").animate({'margin-top':'0px'},xyq_run_time);
			setTimeout("xyq_mttt("+xyq_nowsn+");", xyq_run_time+50); 
			xyq_sn=1;
		}
		function xyq_mttt(xyq_nowsn){
			$(".xyq_list li:eq("+xyq_nowsn+") p").css({"width":"700px","height":"auto","margin-left":"0","margin-top":"0","padding":"20px"});
		}
		
		function xyq(){
			//alert('xyq');
			if(!XUYUANQIANG_CLICK) return false;
			if(XUYUANQIANG_SWITCH && XUYUANQIANG_STATUS){
				var xyq_list = $(".xyq_list");
				var xyqHeight = parseInt($(".xyq_list").css("height"));
				var xyqRemain = xyqHeight-xyq_sn*xyq_up_px;
				
				var xyq_nowsn = xyq_sn-1;
				$(".xyq_list li:eq("+xyq_nowsn+") p").animate({width:'0px', height:'0px', 'margin-left':'760px', 'margin-top':'350px', 'padding':'0'},xyq_run_time);
				
				if(xyqRemain > 0){
					setTimeout("xyq_mt();", xyq_run_time+50); 
				}else{
					setTimeout("xyq_mtt();", xyq_run_time+50); 
				}
				//window.setTimeout(xyq, xyq_wait_time);
			}else{
				//alert('0');
				xyq_sn = 1;
				XUYUANQIANG_SWITCH = 1;
			}
		}
		
		// 响应底部播放栏
		function xuyuanqiang_click(button){
			//alert(button)
			
			if(button=='change'){
				if(XUYUANQIANG_CLICK){
					XUYUANQIANG_CLICK = 0;
				}else{
					$(".xyq_list").prepend( $("#xyq_list_stop").html() );
					$("#xyq_list_stop").html('');
					xyq_del_xyq_list();
					XUYUANQIANG_CLICK = 1;
				}
				return true;
			}
			
			if(button=='top' && xyq_sn>1){ xyq_sn--;xyq_sn--;}
			
			var xyq_list = $(".xyq_list");
			var xyq_list_size = $(".xyq_list li").size();	// 调查项目数
			var xyq_screen = Math.ceil(xyq_list_size / 3);
			
			var xyqHeight = parseInt($(".xyq_list").css("height"))-xyq_sn*xyq_bug_px;
			var xyqRemain = xyqHeight-xyq_sn*xyq_up_px;
			if(xyqRemain > 0){
				//alert(xyq_sn)
				//alert(xyq_sn)
				var px = xyq_sn*xyq_up_px+xyq_sn*xyq_bug_px;
				xyq_list.animate({'margin-top':'-'+px+'px'},xyq_run_time);
				xyq_sn++;
			}else{
				xyq_list.animate({'margin-top':'0px'},xyq_run_time);
				xyq_sn = 1;
			}
		}
		</script> 
    </div>
    <div id="dapingmu" class="boxitem"> 
      <!--* 无右侧 START *-->
      <div id="dpm">
        <div style="height:636px; overflow:hidden;">
          <div class="dpm_left">
            <ul id="dpm_list_stop" class="none">
            </ul>
            <ul class="dpm_list">
              <li  id="cid156199">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="白" /><i></i></dt>
                    <dd class="font30">白</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [10:22]
                      可以了吗</dd>
                  </dl>
                </div>
              </li>
              <li  id="cid156197">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="郭娜" /><i></i></dt>
                    <dd class="font30">郭娜</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [10:19]
                      上，上上</dd>
                  </dl>
                </div>
              </li>
              <li  id="cid156196">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="郭娜" /><i></i></dt>
                    <dd class="font30">郭娜</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [10:19]
                      上墙</dd>
                  </dl>
                </div>
              </li>
              <li  id="cid139575">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="邹曼蓉" /><i></i></dt>
                    <dd class="font30">邹曼蓉</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [16:51]
                      To</dd>
                  </dl>
                </div>
              </li>
              <li  id="cid139574">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="邹曼蓉" /><i></i></dt>
                    <dd class="font30">邹曼蓉</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [16:51]
                      To</dd>
                  </dl>
                </div>
              </li>
              <li  id="cid139573">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="A 亮仔-Leon " /><i></i></dt>
                    <dd class="font30">A 亮仔-Leon </dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [16:51]
                      9</dd>
                  </dl>
                </div>
              </li>
              <li  id="cid139571">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="A 亮仔-Leon " /><i></i></dt>
                    <dd class="font30">A 亮仔-Leon </dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [16:50]
                      9</dd>
                  </dl>
                </div>
              </li>
              <li  id="cid139563">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="郭娜" /><i></i></dt>
                    <dd class="font30">郭娜</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [16:46] <img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" class=brow /></dd>
                  </dl>
                </div>
              </li>
              <li  id="cid139560">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="郭娜" /><i></i></dt>
                    <dd class="font30">郭娜</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [16:44]
                      伤不起</dd>
                  </dl>
                </div>
              </li>
              <li  id="cid139556">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="郭娜" /><i></i></dt>
                    <dd class="font30">郭娜</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [16:42]
                      上墙</dd>
                  </dl>
                </div>
              </li>
              <li class="block">&nbsp;</li>
              <li class="block">&nbsp;</li>
              <li class="img" id="cid139555">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="芦铁" /><i></i></dt>
                    <dd class="font30">芦铁</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> <img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" class="picture" style="max-height:526px;" /> [16:41] </dd>
                  </dl>
                </div>
              </li>
              <li class="none">&nbsp;</li>
              <li class="none">&nbsp;</li>
              <li  id="cid139553">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="郭娜" /><i></i></dt>
                    <dd class="font30">郭娜</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> [16:40]
                      毛线</dd>
                  </dl>
                </div>
              </li>
              <li class="block">&nbsp;</li>
              <li class="block">&nbsp;</li>
              <li class="img" id="cid139552">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="A 亮仔-Leon " /><i></i></dt>
                    <dd class="font30">A 亮仔-Leon </dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> <img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" class="picture" style="max-height:526px;" /> [16:39] </dd>
                  </dl>
                </div>
              </li>
              <li class="none">&nbsp;</li>
              <li class="none">&nbsp;</li>
              <li class="img" id="cid139551">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="小蛋" /><i></i></dt>
                    <dd class="font30">小蛋</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> <img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" class="picture" style="max-height:526px;" /> [16:39] </dd>
                  </dl>
                </div>
              </li>
              <li class="none">&nbsp;</li>
              <li class="none">&nbsp;</li>
              <li class="img" id="cid139550">
                <div class="fl">
                  <dl>
                    <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="芦铁" /><i></i></dt>
                    <dd class="font30">芦铁</dd>
                  </dl>
                </div>
                <div class="fr">
                  <dl>
                    <dd> <img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" class="picture" style="max-height:526px;" /> [16:39] </dd>
                  </dl>
                </div>
              </li>
              <li class="none">&nbsp;</li>
              <li class="none">&nbsp;</li>
            </ul>
          </div>
        </div>
      </div>
      <script>
		/* 大屏幕 JS*/
		var DAPINGMU_SWITCH = 1;	// 开关
		var DAPINGMU_STATUS = 0;	// 状态，0停止，1正在运行
		var DAPINGMU_CLICK = 1;		// 底部控制栏播放器状态，0停止，1运行
		
		var dpm_sn = 1;
		var dpm_run_time = 500;	// 运行时间
		var wxq_wait_time = 9000;	// 等待时间
		var dpm_up_px = 636;
		
		var wxq_show_time = 1;	// 内容前面是否显示时间
		
		$(document).ready(function(){
			//window.setTimeout(dpm, wxq_wait_time);
			setInterval("dpm();", wxq_wait_time); 
		});
				
		function dapingmu(jsonStr){
			if(jsonStr.length>0 && jsonStr!=0){
				// 将JSON字符串转换为JSON对象
				var jsonObj = JSON.parse(jsonStr);
				var objUpdate = jsonObj.update;		// 更新数据
				var objType = jsonObj.type;		// 数据类型：empty空的，restart重载
				var objRemove = jsonObj.remove;		// 清除数据
				// 开始处理数据
				$("#test2").text('dapingmu:'+jsonStr);
				$("#test_dapingmu").text('进入dapingmu()');
				// 处理要更新的数据
				if(objUpdate!=''){
					DAPINGMU_SWITCH = 0;
					$("#test5").text('遍历前'+new Date().getTime()+';');
					var qdq_update = 0;	// 是否更新过签到墙信息
					$.each(objUpdate, function(k, v){
						$("#test_dapingmu").text('content='+v.content);
						var timestr = '';
						var timeFormat = '';
						if(wxq_show_time==1) timeFormat = 'hm'; else if(wxq_show_time==2) timeFormat = 'md'; else if(wxq_show_time==3) timeFormat = 'mdhm';
						if(wxq_show_time==4){
							timestr = v.floor+'楼 ';
						}else if(wxq_show_time){
							timestr = '['+formatDateTime(v.caudit,timeFormat)+'] ';	// 判断是否需要显示时间
						}
						var img = '';
						var liClass = '';
						var picStype = '';
						if(!v.content){
							picStype = ' style="max-height:526px;"';						}
						if(v.picture){ img = '<img src="'+v.picture+'" class="picture"'+picStype+' />'; liClass = ' class="img"'; }
						var msgtype = '';
						if(v.cmedia) msgtype = '<img src="/Public/Screen/images/msg_type_voice.png" /> ';
						if(v.replyname) msgtype += '"'+v.replyname+'":';
						if(v.content.indexOf('我在:')==0) msgtype = '<img src="/Public/Screen/images/msg_type_location.png" /> ';
						var info = '<li'+liClass+' id="cid'+v.cid+'"><div class="fl"><dl><dt><img src="'+v.avatar+'" title="'+v.nickname+'" />'+v.from_mark+'</dt><dd class="font30">'+v.nickname+'</dd></dl></div><div class="fr"><dl><dd>'+img+timestr+msgtype+v.content+'</dd></dl></div></li>';
						//$(info).prependTo(".dpm_list").hide().slideDown('slow');
						if(DAPINGMU_CLICK){
							$(".dpm_list").prepend(info);
						}else{
							$("#dpm_list_stop").prepend(info);
						}
						$("#test5").text($("#test5").text()+'遍历中'+new Date().getTime());
						
						// 更新签到墙部分
						var qdq_uid = $("#qdq_list #uid"+v.uid+" dt").text();
						var avatar = '';
						if(qdq_uid=='none'){
							avatar = v.avatar;
							if(avatar.indexOf("avatar.gif")>0) avatar = 'none';
							//alert('大屏幕 更新'+v.uid+' 的头像'+avatar+',呢称'+v.nickname)
							$("#qdq_list #uid"+v.uid+" dt").text(avatar);
							$("#qdq_list #uid"+v.uid+" dd").text(v.nickname);
							qdq_update = 1;
						}
						
					});
					
					if(now_module_name=='qiandaoqiang' && qdq_update) qdq_player(1);
					
					$("#test5").text($("#test5").text()+';遍历后'+new Date().getTime());
					if(DAPINGMU_CLICK){
						dpm_reorder();
						dpm_del_dpm_list();
					}
				}
				// 处理要删除的数据
				if(objRemove!=''){
					$("#test_dapingmu").text('objRemove存在 objRemove='+objRemove);
					
					DAPINGMU_SWITCH = 0;
					$.each(objRemove, function(k, v){
						$(".dpm_list #cid"+v.cid).remove();
					});
					//$("#test_dapingmu").text(jsonStr);
					dpm_reorder();
					DAPINGMU_SWITCH = 1;
				}
				
				/*
				switch(objType){
				case 'restart' : break;
				case 'update' : 
					//$("#qdq").html(objData);
					DAPINGMU_SWITCH = 0;
					$("#test5").text('遍历前'+new Date().getTime()+';');
					$.each(objData, function(k, v){
						var timestr = '';
						if(wxq_show_time && v.content.length) timestr = '['+formatDateTime(v.caudit)+'] ';	// 判断是否需要显示时间
						var img = '';
						var liClass = '';
						if(v.picture){ img = '<img src="'+v.picture+'" class="picture" />'; liClass = ' class="img"'; }
						var info = '<li'+liClass+' id="uid'+v.uid+'"><div class="fl"><dl><dt><img src="'+v.avatar+'" />'+v.from_mark+'</dt><dd class="font30">'+v.nickname+'</dd></dl></div><div class="fr"><dl><dd>'+img+timestr+''+v.content+'</dd></dl></div></li>';
						//$(info).prependTo(".dpm_list").hide().slideDown('slow');
						$(".dpm_list").prepend(info);
						$("#test5").text($("#test5").text()+'遍历中'+new Date().getTime());
					});
					$("#test5").text($("#test5").text()+';遍历后'+new Date().getTime());
					dpm_reorder();
					break;
				case 'remove' : break;
				}*/
			}else if(jsonStr==0){
				DAPINGMU_STATUS = 1;
			}
		}
		
		// 对所有dpm_list中的li重新计算
		function dpm_reorder(){
			// 删除占位LI
			$(".dpm_list li.block").remove();
			// 删除隐藏LI
			$(".dpm_list li.none").remove();
			var dpm_list = $(".dpm_list li");
			// 清空dpm_list
			// 重新设置占位与隐藏LI
			var dpm_list_html = '';
			var dpm_list_i = 1;
			for(var i=0; i<dpm_list.size(); i++){
				var html = '';
				var li = $(dpm_list.get(i)).html();
				var liclass = $(dpm_list.get(i)).attr('class');
				var cls = '';
				var liid = $(dpm_list.get(i)).attr('id');
				var id = ' id="'+liid+'"';
				if(liclass=='img'){
					if(dpm_list_i%3==1){
						html = '';
					}else if(dpm_list_i%3==2){
						html = '<li class="block">&nbsp;</li><li class="block">&nbsp;</li>';
						dpm_list_i++; dpm_list_i++;
					}else{
						html = '<li class="block">&nbsp;</li>';
						dpm_list_i++;
					}
					cls = ' class="img"';
					
				}
				html = html + '<li'+cls+id+'>'+li+'</li>';
				if(liclass=='img'){
					html = html+'<li class="none">&nbsp;</li><li class="none">&nbsp;</li>';
					dpm_list_i++; dpm_list_i++;
				}
				dpm_list_html = dpm_list_html+html;
				dpm_list_i++;
			}
			$(".dpm_list").html(dpm_list_html);
			
			//dpm_del_dpm_list();
		}
		
		// 删除多余的内容，随着上墙内容的动态更新，越来越多的内容导致滚动次数过多，因此在这里只保留20个内容
		var retain_page = 20;
		retain_page = retain_page * 3;
		function dpm_del_dpm_list(){
			for( ; $(".dpm_list li").size()>retain_page ; ){
				$("#test4").text($(".dpm_list li").size());
				$(".dpm_list li:last").remove();
			}
			
			var dpm_list = $(".dpm_list");
			dpm_list.animate({'margin-top':'0px'},dpm_run_time);
			//window.setTimeout(dpm_restart, wxq_wait_time*1.1);
		}
		
		var dpm_bug_px = 15;
		//if(!-[1,]) dpm_bug_px = 30;
		//alert(dpm_bug_px);
		
		function dpm(){
			if(!DAPINGMU_CLICK) return false;
			if(DAPINGMU_SWITCH && DAPINGMU_STATUS){
				var dpm_list = $(".dpm_list");
				var dpm_list_size = $(".dpm_list li").size();	// 调查项目数
				var dpm_screen = Math.ceil(dpm_list_size / 3);
				$("#test2").text("dpm_list_size="+dpm_list_size+",dpm_screen="+dpm_screen+",dpm_sn="+dpm_sn+",height="+$(".dpm_list").css("height"));
				/* 方式一 *
				if(dpm_sn >= dpm_screen){
					dpm_list.animate({'margin-top':'0px'},dpm_run_time);
					dpm_sn=1;
				}else{
					var px = dpm_sn*dpm_up_px+dpm_sn*13;
					dpm_list.animate({'margin-top':'-'+px+'px'},dpm_run_time);
					dpm_sn++;
				}
				/* 方式二 */
				var dpmHeight = parseInt($(".dpm_list").css("height"))-dpm_sn*dpm_bug_px;
				var dpmRemain = dpmHeight-dpm_sn*dpm_up_px;
				if(dpmRemain > 0){
					//var px = dpm_sn*dpm_up_px+13;
					var px = dpm_sn*dpm_up_px+dpm_sn*dpm_bug_px;
					dpm_list.animate({'margin-top':'-'+px+'px'},dpm_run_time);
					dpm_sn++;
					$("#test1").text('dpmHeight='+dpmHeight+',dpm_sn='+dpm_sn+',px='+px+', dpmRemain='+dpmRemain);
				}else{
					dpm_list.animate({'margin-top':'0px'},dpm_run_time);
					dpm_sn=1;
					$("#test1").text('dpmHeight='+dpmHeight+',dpm_sn='+dpm_sn+',dpmRemain='+dpmRemain);
				}
				//window.setTimeout(dpm, wxq_wait_time);
			}else{
				dpm_sn = 1;
				DAPINGMU_SWITCH = 1;
			}
		}
		
		// 响应底部播放栏
		function dapingmu_click(button){
			//alert(button);
			
			if(button=='change'){
				if(DAPINGMU_CLICK){
					DAPINGMU_CLICK = 0;
				}else{
					$(".dpm_list").prepend( $("#dpm_list_stop").html() );
					$("#dpm_list_stop").html('');
					dpm_reorder();
					dpm_del_dpm_list();
					DAPINGMU_CLICK = 1;
				}
				return true;
			}
			
			if(button=='top' && dpm_sn>1){ dpm_sn--;dpm_sn--;}
			
			var dpm_list = $(".dpm_list");
			var dpm_list_size = $(".dpm_list li").size();	// 调查项目数
			var dpm_screen = Math.ceil(dpm_list_size / 3);
			
			var dpmHeight = parseInt($(".dpm_list").css("height"))-dpm_sn*dpm_bug_px;
			var dpmRemain = dpmHeight-dpm_sn*dpm_up_px;
			if(dpmRemain > 0){
				//alert(dpm_sn)
				//alert(dpm_sn)
				var px = dpm_sn*dpm_up_px+dpm_sn*dpm_bug_px;
				dpm_list.animate({'margin-top':'-'+px+'px'},dpm_run_time);
				dpm_sn++;
			}else{
				dpm_list.animate({'margin-top':'0px'},dpm_run_time);
				dpm_sn = 1;
			}
		}
		</script> 
      <!--* 无右侧 END *--> 
      
    </div>
    <div id="choujiang" class="boxitem">
      <div id="cj_scroll" class="choujiang_2">
        <div id="cj_show"> 
          <!--奖项及抽奖-->
          <div id="cj_lottery_box">
            <ul id="cj_lottery_list">
              <li>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <th colspan="3" class="cj_name_number">一等奖 <b>1</b>名</th>
                  </tr>
                  <tr>
                    <td class="img" valign="middle"><img src="http://wall.49109.com/uploadfile/2015/0129/20150129025739774.jpg" />
                      <p class="font30">macbook air<br />
                        价值:￥7999</p></td>
                    <td width="10">&nbsp;</td>
                    <td class="list" align="center" valign="middle" id="cj_lottery_list_0"><table border="0" cellspacing="0" cellpadding="0" align="center" class="imgbox">
                        <tr>
                          <td><!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="凤" /><i></i></dt><dd>7.凤</dd></dl>--> 
                            <!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="凤" /><i></i></dt><dd>6.凤</dd></dl>--> 
                            <!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="凤" /><i></i></dt><dd>5.凤</dd></dl>--> 
                            <!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="邹曼蓉" /><i></i></dt><dd>4.邹曼蓉</dd></dl>--> 
                            <!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="白" /><i></i></dt><dd>3.白</dd></dl>--> 
                            <!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="邹曼蓉" /><i></i></dt><dd>2.邹曼蓉</dd></dl>--> 
                            <!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="白" /><i></i></dt><dd>1.白</dd></dl>--></td>
                        </tr>
                      </table></td>
                  </tr>
                </table>
              </li>
              <li>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <th colspan="3" class="cj_name_number">二等奖 <b>1</b>名</th>
                  </tr>
                  <tr>
                    <td class="img" valign="middle"><img src="http://wall.49109.com/uploadfile/2015/0129/20150129025859243.jpg" />
                      <p class="font30">iphone6 plus<br />
                        价值:￥5999</p></td>
                    <td width="10">&nbsp;</td>
                    <td class="list" align="center" valign="middle" id="cj_lottery_list_1"><table border="0" cellspacing="0" cellpadding="0" align="center" class="imgbox">
                        <tr>
                          <td><!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="白" /><i></i></dt><dd>2.白</dd></dl>--> 
                            <!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="邹曼蓉" /><i></i></dt><dd>1.邹曼蓉</dd></dl>--></td>
                        </tr>
                      </table></td>
                  </tr>
                </table>
              </li>
              <li>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <th colspan="3" class="cj_name_number">三等奖 <b>1</b>名</th>
                  </tr>
                  <tr>
                    <td class="img" valign="middle"><img src="http://wall.49109.com/uploadfile/2015/0129/20150129025945946.jpg" />
                      <p class="font30">你猜</p></td>
                    <td width="10">&nbsp;</td>
                    <td class="list" align="center" valign="middle" id="cj_lottery_list_2"><table border="0" cellspacing="0" cellpadding="0" align="center" class="imgbox">
                        <tr>
                          <td><!--<dl><dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="凤" /><i></i></dt><dd>1.凤</dd></dl>--></td>
                        </tr>
                      </table></td>
                  </tr>
                </table>
              </li>
              <li>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <th colspan="3" class="cj_name_number">一等奖 <b>1</b>名</th>
                  </tr>
                  <tr>
                    <td class="img" valign="middle"><img src="http://wall.49109.com/uploadfile/2015/0129/20150129025739774.jpg" />
                      <p class="font30">macbook air<br />
                        价值:￥7999</p></td>
                    <td width="10">&nbsp;</td>
                    <td class="list" align="center" valign="middle" id="cj_lottery_list_3"><table border="0" cellspacing="0" cellpadding="0" align="center" class="imgbox">
                        <tr>
                          <td></td>
                        </tr>
                      </table></td>
                  </tr>
                </table>
              </li>
              <li>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <th colspan="3" class="cj_name_number">二等奖 <b>1</b>名</th>
                  </tr>
                  <tr>
                    <td class="img" valign="middle"><img src="http://wall.49109.com/uploadfile/2015/0129/20150129025859243.jpg" />
                      <p class="font30">iphone6 plus<br />
                        价值:￥5999</p></td>
                    <td width="10">&nbsp;</td>
                    <td class="list" align="center" valign="middle" id="cj_lottery_list_4"><table border="0" cellspacing="0" cellpadding="0" align="center" class="imgbox">
                        <tr>
                          <td></td>
                        </tr>
                      </table></td>
                  </tr>
                </table>
              </li>
              <li>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <th colspan="3" class="cj_name_number">三等奖 <b>10</b>名</th>
                  </tr>
                  <tr>
                    <td class="img" valign="middle"><img src="http://wall.49109.com/uploadfile/2015/0129/20150129025945946.jpg" />
                      <p class="font30">你猜<br />
                        价值:￥5555</p></td>
                    <td width="10">&nbsp;</td>
                    <td class="list" align="center" valign="middle" id="cj_lottery_list_5"><table border="0" cellspacing="0" cellpadding="0" align="center" class="imgbox">
                        <tr>
                          <td></td>
                        </tr>
                      </table></td>
                  </tr>
                </table>
              </li>
            </ul>
            
            <!-- 答题板 -->
            <div id="cj_datiban_none_all" class="none"> <!--所有--> 
            </div>
            <div id="cj_datiban_none" class="none"> <!--有抽奖资格--> 
            </div>
            
            <!-- 提问墙 -->
            <div id="cj_tiwenqiang_none_all" class="none"> <!--所有--> 
            </div>
            <div id="cj_tiwenqiang_none" class="none"> <!--有抽奖资格--> 
            </div>
            
            <!-- 微评分 -->
            <div id="cj_weipingfen_none_all" class="none"></div>
            <!--所有-->
            <div id="cj_weipingfen_none" class="none"></div>
            <!--有抽奖资格--> 
            
            <!-- 微调查 -->
            <div id="cj_weidiaocha_none_all" class="none"></div>
            <!--所有-->
            <div id="cj_weidiaocha_none" class="none"></div>
            <!--有抽奖资格--> 
            
            <!-- 上墙 -->
            <div id="cj_lottery_none_all" class="none"> <!--所有-->
              <li id="uid31783345" class="awards_0"><em class="none">0</em>
                <p class="none">31783345</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="芦铁" /><i></i></dt>
                  <dd>芦铁</dd>
                </dl>
              </li>
              <li id="uid31783334" class="awards_0"><em class="none">0</em>
                <p class="none">31783334</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg title="小蛋" /><i></i></dt>
                  <dd>小蛋</dd>
                </dl>
              </li>
              <li id="uid31783335" class="awards_0"><em class="none">0</em>
                <p class="none">31783335</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="郭娜" /><i></i></dt>
                  <dd>郭娜</dd>
                </dl>
              </li>
              <li id="uid31783332" class="awards_0"><em class="none">0</em>
                <p class="none">31783332</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="抬头丶微笑" /><i></i></dt>
                  <dd>抬头丶微笑</dd>
                </dl>
              </li>
              <li id="uid31783333" class="awards_0"><em class="none">0</em>
                <p class="none">31783333</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg title="A 亮仔-Leon " /><i></i></dt>
                  <dd>A 亮仔-Leon </dd>
                </dl>
              </li>
              <li id="uid31783141" class="awards_0"><em class="none">0</em>
                <p class="none">31783141</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="微久信-笑笑" /><i></i></dt>
                  <dd>微久信-笑笑</dd>
                </dl>
              </li>
            </div>
            <div id="cj_lottery_none" class="none"> <!--有抽奖资格-->
              <li id="uid31783345" class="awards_0"><em class="none">0</em>
                <p class="none">31783345</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="芦铁" /><i></i></dt>
                  <dd>芦铁</dd>
                </dl>
              </li>
              <li id="uid31783334" class="awards_0"><em class="none">0</em>
                <p class="none">31783334</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg title="小蛋" /><i></i></dt>
                  <dd>小蛋</dd>
                </dl>
              </li>
              <li id="uid31783335" class="awards_0"><em class="none">0</em>
                <p class="none">31783335</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="郭娜" /><i></i></dt>
                  <dd>郭娜</dd>
                </dl>
              </li>
              <li id="uid31783332" class="awards_0"><em class="none">0</em>
                <p class="none">31783332</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="抬头丶微笑" /><i></i></dt>
                  <dd>抬头丶微笑</dd>
                </dl>
              </li>
              <li id="uid31783333" class="awards_0"><em class="none">0</em>
                <p class="none">31783333</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg title="A 亮仔-Leon " /><i></i></dt>
                  <dd>A 亮仔-Leon </dd>
                </dl>
              </li>
              <li id="uid31783141" class="awards_0"><em class="none">0</em>
                <p class="none">31783141</p>
                <dl>
                  <dt><img src="http://7xawow.com2.z0.glb.qiniucdn.com/2015-03-31_551a4d13bc285.jpg" title="微久信-笑笑" /><i></i></dt>
                  <dd>微久信-笑笑</dd>
                </dl>
              </li>
            </div>
            
            <!-- 滚动奖池 -->
            <div id="cj_lottery_scroll">
              <div id="cj_lottery_count" >奖池人数<br />
                <b>6</b></div>
              <ul >
                <li>
                  <dl>
                    <dt><img src="/Public/Screen/images/cj_def.gif" /></dt>
                    <dd>&nbsp;</dd>
                  </dl>
                </li>
              </ul>
              <div id="cj_lottery_button" onClick="cj_scroll_set()">滚动</div>
              <div class="cj_remove">
                <input type="button" value="清除中奖者" onclick="cj_remove()" />
              </div>
            </div>
          </div>
        </div>
        <!--控制部分-->
        <div id="cj_control_box">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="right"><label>
                  <input autocomplete="off" type="radio" name="cj_awards" onClick="cj_awards_box(0,604,1,1)" checked value="0" />
                  一等奖：1名</label>
                <label>
                  <input autocomplete="off" type="radio" name="cj_awards" onClick="cj_awards_box(1,605,1,1)" value="1" />
                  二等奖：1名</label>
                <label>
                  <input autocomplete="off" type="radio" name="cj_awards" onClick="cj_awards_box(2,606,1,1)" value="2" />
                  三等奖：1名</label>
                <label>
                  <input autocomplete="off" type="radio" name="cj_awards" onClick="cj_awards_box(3,607,1,1)" value="3" />
                  一等奖：1名</label>
                <label>
                  <input autocomplete="off" type="radio" name="cj_awards" onClick="cj_awards_box(4,608,1,1)" value="4" />
                  二等奖：1名</label>
                <label>
                  <input autocomplete="off" type="radio" name="cj_awards" onClick="cj_awards_box(5,609,1,1)" value="5" />
                  三等奖：10名</label></td>
            </tr>
          </table>
        </div>
      </div>
      <script>
		var CHOUJIANG_SWITCH = 1;	
		var CHOUJIANG_STATUS = 0;	
		var CHOUJIANG_CLICK = 1;	// 底部控制栏播放器状态，0停止，1运行
		
		var cj_awards_i = 0;	// 当前奖项
		var cj_awards_id = 604;	// 当前奖项ID
		var cj_awards_set = new Array();	// 当前奖项是否有定
				cj_awards_set[604] = 0;
				cj_awards_set[605] = 0;
				cj_awards_set[606] = 0;
				cj_awards_set[607] = 0;
				cj_awards_set[608] = 0;
				cj_awards_set[609] = 0;
				var cj_awards_oncenum = 1;	// 当前奖项每轮抽取数量
		var cj_awards_pond = 1;	// 当前奖池
		var cj_awards_pond_id = 'cj_lottery_none';
		var cj_awards_item = '';	// 当中奖源是从得分最高节目中抽取时，此值保存得分最高节目的ID，多个用逗号分隔
		
		var cj_lottery_sn = 0;
		var cj_scroll_time = 30;	// 滚动间隔
		var cj_scroll_status = 0;	// 名单滚动状态 0停止，1滚动，2等待
		
		var cj_awards_listarr = new Array();
							cj_awards_listarr[0] = new Array(0,604,1,1);
							cj_awards_listarr[1] = new Array(1,605,1,1);
							cj_awards_listarr[2] = new Array(2,606,1,1);
							cj_awards_listarr[3] = new Array(3,607,1,1);
							cj_awards_listarr[4] = new Array(4,608,1,1);
							cj_awards_listarr[5] = new Array(5,609,1,1);
						
		function choujiang(jsonStr){
			if(jsonStr.length>0 && jsonStr!=0){
				// 将JSON字符串转换为JSON对象
				var jsonObj = JSON.parse(jsonStr);
				var objUpdate = jsonObj.update;		// 更新数据
				var objType = jsonObj.type;		// 数据类型：empty空的，restart重载
				var objRemove = jsonObj.remove;		// 清除数据
				$("#test4").text('choujiang:'+jsonStr);
				// 开始处理数据
				// 处理要更新的数据
				if(objUpdate!=''){
					$.each(objUpdate, function(k, v){
						var html = '<li id="uid'+v.uid+'" class="awards_'+v.awards+'"><em class="none">'+v.awards+'</em><p class="none">'+v.uid+'</p><dl><dt><img src="'+v.avatar+'" title="'+v.nickname+'" />'+v.from_mark+'</dt><dd>'+v.nickname+'</dd></dl></li>';
						// 在写入名单前先检查UID是否重复，以防止出现中奖重复的现象
						var nonesize = $("#cj_lottery_none_all #uid"+v.uid).size();
						//alert('抽奖 已存在UID数量'+nonesize);
						if(nonesize==0){
							$("#cj_lottery_none").prepend(html);
							$("#cj_lottery_none_all").prepend(html);
							//var cls_size = $("#cj_lottery_scroll ul li").size();
							//if(cj_scroll_status==0) $("#cj_lottery_scroll ul").prepend(html);
						}
					});
					$("#cj_lottery_count").html( '奖池人数<br /><b>'+$("#cj_lottery_none li").size()+'</b>' );
				}
				// 处理要删除的数据
				if(objRemove!=''){
					$.each(objRemove, function(k, v){
						$("#cj_lottery_box #uid"+v.uid).remove();
					});
				}
			}else if(jsonStr==0){
				cj();
			}else{
			}
		}
		
		function cj(){
			cj_awards_pond_clear();
		}
		
		// 奖池清理
		function cj_awards_pond_clear(){
			var cj_item_html = '';
			if(cj_awards_pond==2 && cj_awards_item){
				// 先清理奖池，只保留投过最高得分节目的用户
				//alert('最高得票节目ID：'+cj_awards_item);
				//alert('cj_awards_item='+cj_awards_item+',cj_awards_pond_id='+cj_awards_pond_id+$("#"+cj_awards_pond_id+" li").size());
				var cj_item_ids = new Array();
				cj_item_ids = cj_awards_item.split(",");
				var cj_item_html = '';
				$.each(cj_item_ids, function(k, v){
					var cj_item = $("#"+cj_awards_pond_id+" .item"+v);
					for (var i = 0; i < cj_item.size(); i++) {
						var cj_uid = $("#"+cj_awards_pond_id+" .item"+v+":eq("+i+") p").text();
						cj_item_html = cj_item_html+'<li id="uid'+cj_uid+'">'+$(cj_item.get(i)).html()+'</li>';
					}
				});
				$("#"+cj_awards_pond_id).html(cj_item_html);
				//alert('cj_awards_item='+cj_awards_item+',cj_awards_pond_id='+cj_awards_pond_id+$("#"+cj_awards_pond_id+" li").size());
				// 再清理重复用户
				var cj_item = $("#"+cj_awards_pond_id+" li");
				for (var i = 0; i < cj_item.size(); i++) {
					var cj_uid = $("#"+cj_awards_pond_id+" li:eq("+i+") p").text();
					var cj_item_class = $("#"+cj_awards_pond_id+" li:eq("+i+") b").text();
					var cj_uid_size = $("#"+cj_awards_pond_id+" #uid"+cj_uid).size();
					//alert('cj_item_class='+cj_item_class);
					if(cj_item_html.indexOf('"uid'+cj_uid+'"')==-1) cj_item_html = cj_item_html+'<li id="uid'+cj_uid+'" class="'+cj_item_class+'">'+$(cj_item.get(i)).html()+'</li>';
				}
				$("#"+cj_awards_pond_id).html(cj_item_html);
				//alert('cj_item_html='+cj_item_html);
			}
			
			var cj_awards_pond_num = $("#"+cj_awards_pond_id+" li").size();
			$("#cj_lottery_count").html( '奖池人数<br /><b>'+cj_awards_pond_num+'</b>' );
			if(cj_item_html) $("#cj_lottery_scroll ul").html('<li>'+$("#"+cj_awards_pond_id+" li:last").html()+'</li>');
		}
		
		// 奖项切换
		function cj_awards_box(ii,id,oncenum,pond){
			cj_awards_i = ii;
			cj_awards_id = id;
			cj_awards_oncenum = oncenum;
			cj_awards_pond = pond;
			
			if(pond==1) cj_awards_pond_id = 'cj_lottery_none'; else if(pond==2) cj_awards_pond_id = 'cj_weipingfen_none'; else if(pond==3) cj_awards_pond_id = 'cj_weidiaocha_none'; else if(pond==4) cj_awards_pond_id = 'cj_datiban_none'; else if(pond==5) cj_awards_pond_id = 'cj_tiwenqiang_none';
			// 切换奖项
			var cj_awards_box = $("#cj_awards_box ul li");
			for (var i = 0; i < cj_awards_box.size(); i++) {
				$(cj_awards_box.get(i)).slideUp("slow");
			}
			$(cj_awards_box.get(ii)).slideDown("slow");
			// 切换抽奖
			var cj_lottery_list = $("#cj_lottery_list li");
			for (var i = 0; i < cj_lottery_list.size(); i++) {
				$(cj_lottery_list.get(i)).slideUp("slow");
			}
			$(cj_lottery_list.get(ii)).slideDown("slow");
			// 选中奖项
			$("#cj_control_box input:eq("+ii+")").attr("checked","checked"); 
			
			$("#cj_lottery_count").html( '奖池人数<br /><b>'+$("#"+cj_awards_pond_id+" li").size()+'</b>' );
			
			cj_awards_pond_clear();
		}
		
		var cj_round_num = 0;	// 本轮剩余人数
		var cj_round_numed = 0;	// 本轮已抽人数
		var cj_round_offer = -1;	// 每几轮抽取1名内定者 -1表示无内容者
		var scroll_awards_size = 0;	// 总内定人数
		var cj_uids = '';	// 本轮中奖者UID
		// 奖项滚动设置
		function cj_scroll_set(){
			//alert('ii='+cj_awards_i+',id='+cj_awards_id+',oncenum='+cj_awards_oncenum);
			if(now_module_name!='choujiang') return false;
			
			if(!cj_awards_id){
				alert('当前活动未添加任何奖项，请先在会员中心为此活动添加奖项后再进行抽奖！');
				return false;
			}
			//alert('每轮抽'+cj_awards_oncenum);
			
			if(cj_scroll_status==0){	// 当前停止
				if(cj_awards_pond==2 && cj_awards_item==''){
					alert("此项抽奖需要等待微评分结束后抽取！");
					return false;
				}
				
				var allNum = $("#cj_lottery_list li:eq("+cj_awards_i+") th b").text();	// 需抽人数
				var numed = $("#cj_lottery_list_"+cj_awards_i+" td dl").size();	// 已抽人数
				var num = 0;
				// 计算一次抽取人数
				if(numed>=allNum)
								num = 1;
									//num = 1;
					//return false;
				else{
					if(cj_awards_oncenum > allNum-numed) num = allNum-numed; else num = cj_awards_oncenum;
				}
				cj_round_num = num;
				
				scroll_awards_size = $("#"+cj_awards_pond_id+" li.awards_"+cj_awards_id).size();
				//var cj_temp = Math.ceil(parseInt(allNum-numed)/parseInt(cj_awards_oncenum));
				//cj_round_offer = parseInt(parseInt(scroll_awards_size)/cj_temp);
				cj_round_offer = scroll_awards_size ? parseInt((allNum-numed)/scroll_awards_size) : cj_round_offer;
				//alert('每'+cj_round_offer+'轮1名内定者');
				
				if($("#"+cj_awards_pond_id+" li").size()){	// 奖池中有人
					cj_scroll_status = 1;
					// 设置文字
					$("#cj_lottery_button").text("停");
					// 写入名单
					$("#cj_lottery_scroll ul").html($("#"+cj_awards_pond_id).html());
					cj_scroll();
				}else{	// 奖池为空
					alert("奖池为空！");
				}
				
				cj_uids = '';
				cj_round_numed = 0;
				
				//$("#cj_test_1").text( $("#cj_lottery_scroll").html());
				
			}else if(cj_scroll_status==1){	//正在滚动
				
				cj_scroll_status = 2;
				
				var allNum = $("#cj_lottery_list li:eq("+cj_awards_i+") th b").text();	// 需抽人数
				var numed = $("#cj_lottery_list_"+cj_awards_i+" td dl").size();	// 已抽人数
				var num = 0;
				// 计算一次抽取人数
				if(numed>=allNum)
					num = 1;
				else{
					if(cj_awards_oncenum > allNum-numed) num = allNum-numed; else num = cj_awards_oncenum;
				}
				
				// 判断是否有定
				//var scroll_awards_size = $("#"+cj_awards_pond_id+" li.awards_"+cj_awards_id).size();
				var draw_awards = 0;
				//alert('还剩下'+cj_round_num+'轮，每'+cj_round_offer+'抽1人，本轮为内定'+cj_round_numed+'');
				
				if(cj_round_offer>=0){
					// 有内定者
					cj_awards_set[cj_awards_id] = 1;	// 当前奖项有内定
					num = 1;
				}
				//alert(cj_round_numed+','+cj_round_offer);
				if(cj_round_numed==cj_round_offer && !cj_round_offer){
					draw_awards=cj_awards_id;
					//alert('本轮将抽出内定者');
					cj_round_numed = 0;
				}else if(cj_round_numed==cj_round_offer-1){
					draw_awards=cj_awards_id;
					//alert('本轮将抽出内定者');
					cj_round_numed = 0;
				}else{
					draw_awards = 0;
					cj_round_numed += num;
				}
				
				var scroll_none_size = $("#"+cj_awards_pond_id+" li.awards_"+draw_awards).size();	// 奖池人数
				if(num>scroll_none_size) num = scroll_none_size;	// 再次计算一次抽取人数
				
				$("#test_cj dd").text( scroll_none_size+','+num);
				
				var items = getNotRepeatArray(scroll_none_size, num);
				var randNumArr = new Array();
				var randUidArr = new Array();
				var randDtArr = new Array();
				var randDdArr = new Array();
				//var cj_uids = '';
				for (var key in items) {
					var tmpKey = items[key]-1;
					randNumArr[key] = tmpKey;
					randUidArr[key] = $("#cj_lottery_scroll ul li.awards_"+draw_awards+":eq("+tmpKey+") p").text();
					randDtArr[key] = $("#cj_lottery_scroll ul li.awards_"+draw_awards+":eq("+tmpKey+") dl dt").html();
					randDdArr[key] = $("#cj_lottery_scroll ul li.awards_"+draw_awards+":eq("+tmpKey+") dl dd").text();
					//if(draw_awards) alert(draw_awards+','+tmpKey+','+randDdArr[key]);
					cj_uids = cj_uids + "," + randUidArr[key];
					
					var rand_temp = $("#cj_lottery_scroll ul li.awards_"+draw_awards+":eq("+tmpKey+")").html();
					$("#test_cj dd").text( $("#test_cj dd").text() +'<br>'+rand_temp+','+ key+','+items[key]+','+tmpKey+','+randUidArr[key]+','+randDdArr[key]);
					
					//$("#cj_lottery_scroll ul li.awards_"+draw_awards+":eq("+tmpKey+")").remove();
				}
				
				//alert('cj_awards_pond_id='+cj_awards_pond_id+'\r\n需抽'+allNum+',已抽'+numed+',一次抽'+cj_awards_oncenum+',实际一次抽'+num+',奖池有'+scroll_none_size+'\r\n内定'+scroll_awards_size+',cj_awards_pond_id='+cj_awards_pond_id+',draw_awards='+draw_awards+',cj_awards_id='+cj_awards_id+'\r\n还剩'+cj_round_num+'轮，本轮须抽出'+cj_round_offer+'名内定者，items='+items.toString()+',cj_uids='+cj_uids+',randUidArr='+randUidArr.toString());
				
				for (var key in randNumArr) {
					//alert('key='+key+',randNum='+randNumArr[key]);
					// 删除用户
					$("#"+cj_awards_pond_id+" #uid"+randUidArr[key]).remove();
					// 写滚动中奖者
					var scroll_html = '<li><dl><dt>'+randDtArr[key]+'</dt><dd>'+randDdArr[key]+'</dd></dl></li>';
					// 写入中奖者
					var namelist = $("#cj_lottery_list_"+cj_awards_i+" td").html();
					var lottery_list = $("#cj_lottery_list_"+cj_awards_i+" dl");
					var size = lottery_list.size()+1;
					var lottery_html = '<dl><p class="none">'+randUidArr[key]+'</p><dt>'+randDtArr[key]+'</dt><dd>'+size+'.'+randDdArr[key]+'</dd></dl>'+namelist;
					$("#cj_lottery_list_"+cj_awards_i+" td").html(lottery_html);
					
					var cj_lc = parseInt($("#cj_lottery_count b").text())-1;
					$("#cj_lottery_count").html( '奖池人数<br /><b>'+cj_lc+'</b>' );
					
					$("#test2").text(lottery_html);
				}
				
				cj_round_num = cj_round_num - num;
				//alert(cj_round_num+','+cj_round_num+','+num);
				var scroll_none_size_2 = $("#"+cj_awards_pond_id+" li.awards_0").size();	// 奖池人数
				if(cj_round_num>0 && num && scroll_none_size_2){
					//alert("本轮进入"+cj_round_num);
					cj_scroll_status = 1;
					cj_scroll_set();
				}else{
					//alert("本轮结束"+cj_round_num);
					cj_scroll_status = 2;
					// 初始化
					$("#cj_lottery_button").text("滚动");
					cj_scroll_status = 0;
					cj_lottery_sn = 0;
					$("#cj_lottery_scroll ul").html('<li><dl><dt><img src="/Public/Screen/images/cj_def.gif" /></dt><dd>&nbsp;</dd></dl></li>');
					
				
					//$("#cj_test_2").text( $("#cj_lottery_scroll").html());
					
					// AJAX请求数据，写入完成返回1，删除用户写中奖者；错误返回-1，提示异常；2表示中奖者重复
					$.get('index.php?m=member&c=screen_pull&a=ajax_choujiang_insert_winners',{ catid:101, id:755, uids:cj_uids, awid:cj_awards_id}, function(data){
						//alert("cj_uids="+cj_uids+",data="+data);
						});
				}
				
			}else{	// 等待
				// 暂时不执行操作
			}
		}
		// 奖项滚动
		function cj_scroll(){
			if(cj_scroll_status){
				var cj_lottery_scroll = $("#cj_lottery_scroll ul li");
				$(cj_lottery_scroll.get(cj_lottery_sn)).slideUp(cj_scroll_time);
				$("#cj_lottery_scroll ul").append('<li>'+$(cj_lottery_scroll.get(cj_lottery_sn)).html()+'</li>');
				cj_lottery_sn++;
				//$("#test2").text(cj_lottery_sn);
				window.setTimeout(cj_scroll, cj_scroll_time);
			}
		}
		// 清除中奖者
		function cj_remove(){
			//alert(cj_awards_i);
			$("#cj_lottery_list_"+cj_awards_i+" td").html("");
		}
		// 控制部分
		function cj_control_box(id){
			if(id=='cj_awards_box'){
				$("#cj_lottery_box").slideDown("slow");
				$("#cj_awards_box").slideUp("slow");
			}else{
				$("#cj_awards_box").slideDown("slow");
				$("#cj_lottery_box").slideUp("slow");
			}
		}
		
		// 响应底部播放栏
		function choujiang_click(button){
			//alert(button)
			if(button=='change'){
				cj_scroll_set();
				return true;
			}else if(button=='diy'){
				cj_remove();
				return true;
			}
			
			var cjcci = cj_awards_i;
			if(button=='top'){
				if(cj_awards_i) cjcci--; else cjcci=0;
			}else if(button=='next'){
				var cca = $("#cj_control_box label").size()-1;
				if(cj_awards_i<cca) cjcci++; else cjcci = cca;
			}else{
				return false;
			}
			cj_awards_box(cj_awards_listarr[cjcci][0],cj_awards_listarr[cjcci][1],cj_awards_listarr[cjcci][2],cj_awards_listarr[cjcci][3]);
		}
		</script> </div>
    <div id="weipingfen" class="boxitem">
      <div id="wpf">
        <div style="height:646px; overflow:hidden;"> 
          <!-- 内容部分 -->
          <div id="wpf_content">
            <div id="wpf_menu" class="text">
              <div class="wpf_menu_name">[节目]</div>
              <dl>
                <dt onClick="wpf_list_change(0);">1</dt>
                <dd onClick="wpf_list_change(0);">&nbsp;亲爱的小孩</dd>
              </dl>
              <dl>
                <dt onClick="wpf_list_change(1);">2</dt>
                <dd onClick="wpf_list_change(1);">&nbsp;匆匆那年</dd>
              </dl>
              <dl>
                <dt onClick="wpf_list_change(2);">3</dt>
                <dd onClick="wpf_list_change(2);">&nbsp;歌曲串烧</dd>
              </dl>
              <dl>
                <dt onClick="wpf_list_change(3);">4</dt>
                <dd onClick="wpf_list_change(3);">&nbsp; 小品：租房记 </dd>
              </dl>
              <dl>
                <dt onClick="wpf_list_change(4);">5</dt>
                <dd onClick="wpf_list_change(4);">&nbsp;舞台剧 精神病院 </dd>
              </dl>
              <dl>
                <dt onClick="wpf_list_change(5);">6</dt>
                <dd onClick="wpf_list_change(5);">&nbsp; 小品新闻联播</dd>
              </dl>
              <dl>
                <dt onClick="wpf_list_change(6);">7</dt>
                <dd onClick="wpf_list_change(6);">&nbsp;舞蹈YOO HOO</dd>
              </dl>
              <dl>
                <dt onClick="wpf_list_change(7);">8</dt>
                <dd onClick="wpf_list_change(7);">&nbsp;脱口秀</dd>
              </dl>
              <dl>
                <dt onClick="wpf_list_change(8);">9</dt>
                <dd onClick="wpf_list_change(8);">&nbsp;歌曲串烧流星雨 </dd>
              </dl>
              <dl>
                <dt onClick="wpf_list_change(9);">10</dt>
                <dd onClick="wpf_list_change(9);">&nbsp;创意舞蹈狂想曲</dd>
              </dl>
            </div>
            <div id="wpf_list">
              <div id="wpf_previous_item" onClick="wpf_list_change_rule('previous');"></div>
              <div id="wpf_next_item" onClick="wpf_list_change_rule('next');"></div>
              <script language="javascript">
var wpf_rule_array = new Array();
var wpf_corr_item = new Array();	// 节目对照表
var wpf_corr_rule = new Array();	// 规则对照表

	wpf_rule_array[0] = new Array();
	wpf_rule_array[0]['rule'] = 0;
	wpf_corr_item[1] = 0;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[0][1] = new Array();
		wpf_rule_array[0][1]['name'] = '观众';
		wpf_rule_array[0][1]['score'] = 0;
		//wpf_rule_array[0][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[0][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[0][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[0][1]['categories'] = new Array();
		wpf_rule_array[0][1]['data'] = new Array();
		
			wpf_rule_array[1] = new Array();
	wpf_rule_array[1]['rule'] = 0;
	wpf_corr_item[2] = 1;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[1][1] = new Array();
		wpf_rule_array[1][1]['name'] = '观众';
		wpf_rule_array[1][1]['score'] = 0;
		//wpf_rule_array[1][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[1][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[1][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[1][1]['categories'] = new Array();
		wpf_rule_array[1][1]['data'] = new Array();
		
			wpf_rule_array[2] = new Array();
	wpf_rule_array[2]['rule'] = 0;
	wpf_corr_item[3] = 2;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[2][1] = new Array();
		wpf_rule_array[2][1]['name'] = '观众';
		wpf_rule_array[2][1]['score'] = 0;
		//wpf_rule_array[2][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[2][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[2][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[2][1]['categories'] = new Array();
		wpf_rule_array[2][1]['data'] = new Array();
		
			wpf_rule_array[3] = new Array();
	wpf_rule_array[3]['rule'] = 0;
	wpf_corr_item[4] = 3;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[3][1] = new Array();
		wpf_rule_array[3][1]['name'] = '观众';
		wpf_rule_array[3][1]['score'] = 0;
		//wpf_rule_array[3][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[3][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[3][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[3][1]['categories'] = new Array();
		wpf_rule_array[3][1]['data'] = new Array();
		
			wpf_rule_array[4] = new Array();
	wpf_rule_array[4]['rule'] = 0;
	wpf_corr_item[5] = 4;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[4][1] = new Array();
		wpf_rule_array[4][1]['name'] = '观众';
		wpf_rule_array[4][1]['score'] = 0;
		//wpf_rule_array[4][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[4][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[4][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[4][1]['categories'] = new Array();
		wpf_rule_array[4][1]['data'] = new Array();
		
			wpf_rule_array[5] = new Array();
	wpf_rule_array[5]['rule'] = 0;
	wpf_corr_item[6] = 5;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[5][1] = new Array();
		wpf_rule_array[5][1]['name'] = '观众';
		wpf_rule_array[5][1]['score'] = 0;
		//wpf_rule_array[5][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[5][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[5][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[5][1]['categories'] = new Array();
		wpf_rule_array[5][1]['data'] = new Array();
		
			wpf_rule_array[6] = new Array();
	wpf_rule_array[6]['rule'] = 0;
	wpf_corr_item[7] = 6;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[6][1] = new Array();
		wpf_rule_array[6][1]['name'] = '观众';
		wpf_rule_array[6][1]['score'] = 0;
		//wpf_rule_array[6][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[6][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[6][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[6][1]['categories'] = new Array();
		wpf_rule_array[6][1]['data'] = new Array();
		
			wpf_rule_array[7] = new Array();
	wpf_rule_array[7]['rule'] = 0;
	wpf_corr_item[8] = 7;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[7][1] = new Array();
		wpf_rule_array[7][1]['name'] = '观众';
		wpf_rule_array[7][1]['score'] = 0;
		//wpf_rule_array[7][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[7][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[7][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[7][1]['categories'] = new Array();
		wpf_rule_array[7][1]['data'] = new Array();
		
			wpf_rule_array[8] = new Array();
	wpf_rule_array[8]['rule'] = 0;
	wpf_corr_item[9] = 8;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[8][1] = new Array();
		wpf_rule_array[8][1]['name'] = '观众';
		wpf_rule_array[8][1]['score'] = 0;
		//wpf_rule_array[8][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[8][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[8][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[8][1]['categories'] = new Array();
		wpf_rule_array[8][1]['data'] = new Array();
		
			wpf_rule_array[9] = new Array();
	wpf_rule_array[9]['rule'] = 0;
	wpf_corr_item[10] = 9;
				wpf_corr_rule[0] = 1;
				wpf_rule_array[9][1] = new Array();
		wpf_rule_array[9][1]['name'] = '观众';
		wpf_rule_array[9][1]['score'] = 0;
		//wpf_rule_array[9][1]['categories'] = ['阿里','腾讯','小米','百度','新浪'];
		//wpf_rule_array[9][1]['categories'] = ['芦铁','小蛋','郭娜','抬头丶微笑','A 亮仔-Leon ','凤','微久信-笑笑','邹曼蓉','白'];
		//wpf_rule_array[9][1]['data'] = [0,0,0,0,0,0,0,0,0];
		wpf_rule_array[9][1]['categories'] = new Array();
		wpf_rule_array[9][1]['data'] = new Array();
		
		</script>
              <div id="wpf_list_0" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目1：亲爱的小孩</dt>
                  <dd>
                    <p class="text"> <img src="http://wall.49109.com/uploadfile/2015/0130/20150130121032558.jpg"> </p>
                    <p class="cmd"> 评分命令:TP1 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_0_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="1">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd>亲爱的小孩</dd>
                </dl>
              </div>
              <div id="wpf_list_1" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目2：匆匆那年</dt>
                  <dd>
                    <p class="text"> <img src="http://wall.49109.com/uploadfile/2015/0130/20150130121030339.jpg"> </p>
                    <p class="cmd"> 评分命令:TP2 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_1_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="2">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd>匆匆那年</dd>
                </dl>
              </div>
              <div id="wpf_list_2" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目3：歌曲串烧</dt>
                  <dd>
                    <p class="text"> <img src="http://wall.49109.com/uploadfile/2015/0130/20150130121031391.jpg"> </p>
                    <p class="cmd"> 评分命令:TP3 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_2_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="3">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd>歌曲串烧</dd>
                </dl>
              </div>
              <div id="wpf_list_3" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目4： 小品：租房记 </dt>
                  <dd>
                    <p class="text"> <img src="http://wall.49109.com/uploadfile/2015/0130/20150130121036507.jpg"> </p>
                    <p class="cmd"> 评分命令:TP4 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_3_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="4">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd> 小品：租房记 </dd>
                </dl>
              </div>
              <div id="wpf_list_4" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目5：舞台剧 精神病院 </dt>
                  <dd>
                    <p class="text"> <img src="http://wall.49109.com/uploadfile/2015/0130/20150130121036286.jpg"> </p>
                    <p class="cmd"> 评分命令:TP5 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_4_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="5">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd>舞台剧 精神病院 </dd>
                </dl>
              </div>
              <div id="wpf_list_5" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目6： 小品新闻联播</dt>
                  <dd>
                    <p class="text"> <img src="http://wall.49109.com/uploadfile/2015/0130/20150130121036480.jpg"> </p>
                    <p class="cmd"> 评分命令:TP6 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_5_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="6">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd> 小品新闻联播</dd>
                </dl>
              </div>
              <div id="wpf_list_6" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目7：舞蹈YOO HOO</dt>
                  <dd>
                    <p class="text"> <img src="http://wall.49109.com/uploadfile/2015/0130/20150130121035702.jpg"> </p>
                    <p class="cmd"> 评分命令:TP7 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_6_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="7">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd>舞蹈YOO HOO</dd>
                </dl>
              </div>
              <div id="wpf_list_7" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目8：脱口秀</dt>
                  <dd>
                    <p class="text"> <img src="http://wall.49109.com/uploadfile/2015/0130/20150130121034889.jpg"> </p>
                    <p class="cmd"> 评分命令:TP8 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_7_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="8">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd>脱口秀</dd>
                </dl>
              </div>
              <div id="wpf_list_8" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目9：歌曲串烧流星雨 </dt>
                  <dd>
                    <p class="text"></p>
                    <p class="cmd"> 评分命令:TP9 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_8_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="9">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd>歌曲串烧流星雨 </dd>
                </dl>
              </div>
              <div id="wpf_list_9" class="wpf_list_item">
                <dl id="wpf_list_rule_0" class="rule desc" style="width:984px;">
                  <dt>节目10：创意舞蹈狂想曲</dt>
                  <dd>
                    <p class="text"> <img src="http://wall.49109.com/uploadfile/2015/0130/20150130121031516.jpg"> </p>
                    <p class="cmd"> 评分命令:TP10 </p>
                  </dd>
                </dl>
                <div id="wpf_list_rule_1" class="rule">
                  <div id="wpf_list_9_1" class="wpf_list_chart" style="width:984px; height:626px;"></div>
                </div>
                <dl id="wpf_list_total" class="rule total">
                  <p class="none" id="10">0</p>
                  <dt onclick="wpf_total_scroll();">揭晓</dt>
                  <dd>创意舞蹈狂想曲</dd>
                </dl>
              </div>
            </div>
            <div id="wpf_total">
              <p id="chart"></p>
            </div>
          </div>
          <!-- 控制部分 -->
          <div id="wpf_control">
            <div class="fl"><a href="javascript:void(0)" onClick="wpf_menu_list_change('wpf_menu');">节目</a> | <a href="javascript:void(0)" onClick="wpf_menu_list_change('wpf_total');">总分</a></div>
            <div class="fr">
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_0" onClick="wpf_list_change(0);" />
                节目1</label>
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_1" onClick="wpf_list_change(1);" />
                节目2</label>
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_2" onClick="wpf_list_change(2);" />
                节目3</label>
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_3" onClick="wpf_list_change(3);" />
                节目4</label>
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_4" onClick="wpf_list_change(4);" />
                节目5</label>
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_5" onClick="wpf_list_change(5);" />
                节目6</label>
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_6" onClick="wpf_list_change(6);" />
                节目7</label>
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_7" onClick="wpf_list_change(7);" />
                节目8</label>
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_8" onClick="wpf_list_change(8);" />
                节目9</label>
              <label>
                <input autocomplete="off" type="radio" name="wpf_item" id="wpf_item_radio_9" onClick="wpf_list_change(9);" />
                节目10</label>
            </div>
          </div>
        </div>
      </div>
      <script>
		/* 微评分 JS*/
		var WEIPINGFEN_SWITCH = 1;	// 开关
		var WEIPINGFEN_STATUS = 0;	// 状态，0表示停止，1表示正在运行
		
		function weipingfen(jsonStr){
			if(jsonStr.length>0 && jsonStr!=0){
				// 将JSON字符串转换为JSON对象
				var jsonObj = JSON.parse(jsonStr);
				var objUpdate = jsonObj.update;		// 更新数据
				var objType = jsonObj.type;		// 数据类型：empty空的，restart重载
				var objRemove = jsonObj.remove;		// 清除数据
				
				// 处理要更新的数据
				if(objUpdate!=''){
					var chart = 0;
					$.each(objUpdate, function(k, v){
						var allscore = 0;
						var wtci = wpf_corr_item[k];
						$.each(v, function(kk, vv){
							var wtcr = wpf_corr_rule[kk];
							var tmp_categories = new Array();
							tmp_categories = $.extend(true, {}, wpf_rule_array[wtci][wtcr]['categories']);
							var tmp_data = new Array();
							tmp_data = $.extend(true, {}, wpf_rule_array[wtci][wtcr]['data']);
							
							//alert('wtci='+wtci+',wtcr='+wtcr);
							// 计算分组用户并推送至隐藏奖池
							$.each(vv, function(kkk, vvv){
								if(kkk!='stat'){
									var cj_weipingfen_none_uid = $("#cj_weipingfen_none .item"+k+"_uid"+vvv.uid);
									//alert('奖池 '+vvv.uid+' '+cj_weipingfen_none_uid.size());
									if(cj_weipingfen_none_uid.size()==0){
										var class_text = 'item'+k+'_group'+kk+' item'+k+' item'+k+'_uid'+vvv.uid;
										var html = '<li id="uid'+vvv.uid+'" class="'+class_text+' awards_'+vvv.awards+'"><em>'+vvv.awards+'</em><b class="none">'+class_text+'</b><p class="none">'+vvv.uid+'</p><dl><dt><img src="'+vvv.avatar+'" title="'+vvv.nickname+'" />'+vvv.from_mark+'</dt><dd>'+vvv.nickname+'</dd></dl></li>';
										$("#cj_weipingfen_none").prepend(html);
										//if(cj_scroll_status==0) $("#cj_lottery_scroll ul").prepend(html);
									}
								}
							});
							
							allscore = allscore + parseInt(vv.stat);
							wpf_rule_array[wtci][wtcr]['score'] = allscore;
							
							// 评分奖池
							var cj_weipingfen_none = $("#cj_weipingfen_none .item"+k+"_group"+kk);
							// 当超过阀值时合并
							var vvLen = 0;
							//alert( '奖池'+$("#cj_weipingfen_none li").size()+',本节目本组'+cj_weipingfen_none.size()+',vvLen='+vvLen );
							if(cj_weipingfen_none.size() > 20){
								var tmp_vv = new Array();
								tmp_vv[0] = new Array();
								tmp_vv[0]['nickname'] = '全部';
								tmp_vv[0]['score'] = parseInt(vv['stat']);
								vv = [];
								vv = tmp_vv;
							
								wpf_rule_array[wtci][wtcr]['categories'] = [];
								wpf_rule_array[wtci][wtcr]['data'] = [];
								
								vvLen = -1;
							}else{
								vvLen = wpf_rule_array[wtci][wtcr]['categories'].length-1;
							}
							
							//alert('wtci='+wtci+',wtcr='+wtcr+',stat='+vv['stat']+',vvLen='+vvLen+',size='+cj_weipingfen_none.size()+',allscore='+allscore);
							
							$.each(vv, function(kkk, vvv){
								vvLen++;
								//alert('kkk='+vvv+',allscore='+allscore+' '+vvv.nickname+' '+vvv.score);
								if(kkk=='stat'){
									//allscore = allscore + parseInt(vvv);
									//wpf_rule_array[wtci][wtcr]['score'] = allscore;
									//$("#wpf_list_"+k+" #wpf_list_total p").text(vvv);
								}else{
									// 这里判断是否需要重绘图表
									if(wpf_now_list_item==wtci && wpf_now_list_rule==wtcr && (tmp_categories[vvLen]!=vvv.nickname || tmp_data[vvLen]!=parseInt(vvv.score))) chart = 1;
									
									//alert('kkk='+kkk+',vvLen='+vvLen+',nickname='+vvv.nickname);
									//alert('原数据'+tmp_categories[kkk]+','+tmp_data[kkk]);
									//alert('w_ji='+w_ji+',w_jr='+w_jr+';'+w_n+','+vvv.nickname+';'+w_s+','+parseInt(vvv.score)+';'+wpf_rule_array.toString());
									//if(wpf_now_list_item-1==wpf_jux_item[k] && wpf_now_list_rule==kk) chart = true;
									
									wpf_rule_array[wtci][wtcr]['categories'][vvLen] = vvv.nickname;
									wpf_rule_array[wtci][wtcr]['data'][vvLen] = parseInt(vvv.score);
								}
							});
						});
						var wpf_prompt_text = $("#wpf_list_"+wtci+" #wpf_list_total dt").text();
						if(wpf_prompt_text=='揭晓') $("#wpf_list_"+wtci+" #wpf_list_total p").text(allscore);
					});
					if(chart) wpf_show_chart();
				}
				
				// 处理要删除的数据
				if(objRemove!=''){
				}
			}else if(jsonStr==0){
				wpf();
			}
		}
		
		function wpf(){
		}
		
		var wpf_now = 'menu';	// 当前是 菜单menu 还是 列表list
		var wpf_now_list_item = 0;	// 当前节目ID
		var wpf_now_list_rule = 0;	// 当前显示的节目规则
		var wpf_list_item_px = 984;	// 列表项目的宽度
		var wpf_list_item_run_time = 400;	// 列表项目切换时间
		
		var wpf_rule_num = 1;
		
		// 显示节目
		function wpf_list_change(id){
			
			wpf_menu_list_change('wpf_list');
			var wpf_list_item = $("#wpf_list .wpf_list_item");
			for (var i=0; i<wpf_list_item.size(); i++) {
				$(wpf_list_item.get(i)).slideUp("slow");
			}
			$("#wpf_list_"+id).slideDown("slow");
			
			wpf_now_list_item = id;
			wpf_now_list_rule = wpf_rule_array[id]['rule'];
			
			//alert('节目:'+wpf_now_list_item+',规则:'+wpf_now_list_rule);
			$("#test_weipingfen").text('test_weipingfen: '+new Date().toLocaleTimeString()+' wpf_now_list_item='+wpf_now_list_item+',wpf_now_list_rule='+wpf_now_list_rule);
			
			$("#wpf_item_radio_"+id).attr("checked", true);
			if(wpf_now_list_rule>0) wpf_show_chart();
		}
		// 列表页的 上一页 下一页
		function wpf_list_change_rule(type){
			
			var wpf_list_item_rule = $("#wpf_list #wpf_list_"+wpf_now_list_item+" .rule");
			
			wpf_now_list_rule = wpf_rule_array[wpf_now_list_item]['rule'];
			
			if(type=='previous'){	// 上一页
				if(wpf_now_list_rule==0) return false;
				
				// 如果只有一个分组，刚直接跳至揭晓页
				if(wpf_now_list_rule==2 && wpf_rule_num==1){
					$(wpf_list_item_rule.get(wpf_now_list_rule)).animate({width:'0px'},wpf_list_item_run_time);
					wpf_now_list_rule--;
				}
				
				$(wpf_list_item_rule.get(wpf_now_list_rule)).animate({width:'0px'},wpf_list_item_run_time);
				wpf_now_list_rule--;
				
			}else if(type=='next'){	// 下一页
				
				if(wpf_now_list_rule+1>=wpf_list_item_rule.size()) return false;
				
				// 如果只有一个分组，刚直接跳至揭晓页
				if(wpf_now_list_rule==0 && wpf_rule_num==1){
					$(wpf_list_item_rule.get(wpf_now_list_rule)).animate({width:'0px'},wpf_list_item_run_time);
					wpf_now_list_rule++;
				}
				
				$(wpf_list_item_rule.get(wpf_now_list_rule)).animate({width:'0px'},wpf_list_item_run_time);
				wpf_now_list_rule++;
			}
			$(wpf_list_item_rule.get(wpf_now_list_rule)).animate({width:wpf_list_item_px+'px'},wpf_list_item_run_time);
			wpf_rule_array[wpf_now_list_item]['rule'] = wpf_now_list_rule;
			
			$("#test_weipingfen").text('test_weipingfen: '+new Date().toLocaleTimeString()+' wpf_now_list_item='+wpf_now_list_item+',wpf_now_list_rule='+wpf_now_list_rule+',size='+wpf_list_item_rule.size());
			
			//alert('wpf_list_change_rule type='+type+',wpf_now='+wpf_now+',wpf_now_list_item='+wpf_now_list_item+',wpf_now_list_rule='+wpf_now_list_rule);
			
			wpf_show_chart();
		}
		
		// 部分滚动
		function wpf_total_scroll(){
			var num = parseInt($("#wpf_list_"+wpf_now_list_item+" #wpf_list_total p").text());
			var dtnum = parseInt($("#wpf_list_"+wpf_now_list_item+" #wpf_list_total dt").text());
			if(!num || num==dtnum) return false;
			var startNum = 0;
			var addNum = Math.ceil(num/198);
			function wpf_total_scroll_add(){
				if(num>=startNum){
					$("#wpf_list_"+wpf_now_list_item+" #wpf_list_total dt").text(startNum);
					startNum = startNum + addNum;
					window.setTimeout(wpf_total_scroll_add, 20);
				}else{
					$("#wpf_list_"+wpf_now_list_item+" #wpf_list_total dt").text(num);
					$("#wpf_list_"+wpf_now_list_item+" #wpf_list_total dt").animate({'font-size':'10px'}, 200);
					$("#wpf_list_"+wpf_now_list_item+" #wpf_list_total dt").animate({'font-size':'120px'}, 100);
					$("#wpf_list_"+wpf_now_list_item+" #wpf_list_total dt").animate({'font-size':'10px'}, 300);
					$("#wpf_list_"+wpf_now_list_item+" #wpf_list_total dt").animate({'font-size':'150px'}, 150);
				}
			}
			wpf_total_scroll_add();
		}
		
		// 切换 菜单页 与 列表页
		function wpf_menu_list_change(box){
			if(box=='wpf_menu'){
				wpf_now = 'menu';
				$("#wpf_list").slideUp("slow");
				$("#wpf_total").slideUp("slow");
				$("#wpf_menu").slideDown("slow");
			}else if(box=='wpf_list'){
				wpf_now = 'list';
				$("#wpf_menu").slideUp("slow");
				$("#wpf_total").slideUp("slow");
				$("#wpf_list").slideDown("slow");
			}else if(box=='wpf_total'){
				wpf_now = 'total';
				$("#wpf_menu").slideUp("slow");
				$("#wpf_list").slideUp("slow");
				$("#wpf_total").slideDown("slow");
				
				$("#wpf_item_radio_"+wpf_now_list_item).attr("checked", false);
				
				wpf_total_timing();
			}
		}
		
		// 显示当前节目，当前规则图 带参数
		function wpf_show_chart_para(id, name, cate, data, margin){
			$(id).highcharts({
				chart: {
					type: 'column',
					margin: margin
				},
				title: {
					text: name,
					style: {
						textShadow: '0 0 0 black'
					}
				},
				xAxis: {
					categories: cate,
					labels: {
						rotation: -45,
						align: 'right',
						style: {
							fontSize: '16px',
							fontFamily: 'Verdana, sans-serif',
							textShadow: '0 0 0 black'
						}
					}
				},
				yAxis: {
					min: 0,
					title: {
						text: '单位：票'
					},
					labels: {
						style: {
							textShadow: '0 0 0 black'
						}
					}
				},
				legend: {
					enabled: false
				},
				tooltip: {
					pointFormat: '<b style="font-size:40px;text-shadow: 0 0 0 #ffffff;">{point.y:f}票</b>'
				},
				series: [{
					name: 'Population',
					data: data,
					dataLabels: {
						enabled: true,
						rotation: -90,
						color: '#FFFFFF',
						align: 'right',
						x: 4,
						y: 10,
						style: {
							fontSize: '30px',
							fontFamily: 'Verdana, sans-serif',
							textShadow: '0 0 3px black'
						}
					}
				}],
				credits: {
					enabled: false
				},
				exporting: {
					enabled: false
				}
			});
		}
		// 显示当前节目，当前规则图表
		function wpf_show_chart(){
			
			wpf_now_list_rule = wpf_rule_array[wpf_now_list_item]['rule'];
			//alert('wpf_show_chart wpf_now_list_item='+wpf_now_list_item+',wpf_now_list_rule='+wpf_now_list_rule);
			
			var catArr = new Array();
			catArr = wpf_rule_array[wpf_now_list_item][wpf_now_list_rule]['categories'];
			var dataArr = new Array();
			dataArr = wpf_rule_array[wpf_now_list_item][wpf_now_list_rule]['data'];
			var titStr = '共'+wpf_rule_array[wpf_now_list_item][wpf_now_list_rule]['score']+'票';
			
			//alert('wpf_show_chart catArr='+catArr.toString()+',dataArr='+dataArr.toString());
			var id = '#wpf_list_'+wpf_now_list_item+'_'+wpf_now_list_rule;
			var margin = new Array(50, 30, 80, 60);
			wpf_show_chart_para(id, titStr, catArr, dataArr, margin);
		}
		
		// 总分
		var WPF_TOTAL_SWITCH = 0;	// 总分状态开关，0表示停止，1表示正在运行
		function wpf_total_timing(){
			if(WPF_TOTAL_SWITCH)
				return false;
			else
				WPF_TOTAL_SWITCH = 1;
			
			$("#wpf_total #timing b").text(3);
			$("#wpf_total #timing").css('display','block');
			$("#wpf_total #chart").css('display','none');
			//var ttnum = parseInt($("#wpf_total #timing b").text());
			var ttnum = 0;
			function wpf_total_timing_chart(){
				var wpf_timing_item_total_value = new Array();
				var wpf_timing_item_name_value = new Array();
				
				var wpf_timing_item_total = $("#wpf_list .wpf_list_item #wpf_list_total p");
				var wpf_total_max = 0;
				var wpf_total_max_ids = '';
				for (var i = 0; i < wpf_timing_item_total.size(); i++) {
					var wpf_tmp_total = parseInt($(wpf_timing_item_total.get(i)).text())
					wpf_timing_item_total_value[i] = wpf_tmp_total;
					
					var wpf_tmp_id = parseInt($(wpf_timing_item_total.get(i)).attr("id"));
					if(wpf_tmp_total > wpf_total_max){
						wpf_total_max = wpf_tmp_total;
						wpf_total_max_ids = wpf_tmp_id;
					}else if(wpf_total_max == wpf_tmp_total){
						wpf_total_max_ids = wpf_total_max_ids+','+wpf_tmp_id;
					}
				}
				// 在抽奖部分用到的参数
				cj_awards_item = wpf_total_max_ids.toString();
				
				var wpf_timing_item_name = $("#wpf_list .wpf_list_item #wpf_list_total dd");
				for (var i = 0; i < wpf_timing_item_name.size(); i++) {
					wpf_timing_item_name_value[i] = $(wpf_timing_item_name.get(i)).text();
				}
				var margin = new Array(50, 30, 150, 60);
				wpf_show_chart_para('#wpf_total #chart', '节目总分榜', wpf_timing_item_name_value, wpf_timing_item_total_value, margin);
				
				WPF_TOTAL_SWITCH = 0;
			}
			function wpf_total_timing_zoom(){
				if(ttnum>0){
					$("#wpf_total #timing b").animate({'font-size':'10px'}, 150+ttnum*60);
					$("#wpf_total #timing b").animate({'font-size':'200px'}, 50+ttnum*20);
					ttnum--;
					$("#wpf_total #timing b").text(ttnum);
					window.setTimeout(wpf_total_timing_zoom, 300+ttnum*150);
				}else{
					$("#wpf_total #timing").slideUp(300);
					$("#wpf_total #chart").slideDown(10);
					window.setTimeout(wpf_total_timing_chart, 350);
				}
				
			}
			//alert(WPF_TOTAL_SWITCH+','+ttnum);
			window.setTimeout(wpf_total_timing_zoom, 400);
		}
		
		function wpf_old(){
			var wpf_list = $(".wpf_list dl");
			var wpf_list_size = wpf_list.size();
			var wpf_list_dl_w = (1004/wpf_list_size)-20;
			var wpf_list_dl_width = Math.floor(wpf_list_dl_w);
			for (var i=0; i<wpf_list.size(); i++) {
				$(wpf_list.get(i)).css("width", wpf_list_dl_width+"px");
			}
		}
		</script> </div>
    <div id="tiwenqiang" class="boxitem"> 
      
      <!--* 无右侧 START *-->
      <div id="twq">
        <div style="height:636px; overflow:hidden;">
          <div class="twq_left">
            <ul id="twq_list_stop" class="none">
            </ul>
            <ul id="twq_list" class="twq_list">
            </ul>
          </div>
        </div>
      </div>
      <script>
		/* 大屏幕 JS*/
		var TIWENQIANG_SWITCH = 1;	// 开关
		var TIWENQIANG_STATUS = 0;	// 状态，0停止，1正在运行
		var TIWENQIANG_CLICK = 1;		// 底部控制栏播放器状态，0停止，1运行
		
		var twq_sn = 1;
		var twq_run_time = 500;	// 运行时间
		var twq_wait_time = 6000;	// 等待时间
		var twq_up_px = 636;
		
		var twq_show_time = 1;	// 内容前面是否显示时间
		
		var twq_scroll_px = 15;		// 滚动动画像素值
		var twq_scroll_num = 10;	// 滚动动画次数
		var twq_scroll_time = 10;	// 滚动动画间隔
		
		$(document).ready(function(){
			//window.setTimeout(twq, twq_wait_time);
			setInterval("twq();", twq_wait_time); 
		});
				
		function tiwenqiang(jsonStr){
			if(jsonStr.length>0 && jsonStr!=0){
				// 将JSON字符串转换为JSON对象
				var jsonObj = JSON.parse(jsonStr);
				var objUpdate = jsonObj.update;		// 更新数据
				var objType = jsonObj.type;		// 数据类型：empty空的，restart重载
				var objRemove = jsonObj.remove;		// 清除数据
				// 开始处理数据
				$("#test2").text('tiwenqiang:'+jsonStr);
				$("#test_tiwenqiang").text('进入tiwenqiang()');
				// 处理要更新的数据
				if(objUpdate!=''){
					TIWENQIANG_SWITCH = 0;
					$("#test5").text('遍历前'+new Date().getTime()+';');
					var qdq_update = 0;	// 是否更新过签到墙信息
					$.each(objUpdate, function(k, v){
						$("#test_tiwenqiang").text('content='+v.content);
						var timestr = '';
						var timeFormat = '';
						if(twq_show_time==1) timeFormat = 'hm'; else if(twq_show_time==2) timeFormat = 'md'; else if(twq_show_time==3) timeFormat = 'mdhm';
						//if(twq_show_time) timestr = '['+formatDateTime(v.caudit,timeFormat)+'] ';	// 判断是否需要显示时间
						if(twq_show_time==4){
							timestr = v.floor+'楼 ';
						}else if(twq_show_time){
							timestr = '['+formatDateTime(v.caudit,timeFormat)+'] ';	// 判断是否需要显示时间
						}
						
						var img = '';
						var liClass = '';
						var picStype = '';
						var msgtype = '';
						var info = '<li'+liClass+' id="cid'+v.cid+'"><div class="close"><img src="/Public/Screen/images/button_twq_close.png" onclick=\'$(".twq_list #cid'+v.cid+'").remove();\' /></div><div class="fl"><dl><dt><img src="'+v.avatar+'" title="'+v.nickname+'" />'+v.from_mark+'</dt><dd class="font30">'+v.nickname+'</dd></dl></div><div class="fr"><dl><dd>'+img+timestr+msgtype+v.content+'</dd></dl></div></li>';
						//$(info).prependTo(".twq_list").hide().slideDown('slow');
						if(TIWENQIANG_CLICK){
							$(".twq_list").prepend(info);
						}else{
							$("#twq_list_stop").prepend(info);
						}
						$("#test5").text($("#test5").text()+'遍历中'+new Date().getTime());
						
						// 更新签到墙部分
						var qdq_uid = $("#qdq_list #uid"+v.uid+" dt").text();
						var avatar = '';
						if(qdq_uid=='none'){
							avatar = v.avatar;
							if(avatar.indexOf("avatar.gif")>0) avatar = 'none';
							//alert('大屏幕 更新'+v.uid+' 的头像'+avatar+',呢称'+v.nickname)
							$("#qdq_list #uid"+v.uid+" dt").text(avatar);
							$("#qdq_list #uid"+v.uid+" dd").text(v.nickname);
							qdq_update = 1;
						}
						
					});
					
					if(now_module_name=='qiandaoqiang' && qdq_update) qdq_player(1);
					
					$("#test5").text($("#test5").text()+';遍历后'+new Date().getTime());
					if(TIWENQIANG_CLICK){
						twq_del_list();
					}
					
					twqlistToTop();
				}
				// 处理要删除的数据
				if(objRemove!=''){
					$("#test_tiwenqiang").text('objRemove存在 objRemove='+objRemove);
					
					TIWENQIANG_SWITCH = 0;
					$.each(objRemove, function(k, v){
						$(".twq_list #cid"+v.cid).remove();
					});
					//$("#test_tiwenqiang").text(jsonStr);
					//twq_reorder();
					TIWENQIANG_SWITCH = 1;
				}
				
			}else if(jsonStr==0){
				TIWENQIANG_STATUS = 1;
			}
		}
		
		var twqlistElem = document.getElementById("twq_list");
		
		// 删除多余的内容，随着上墙内容的动态更新，越来越多的内容导致滚动次数过多，因此在这里只保留20个内容
		var twq_num = 100;	// 保留最大条数
		function twq_del_list(){
			for( ; $(".twq_list li").size()>twq_num ; ){
				//$("#test4").text($(".dpm_list li").size());
				$(".twq_list li:last").remove();
			}
			//twqlistElem.scrollTop = 0;
			//twqlistToTop();
			//var twq_list = $(".twq_list");
			//twq_list.animate({'margin-top':'0px'},twq_run_time);
			//window.setTimeout(dpm_restart, wxq_wait_time*1.1);
		}
		
		function twq(){
			if(!TIWENQIANG_CLICK) return false;
			if(TIWENQIANG_SWITCH && TIWENQIANG_STATUS){
				var twq_list = $(".twq_list");
				var twq_list_size = $(".twq_list li").size();	// 调查项目数
				var twq_screen = Math.ceil(twq_list_size / 3);
				$("#test2").text("twq_list_size="+twq_list_size+",twq_screen="+twq_screen+",twq_sn="+twq_sn+",height="+$(".twq_list").css("height"));
				/* 方式一 *
				if(twq_sn >= twq_screen){
					twq_list.animate({'margin-top':'0px'},twq_run_time);
					twq_sn=1;
				}else{
					var px = twq_sn*twq_up_px+twq_sn*13;
					twq_list.animate({'margin-top':'-'+px+'px'},twq_run_time);
					twq_sn++;
				}
				/* 方式二 *
				var twqHeight = parseInt($(".twq_list").css("height"))-twq_sn*twq_bug_px;
				var twqRemain = twqHeight-twq_sn*twq_up_px;
				if(twqRemain > 0){
					//var px = twq_sn*twq_up_px+13;
					var px = twq_sn*twq_up_px+twq_sn*twq_bug_px;
					twq_list.animate({'margin-top':'-'+px+'px'},twq_run_time);
					twq_sn++;
					$("#test1").text('twqHeight='+twqHeight+',twq_sn='+twq_sn+',px='+px+', twqRemain='+twqRemain);
				}else{
					twq_list.animate({'margin-top':'0px'},twq_run_time);
					twq_sn=1;
					$("#test1").text('twqHeight='+twqHeight+',twq_sn='+twq_sn+',twqRemain='+twqRemain);
				}
				
				/* 方式三 */
				var twqlistScrollTop = twqlistElem.scrollTop;
				twqlistElem.scrollTop = twqlistElem.scrollTop + twq_scroll_px;
				if(twqlistElem.scrollTop==twqlistScrollTop){
					//twqlistElem.scrollTop = 0;
					//alert('已到底');
					twqlistToTop();
				}else{
					//alert('向上滚动');
					var i = 0;
					function twqlistScroll(){
						twqlistElem.scrollTop = twqlistElem.scrollTop + twq_scroll_px;
						i++;
						if(i>=twq_scroll_num) i=0; else window.setTimeout(twqlistScroll, twq_scroll_time);
					}
					window.setTimeout(twqlistScroll, twq_scroll_time);
				}
				//window.setTimeout(twq, twq_wait_time);
			}else{
				twq_sn = 1;
				TIWENQIANG_SWITCH = 1;
			}
		}
		
		/*返回顶部简单效果*/
		function twqlistToTop(){
			//alert('twqlistToTop');
			twqlistElem.scrollTop = twq_scroll_num*twq_scroll_px;
			function twqlistToTopEffect(){
				twqlistElem.scrollTop = twqlistElem.scrollTop - twq_scroll_px;
				if(twqlistElem.scrollTop>0) window.setTimeout(twqlistToTopEffect, twq_scroll_time);
			}
			window.setTimeout(twqlistToTopEffect, twq_scroll_time);
		}
		
		//var twq_listElem = document.getElementById("twq_list");
		//var twq_list_scrollTop = twq_listElem.scrollTop;
		
		// 响应底部播放栏
		function tiwenqiang_click(button){
			if(button=='change'){
				if(TIWENQIANG_CLICK){
					TIWENQIANG_CLICK = 0;
				}else{
					$(".twq_list").prepend( $("#twq_list_stop").html() );
					$("#twq_list_stop").html('');
					twq_del_list();
					TIWENQIANG_CLICK = 1;
				}
				return true;
			}
			if(button=='top'){
				var i = 0;
				function twqlistScrollTop(){
					twqlistElem.scrollTop = twqlistElem.scrollTop-20;
					i++;
					if(i>=10) i=0; else window.setTimeout(twqlistScrollTop, 10);
				}
				window.setTimeout(twqlistScrollTop, 10);
			}else if(button=='next'){
				var i = 0;
				function twqlistScrollNext(){
					twqlistElem.scrollTop = twqlistElem.scrollTop+20;
					i++;
					if(i>=10) i=0; else window.setTimeout(twqlistScrollNext, 10);
				}
				window.setTimeout(twqlistScrollNext, 10);
			}
		}
		</script> 
      <!--* 无右侧 END *--> 
    </div>
    <div id="datiban" class="boxitem"> 
      
      <!--* 无右侧 START *-->
      <div id="dtb">
        <div style="height:636px; overflow:hidden;">
          <div class="dtb_left">
            <ul id="dtb_list_stop" class="none">
            </ul>
            <ul id="dtb_list" class="dtb_list">
            </ul>
          </div>
        </div>
      </div>
      <script>
		/* 大屏幕 JS*/
		var DATIBAN_SWITCH = 1;	// 开关
		var DATIBAN_STATUS = 0;	// 状态，0停止，1正在运行
		var DATIBAN_CLICK = 1;		// 底部控制栏播放器状态，0停止，1运行
		
		var dtb_sn = 1;
		var dtb_run_time = 500;	// 运行时间
		var dtb_wait_time = 5000;	// 等待时间
		var dtb_up_px = 636;
		
		var dtb_show_time = 1;	// 内容前面是否显示时间
		
		var dtb_scroll_px = 15;		// 滚动动画像素值
		var dtb_scroll_num = 10;	// 滚动动画次数
		var dtb_scroll_time = 10;	// 滚动动画间隔
		
		$(document).ready(function(){
			//window.setTimeout(dtb, dtb_wait_time);
			setInterval("dtb();", dtb_wait_time); 
		});
				
		function datiban(jsonStr){
			if(jsonStr.length>0 && jsonStr!=0){
				// 将JSON字符串转换为JSON对象
				var jsonObj = JSON.parse(jsonStr);
				var objUpdate = jsonObj.update;		// 更新数据
				var objType = jsonObj.type;		// 数据类型：empty空的，restart重载
				var objRemove = jsonObj.remove;		// 清除数据
				// 开始处理数据
				$("#test_dtb").text('datiban:'+jsonStr);
				// 处理要更新的数据
				if(objUpdate!=''){
					DATIBAN_SWITCH = 0;
					$("#test_dtb").text('遍历前'+new Date().getTime()+';');
					var qdq_update = 0;	// 是否更新过签到墙信息
					$.each(objUpdate, function(k, v){
						$("#test_dtb").text('content='+v.content);
						var timestr = '';
						var timeFormat = '';
						if(dtb_show_time==1) timeFormat = 'hm'; else if(dtb_show_time==2) timeFormat = 'md'; else if(dtb_show_time==3) timeFormat = 'mdhm';
						//if(dtb_show_time) timestr = '['+formatDateTime(v.caudit,timeFormat)+'] ';	// 判断是否需要显示时间
						if(dtb_show_time==4){
							timestr = v.floor+'楼 ';
						}else if(dtb_show_time){
							timestr = '['+formatDateTime(v.caudit,timeFormat)+'] ';	// 判断是否需要显示时间
						}
						
						var info = '<li id="cid'+v.cid+'"><div class="close"><img src="/Public/Screen/images/button_dtb_close.png" onclick=\'$(".dtb_list #cid'+v.cid+'").remove();\' /></div><div class="fl"><dl><dt><img src="'+v.avatar+'" title="'+v.nickname+'" />'+v.from_mark+'</dt><dd class="font30">'+v.nickname+'</dd></dl></div><div class="fr"><dl><dd>'+timestr+v.content+'</dd></dl></div></li>';
						//$(info).prependTo(".dtb_list").hide().slideDown('slow');
						if(DATIBAN_CLICK){
							$(".dtb_list").prepend(info);
						}else{
							$("#dtb_list_stop").prepend(info);
						}
						//$("#test5").text($("#test5").text()+'遍历中'+new Date().getTime());
						
						// 更新签到墙部分
						var qdq_uid = $("#qdq_list #uid"+v.uid+" dt").text();
						var avatar = '';
						if(qdq_uid=='none'){
							avatar = v.avatar;
							if(avatar.indexOf("avatar.gif")>0) avatar = 'none';
							//alert('大屏幕 更新'+v.uid+' 的头像'+avatar+',呢称'+v.nickname)
							$("#qdq_list #uid"+v.uid+" dt").text(avatar);
							$("#qdq_list #uid"+v.uid+" dd").text(v.nickname);
							qdq_update = 1;
						}
						
						// 添加至隐藏奖池
						var cj_datiban_none_uid = $("#cj_datiban_none_all #uid"+v.uid);
						//alert('奖池 '+v.uid+' '+cj_datiban_none_uid.size());
						if(cj_datiban_none_uid.size()==0){
							var html = '<li id="uid'+v.uid+'" class="awards_0"><em class="none">0</em><p class="none">'+v.uid+'</p><dl><dt><img src="'+v.avatar+'" title="'+v.nickname+'" />'+v.from_mark+'</dt><dd>'+v.nickname+'</dd></dl></li>';
							$("#cj_datiban_none_all").prepend(html);
							$("#cj_datiban_none").prepend(html);
							//if(cj_scroll_status==0) $("#cj_lottery_scroll ul").prepend(html);
						}
						
					});
					
					if(now_module_name=='qiandaoqiang' && qdq_update) qdq_player(1);
					
					$("#test_dtb").text($("#test_dtb").text()+';遍历后'+new Date().getTime());
					if(DATIBAN_CLICK){
						dtb_del_list();
					}
					
					dtblistToTop();
				}
				// 处理要删除的数据
				if(objRemove!=''){
					$("#test_dtb").text('objRemove存在 objRemove='+objRemove);
					
					DATIBAN_SWITCH = 0;
					$.each(objRemove, function(k, v){
						$(".dtb_list #cid"+v.cid).remove();
					});
					//$("#test_datiban").text(jsonStr);
					//dtb_reorder();
					DATIBAN_SWITCH = 1;
				}
				
			}else if(jsonStr==0){
				DATIBAN_STATUS = 1;
			}
		}
		
		var dtblistElem = document.getElementById("dtb_list");
		
		// 删除多余的内容，随着上墙内容的动态更新，越来越多的内容导致滚动次数过多，因此在这里只保留20个内容
		var dtb_num = 100;	// 保留最大条数
		function dtb_del_list(){
			for( ; $(".dtb_list li").size()>dtb_num ; ){
				//$("#test4").text($(".dpm_list li").size());
				$(".dtb_list li:last").remove();
			}
			//dtblistElem.scrollTop = 0;
			//dtblistToTop();
			//var dtb_list = $(".dtb_list");
			//dtb_list.animate({'margin-top':'0px'},dtb_run_time);
			//window.setTimeout(dpm_restart, wxq_wait_time*1.1);
		}
		
		function dtb(){
			if(!DATIBAN_CLICK) return false;
			if(DATIBAN_SWITCH && DATIBAN_STATUS){
				var dtb_list = $(".dtb_list");
				var dtb_list_size = $(".dtb_list li").size();	// 调查项目数
				var dtb_screen = Math.ceil(dtb_list_size / 3);
				$("#test2").text("dtb_list_size="+dtb_list_size+",dtb_screen="+dtb_screen+",dtb_sn="+dtb_sn+",height="+$(".dtb_list").css("height"));
				/* 方式一 *
				if(dtb_sn >= dtb_screen){
					dtb_list.animate({'margin-top':'0px'},dtb_run_time);
					dtb_sn=1;
				}else{
					var px = dtb_sn*dtb_up_px+dtb_sn*13;
					dtb_list.animate({'margin-top':'-'+px+'px'},dtb_run_time);
					dtb_sn++;
				}
				/* 方式二 *
				var dtbHeight = parseInt($(".dtb_list").css("height"))-dtb_sn*dtb_bug_px;
				var dtbRemain = dtbHeight-dtb_sn*dtb_up_px;
				if(dtbRemain > 0){
					//var px = dtb_sn*dtb_up_px+13;
					var px = dtb_sn*dtb_up_px+dtb_sn*dtb_bug_px;
					dtb_list.animate({'margin-top':'-'+px+'px'},dtb_run_time);
					dtb_sn++;
					$("#test1").text('dtbHeight='+dtbHeight+',dtb_sn='+dtb_sn+',px='+px+', dtbRemain='+dtbRemain);
				}else{
					dtb_list.animate({'margin-top':'0px'},dtb_run_time);
					dtb_sn=1;
					$("#test1").text('dtbHeight='+dtbHeight+',dtb_sn='+dtb_sn+',dtbRemain='+dtbRemain);
				}
				
				/* 方式三 */
				var dtblistScrollTop = dtblistElem.scrollTop;
				dtblistElem.scrollTop = dtblistElem.scrollTop + dtb_scroll_px;
				if(dtblistElem.scrollTop==dtblistScrollTop){
					//dtblistElem.scrollTop = 0;
					//alert('已到底');
					dtblistToTop();
				}else{
					//alert('向上滚动');
					var i = 0;
					function dtblistScroll(){
						dtblistElem.scrollTop = dtblistElem.scrollTop + dtb_scroll_px;
						i++;
						if(i>=dtb_scroll_num) i=0; else window.setTimeout(dtblistScroll, dtb_scroll_time);
					}
					window.setTimeout(dtblistScroll, dtb_scroll_time);
				}
				//window.setTimeout(dtb, dtb_wait_time);
			}else{
				dtb_sn = 1;
				DATIBAN_SWITCH = 1;
			}
		}
		
		/*返回顶部简单效果*/
		function dtblistToTop(){
			//alert('dtblistToTop');
			dtblistElem.scrollTop = dtb_scroll_num*dtb_scroll_px;
			function dtblistToTopEffect(){
				dtblistElem.scrollTop = dtblistElem.scrollTop - dtb_scroll_px;
				if(dtblistElem.scrollTop>0) window.setTimeout(dtblistToTopEffect, dtb_scroll_time);
			}
			window.setTimeout(dtblistToTopEffect, dtb_scroll_time);
		}
		
		//var dtb_listElem = document.getElementById("dtb_list");
		//var dtb_list_scrollTop = dtb_listElem.scrollTop;
		
		// 响应底部播放栏
		function datiban_click(button){
			//alert(button)
			
			if(button=='change'){
				if(DATIBAN_CLICK){
					DATIBAN_CLICK = 0;
				}else{
					$(".dtb_list").prepend( $("#dtb_list_stop").html() );
					$("#dtb_list_stop").html('');
					dtb_del_list();
					DATIBAN_CLICK = 1;
				}
				return true;
			}
			if(button=='top'){
				var i = 0;
				function dtblistScrollTop(){
					dtblistElem.scrollTop = dtblistElem.scrollTop-20;
					i++;
					if(i>=10) i=0; else window.setTimeout(dtblistScrollTop, 10);
				}
				window.setTimeout(dtblistScrollTop, 10);
			}else if(button=='next'){
				var i = 0;
				function dtblistScrollNext(){
					dtblistElem.scrollTop = dtblistElem.scrollTop+20;
					i++;
					if(i>=10) i=0; else window.setTimeout(dtblistScrollNext, 10);
				}
				window.setTimeout(dtblistScrollNext, 10);
			}
		}
		</script> 
      <!--* 无右侧 END *--> 
    </div>
    <div id="bimuqiang" class="boxitem">
      <div id="bmq"><?php echo ($field["bimuqiang"]); ?> </div>
      <script language="javascript">
		var BIMUQIANG_SWITCH = 1;	// 开关
		var BIMUQIANG_STATUS = 0;	// 状态，0表示停止，1表示正在运行
		
		// 闭幕墙
		function bimuqiang(jsonStr){
			if(jsonStr.length>0 && jsonStr!=0){
				// 将JSON字符串转换为JSON对象
				var jsonObj = JSON.parse(jsonStr);
				var objUpdate = jsonObj.update;		// 更新数据
				var objType = jsonObj.type;		// 数据类型：empty空的，restart重载
				var objRemove = jsonObj.remove;		// 清除数据
				// 开始处理数据
				// 处理要更新的数据
				if(objUpdate!=''){
					$("#bmq").html(objUpdate);
					if(objType=='restart' && now_module_name=='bimuqiang') boxConItem('bimuqiang');
				}
				
				/*
				switch(objType){
				case 'restart' : 
					$("#bmq").html(objData);
					if(now_module_name=='bimuqiang') boxConItem('bimuqiang');
					break;
				case 'update' : $("#bmq").html(objData); break;
				case 'remove' : break;
				}*/
			}else if(jsonStr==0){
				bmq();
			}
		}
		
		function bmq(){
		}
		</script> </div>
  </div>
  <div id="boxControl" onMouseDown="boxCon();">
    <div class="bcbox"><img id="boxContGuide" src="/Public/Screen/images/menu_guide_up.png" /></div>
    <div class="item">
      <ul id="boxControl_ul">
        <li id="kaimuqiang" onMouseDown="boxConItem('kaimuqiang');" time="1427882158"><img src="/Public/Screen/images/menu_kaimuqiang.png" />开幕墙</li>
        <li id="xuyuanqiang" onMouseDown="boxConItem('xuyuanqiang');" time="1427882158"><img src="/Public/Screen/images/menu_xuyuanqiang.png" />许愿墙</li>
        <li id="dapingmu" onMouseDown="boxConItem('dapingmu');" time="1423016559397"><img src="/Public/Screen/images/menu_dapingmu.png" />微信墙</li>
        <li id="choujiang" onMouseDown="boxConItem('choujiang');" time="1422606677125"><img src="/Public/Screen/images/menu_choujiang.png" />抽奖</li>
        <li id="weipingfen" onMouseDown="boxConItem('weipingfen');" time="0"><img src="/Public/Screen/images/menu_weipingfen.png" />评分</li>
        <li id="bimuqiang" onMouseDown="boxConItem('bimuqiang');" time="1427882158"><img src="/Public/Screen/images/menu_bimuqiang.png" />闭幕墙</li>
      </ul>
      <ul id="boxControl_click">
        <li id="click_top" onMouseDown="clickControl('top')"><img src="/Public/Screen/images/click_top.png" title="上一屏" /></li>
        <li id="click_change" onMouseDown="clickControl('change')"><img src="/Public/Screen/images/click_stop.png" title="播放/暂停" /></li>
        <li id="click_next" onMouseDown="clickControl('next')"><img src="/Public/Screen/images/click_next.png" title="下一屏" /></li>
        <script language="javascript">
				function detectClickControl(){
					
					if(now_module_name=='dapingmu' || now_module_name=='tiwenqiang' || now_module_name=='datiban'){
						$("#boxControl_click").removeClass("none");
					}else{
						$("#boxControl_click").addClass("none");
					}
				}
				function clickControl(button){
					if(button=='change'){
						var ucModuleName = now_module_name.toUpperCase();
						var clickSwitch = eval(ucModuleName+"_CLICK;");
						//alert('button='+button+',DAPINGMU_CLICK='+DAPINGMU_CLICK+',ucModuleName='+ucModuleName+',clickSwitch='+clickSwitch);
						if(clickSwitch){
							//DAPINGMU_CLICK = 0;
							//eval(ucModuleName+"_CLICK = 0;");
							$("#click_change").html('<img src="/Public/Screen/images/click_play.png" />');
						}else{
							//DAPINGMU_CLICK = 1;
							//eval(ucModuleName+"_CLICK = 1;");
							$("#click_change").html('<img src="/Public/Screen/images/click_stop.png" />');
						}
					}
					//dapingmu_click(button);
					eval(now_module_name+"_click('"+button+"');");
				}
				
				</script>
      </ul>
      <div class="fun"><img id="networkstatus_yes" src="/Public/Screen/images/network_yes.png" title="当前网络连接正常！" class="none" /><img id="networkstatus_no" src="/Public/Screen/images/network_no.png" title="网络已断开！" class="none" /> 版权所有</div>
    </div>
  </div>
</div>
<script language="javascript">

var Timestamp = new Array();

var ajax_pull_time = 6000;	
var ajax_pull_status = 1;	
var ajax_pull_watch = 0;	

function screen_init(){
	
	if(id!=38) ScrollImgLeft();
	
	var boxControl_li = $("#boxControl_ul li");
	for(var i=0; i<boxControl_li.size(); i++){
		var key = $(boxControl_li.get(i)).attr("id");
		var time = $(boxControl_li.get(i)).attr("time");
		Timestamp[key] = time;
		$("#test3").text($("#test3").text()+key+":"+time+";");
		
		if(i==0) now_module_name = key;
	}
	//if(getModule) eval("boxConItem('"+getModule+"');"); else eval(now_module_name+"(0);");
	if(getModule) eval("boxConItem('"+getModule+"');"); else eval("boxConItem('"+now_module_name+"');");
	
	//ajax_screen_pull();
	setInterval(ajax_screen_for_pull, ajax_pull_time);
	
	detectClickControl();
}

function ajax_screen_pull(){
	
	ajax_pull_status = 0;
	
	var timeStr = new Date().toLocaleTimeString();
	$("#json").text(timeStr);
	
	$.getJSON('index.php?m=member&c=screen_pull&a=ajax_init', {
		catid:101, id:755,
				kaimuqiang:Timestamp['kaimuqiang'],
				guizeqiang:Timestamp['guizeqiang'],
				qiandaoqiang:Timestamp['qiandaoqiang'],
				jiabinzhanshi:Timestamp['jiabinzhanshi'],
				xuyuanqiang:Timestamp['xuyuanqiang'],
				dapingmu:Timestamp['dapingmu'],
				choujiang:Timestamp['choujiang'],
				weipingfen:Timestamp['weipingfen'],
				tiwenqiang:Timestamp['tiwenqiang'],
				datiban:Timestamp['datiban'],
				bimuqiang:Timestamp['bimuqiang'],
				test:1
		}, function(data){
			$("#json").text("["+timeStr+"] "+data);
			$("#json1").text("["+timeStr+"] "+JSON.stringify(data));
			
			var printStr = '';
			$.each(data, function(mkey, module){
				
				var jsonStr = '';
				if(module.type!='empty' && ( module.update || module.remove) ){
					Timestamp[mkey] = module.time;
					var jsonStr = JSON.stringify(module);
					var result = eval(mkey+"('"+jsonStr+"');");
				}
				
				printStr = printStr+","+mkey+"="+jsonStr;
				
			});
			
			$("#test").text("["+timeStr+"] "+printStr);
			
			ajax_pull_status = 1;
	});
	
		
		
}

function ajax_screen_for_pull(){
	if(ajax_pull_status){
		ajax_screen_pull();
		ajax_pull_watch = 0;
	}else{
		ajax_pull_watch++;
	}
	if(ajax_pull_watch>6000){
		ajax_pull_watch = 0;
		ajax_pull_status = 1;
	}
}
</script>
</body>
</html>