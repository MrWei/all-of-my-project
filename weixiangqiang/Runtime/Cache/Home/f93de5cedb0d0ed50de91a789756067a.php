<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Cache-control" content="no-cache" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
<meta name="format-detection" content="telephone=no" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<title><?php echo ($field["title"]); ?></title>
<link rel="stylesheet" href="/Public/static/phone/style.css" type="text/css" media="all">
<link rel="stylesheet" href="/Public/static/phone/xiaomistyle.css" type="text/css" media="all">
<script type="text/javascript" src="/Public/static/phone/jquery-1.8.3.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/Public/static/phone/xiaomibbs.js" charset="utf-8"></script>
<script language="javascript">
$(function(){
    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
        // 隐藏微信中网页右上角按钮
        WeixinJSBridge.call('hideOptionMenu');
        // 隐藏微信中网页底部导航栏
        WeixinJSBridge.call('hideToolbar');
    });
});
</script>
<style type="text/css">
.blank40{ height: 60px; overflow: hidden;clear: both;}
.list {}
.list th, .list td {padding: 10px 6px 6px;border-bottom: 1px #dbdbdb solid;}
.list th {width: 48px;height: 62px;overflow: hidden;margin-top: 12px;border-radius: 2px;font-size: 12px;line-height: 14px;text-align: center;vertical-align: top;}
.list th b {font-weight: normal;}
.list th.bigname b {width: 48px;height: 48px;display: table-cell;text-align: center;vertical-align: middle;font-size: 14px;border-radius: 2px;background: #f2f2f2;border: 1px #dbdbdb solid;}
.list th img {width: 48px;height: 48px;}
.list td {padding-left: 0;padding-right: 0;vertical-align: top;font-size: 16px;line-height: 22px;}
.list td .img {display: block;width: 100%;height: auto;}
.list td .brow {width: 22px;height: 22px;}
   /*表情*/.list td .main { /*min-height:44px;*/margin: 0;padding: 0;margin-top: 8px;word-break: break-all;}
.list td .main .msgtype {display: inline;width: auto;height: auto;vertical-align: middle;}
.list td p {text-align: left;margin: 0;padding: 0;margin-top: 8px;font-size: 13px;line-height: 20px;height: 20px;color: #666666;}
.list td p a {color: #666666;padding: 0;margin: 0;line-height: 20px;height: 20px;overflow: hidden;}
.list td p #btn_praise { /*background:url(/Public/static/phone/images/inter_praise.png) left center no-repeat; padding-left:17px;*/}
.list td p #btn_comment { /*background:url(/Public/static/phone/images/inter_reply.png) left center no-repeat; padding-left:22px;*/}
.list td .inter {margin-top: 10px;font-size: 13px;overflow: hidden;background: #f2f2f2;color: #666666;}
.list td .inter #praise {padding: 3px 5px 0;}
.list td .inter #praise img {vertical-align: middle;margin-top: -3px;margin-right: -3px;}
.list td .inter #praise span {margin-left: 6px;padding: 0; line-height: 18px;}
.list td .inter #reply {padding: 0 5px 5px;overflow: hidden;}
.list td .inter #reply li {margin: 0;padding: 0;width: auto;border: none;margin-top: 5px;font-size: 14px;line-height: 18px;position: static;min-height: 18px;}
.list .mt0 {margin-top: 0;}
.page strong {font-weight: normal;}
#getold th, #getold td, #getnew th, #getnew td {background: #eeeeee;height: auto;line-height: 22px;padding: 15px 0;}
#replyBar {position: fixed;width: 100%;z-index: 999;background: #dddddd;left: 0;bottom: 0;border-top: 1px #eeeeee solid;}
#replyBar div {margin: 8px 5px 2px;}
#replyBar td {text-align: center;}
#replyBar th {padding: 0 10px 0 5px;background: #dddddd;}
#replyBar .type {}
#replyBar .type b {display: block;text-align: center;font-weight: normal;border: 1px #888888 solid;line-height: 38px;border-radius: 2px;color: #ffffff;background: #555555;cursor: default;}
#replyBar .content {}
#replyBar .content textarea {width: 100%;margin: 0;height: auto;min-height: 34px;overflow-y: visible;line-height: 18px;border-color: #bbbbbb;border-radius: 2px;padding: 2px;}
#replyBar .send {}
#replyBar .send a {display: block;height: 40px;line-height: 40px;color: #ffffff;background: #060;border-color: #050;border-radius: 2px;cursor: default;}
#replyBar .send .load {background: url(/Public/static/phone/images/loading.gif) 20px 8px no-repeat;}
#showImg {z-index: 8888;position: absolute;top: 0;left: 0;background: #000;filter:alpha(opacity:70);border-radius: 2px;}
#showImg .close {position: absolute;top: 2%;right: 2%;}
#showImg .img {width: 100%;height: auto;}
</style>
</head>

<body class="bg">
<div class="wrap">
  <div class="threadlist" id="threadlist" style="overflow:auto;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
      <tr id="getold">
        <td align="center" valign="middle">点击获取更早的信息</td>
      </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="list" id="list">
        <?php if(is_array($chatList)): $i = 0; $__LIST__ = $chatList;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if($uid == $vo['uid']): ?><tr id="<?php echo ($vo["id"]); ?>">
            <th >&nbsp;</th>
            <td align="right"><div class="main" > <?php echo ($vo["id"]); ?>楼 <?php echo ($vo["keywords"]); ?> </div>
              <p style="text-align:right;"> &nbsp;&nbsp;                [<?php echo (date("H:i",$vo["create_time"])); ?>] </p>
            </td>
            <th ><img src="<?php echo ($vo["avatar"]); ?>"><br />
              <b><?php echo ($vo["nickname"]); ?></b></th>
          </tr>
          <?php else: ?>
          <tr id="<?php echo ($vo["id"]); ?>">
            <th ><img src="<?php echo ($vo["avatar"]); ?>"><br />
              <b><?php echo ($vo["nickname"]); ?></b></th>
            <td ><div class="main" > <?php echo ($vo["id"]); ?>楼 <?php echo ($vo["keywords"]); ?> </div>
              <p > [<?php echo (date("H:i",$vo["create_time"])); ?>]                &nbsp;&nbsp;</p>
              </td>
            <th >&nbsp;</th>
          </tr><?php endif; endforeach; endif; else: echo "" ;endif; ?>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
      <tr id="getnew" onclick="ajaxData();">
        <td align="center" valign="middle">点击获取最新信息</td>
      </tr>
    </table>
  </div>
</div>
<div class="blank40"></div>
<div id="replyBar">
  <div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="type" width="50" style="vertical-align:top;"><b id="type" onclick="type();">刷新</b></td>
        <th class="content" style="padding-bottom:0;"> <textarea id="textarea" class='editable' onkeydown ="if(event.keyCode==13) return false; " oninput="this.style.height='0px';this.style.height=(this.scrollHeight+'px');" onpropertychange="this.style.height=(this.scrollHeight+'px')" /></textarea>
        </th>
        <td class="send" width="64" style="vertical-align:top;"><a id="send">提交</a></td>
      </tr>
    </table>
  </div>
</div>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" id="showImg" class="none">
  <tr>
    <td align="center" valign="middle"></td>
  </tr>
</table>
<script language="javascript">
var page = 0 ;

function loadMore(){
  $('#getnew td').html('点击获取最新信息');
}

function ajaxData(){
  if( "<?php echo ($_totalPages); ?>" == page ){
       $('#getnew td').html('<font color="green">暂无信息 ^O^</font>');
        setTimeout('loadMore()', 2000);
  }else{
      page++;
      $.getJSON( "http://qiang.weixin.com/index.php?m=Home&c=Mobile&a=ajaxData&eid=<?php echo ($eid); ?>&uid=<?php echo ($uid); ?>&page="+page,{},
        function( data ){
          if( data.status ){
             $.each(data.info, function(k,v){
             var html = "";
              if( v.uid == "<?php echo ($uid); ?>" ){
                html += '<tr id="'+v.id+'"><th >&nbsp;</th><td align="right"><div class="main" > '+v.id+'楼 '+v.keywords+' </div><p style="text-align:right;"> &nbsp;&nbsp;';
                html += '['+v.create_time+'] </p></td><th ><img src="'+v.avatar+'"><br /><b>'+v.nickname+'</b></th></tr>';
              }else{
                html += '<tr id="'+v.id+'">';
                html += '<th ><img src="'+v.avatar+'"><br /><b>'+ v.nickname +'</b></th>';
                html += '<td><div class="main" > '+v.id+'楼 '+v.keywords+' </div>'
                html += '<p> &nbsp;&nbsp;                ['+v.create_time+'] </p></td>'
                html += '<th></th></tr>';
              }
              $("#list").append(html);
            }) 
          }
        }
       );
    }
}


function type(){
    if($("#replyBar #type").text()=='取消'){
        var tav = document.getElementById("textarea").value;
        if(tav.length>0){
            if(!confirm('确定放弃本次评论？')) return false;
        }
        replyID = 0;
        replyName = '';
        $("#replyBar #type").css("background","#555555");
        $("#replyBar #type").css("border-color","#888888");
        $("#replyBar #type").text('刷新');
        $("#replyBar #type").css("color","#ffffff");
        document.getElementById("textarea").value = '';
    }else{
        javascript:location.reload();
    }
}

function reply(id,name){
    $("#replyBar #type").css("background","#C60");
    $("#replyBar #type").css("border-color","#a65300");
    $("#replyBar #type").text('取消');
    $("#replyBar #type").css("color","#ffffff");
    document.getElementById("textarea").focus();
    replyID = id;
    replyName = name;
}

// 显示图片
function showImg(src){
    $("#showImg td").html('<img src="'+src+'" class="img" onclick="closeImg();" /><img src="/Public/static/phone/images/close.png" class="close" onclick="closeImg();" />');
    $("#showImg").removeClass("none");
}
// 关闭图片
function closeImg(){
    $("#showImg").addClass("none");
}

</script>