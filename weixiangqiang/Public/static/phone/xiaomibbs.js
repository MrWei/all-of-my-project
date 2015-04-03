/**
 * Created with IntelliJ IDEA.
 * User: tanyaoting
 * Date: 13-10-9
 * Time: 下午8:53
 * To change this template use File | Settings | File Templates.
 */

/*for app*/
function isApp() {
    try {
        if (!!WEBBS) {
            return true;
        }
    } catch (e) {}
    return false;
}

function WebEventTrigger(name, data) {
    try {
        if (WEBBS && WEBBS.trigger) {
            if (typeof(data) != 'string') {
                data = JSON.stringify(data);
            }
            return WEBBS.trigger(name, data);
        }
    } catch (e) {}
    return false;
}

var toggleMenu = function () {
    var obj = $(".wrap");
    var menu = $(".menu");
    if (obj.hasClass("showMenu")) {
        obj.removeClass("showMenu");
        menu.removeClass("showMenu");
        obj.unbind("touchstart");
    } else {
        obj.addClass("showMenu");
        menu.addClass("showMenu");
        obj.bind("touchstart", function() {
            toggleMenu();
        })
    }
}

var page = {
    converthtml : function() {
        var prevpage = $('div.pg .prev').prop('href');
        var nextpage = $('div.pg .nxt').prop('href');
        var lastpage = $('div.pg label span').text().replace(/[^\d]/g, '') || 0;
        var curpage = $('div.pg input').val() || parseInt($('div.pg strong').html());

//        if(!lastpage) {
//            prevpage = $('div.pg .pgb a').prop('href');
//        }

        var prevpagehref = nextpagehref = '';
        if(prevpage == undefined) {
            prevpagehref = 'javascript:;" class="disabled prev';
        } else {
            prevpagehref = prevpage + '" class="prev';
        }
        if(nextpage == undefined) {
            nextpagehref = 'javascript:;" class="disabled next';
        } else {
            nextpagehref = nextpage + '" class="next';
        }

        var selector = '';
//        if(lastpage) {
//            selector += '<a id="select_a" class="selector">';
//            selector += '<select id="dumppage">';
//            for(var i=1; i<=lastpage; i++) {
//                selector += '<option value="'+i+'" '+ (i == curpage ? 'selected' : '') +'>第'+i+'页</option>';
//            }
//            selector += '</select>';
//            selector += '<span>'+curpage+'/' + lastpage + '</span>';
//        } else {
//            var maxpage = 20; //max 622
//
//            selector += '<a id="select_a" class="selector">';
//            selector += '<select id="dumppage">';
//            for(var i=1; i<=maxpage; i++) {
//                selector += '<option value="'+i+'" '+ (i == curpage ? 'selected' : '') +'>第'+i+'页</option>';
//            }
//            selector += '</select>';
//            selector += '<span>'+curpage+'/' + maxpage + '</span>';
//        }

        if (curpage) {
            selector += '<a id="select_a" style="margin:0 2px;padding:1px 0 0 0;border:0;display:inline-block;position:relative;width:100px;height:31px;line-height:27px;background:url('+STATICURL+'/image/mobile/images/pic_select.png) no-repeat;text-align:left;text-indent:20px;">';
            selector += '<select id="dumppage" style="position:absolute;left:0;top:0;height:27px;opacity:0;width:100px;">';
            if (lastpage) {
                for (var i = 1; i <= lastpage; i++) {
                    selector += '<option value="' + i + '" ' + (i == curpage ? 'selected' : '') + '>第' + i + '页</option>';
                }
            } else {
                var maxpage = 20; //max 622

                for (var i = 1; i <= maxpage; i++) {
                    selector += '<option value="' + i + '" ' + (i == curpage ? 'selected' : '') + '>第' + i + '页</option>';
                }
            }
            selector += '</select>';
            selector += '<span>第'+curpage+'页</span>';
        }

//        $('div.pg').removeClass('pg').addClass('page').html('<a href="'+ prevpagehref +'"><i></i></a>'+ selector +'<a href="'+ nextpagehref +'"><i></i></a>');
        $('div.pg').removeClass('pg').addClass('page').html('<a href="'+ prevpagehref +'">上一页</a>'+ selector +'<a href="'+ nextpagehref +'">下一页</a>');

        $('#dumppage').on('change', function() {
            var href = (prevpage || nextpage);
            if (href.search(/index-\d+/) > 0) {
                window.location.href = href.replace(/index-\d+/, 'index-' + $(this).val());
            } else {
                window.location.href = href.replace(/page=\d+/, 'page=' + $(this).val());
            }
        });
    }
};

var POPMENU = new Object;
var popup = {
    init : function() {
        var $this = this;
        $('.popup').each(function(index, obj) {
            obj = $(obj);
            var pop = $(obj.attr('href'));
            if(pop && pop.attr('popup')) {
                pop.css({'display':'none'});
                obj.on('click', function(e) {
                    $this.open(pop);
                });
            }
        });
        $('#post_new a.popup').live('click', function(event){
             obj = $(this);
            var pop = $(obj.attr('href'));
            if(pop && pop.attr('popup')) {
                pop.css({'display':'none'});               
                $this.open(pop);               
            }
            return false;
        });
        this.maskinit();
    },
    maskinit : function() {
        var $this = this;
        $('#mask').off().on('tap', function() {
            $this.close();
        });
    },

    open : function(pop, type, url) {
        this.close();
        this.maskinit();
        if(typeof pop == 'string') {
            $('#ntcmsg').remove();
            if(type == 'alert') {
                pop = '<div class="tip pop"><dt>'+ pop +'</dt><dd><input class="tip_button primary" type="button" value="确定" onclick="popup.close();"></dd></div>'
            } else if(type == 'confirm') {
                pop = '<div class="tip pop"><dt>'+ pop +'</dt><dd><input class="redirect tip_button primary" type="button" value="确定" href="'+ url +'"><a href="javascript:;" onclick="popup.close();" class="tip_button">取消</a></dd></div>'
            }
            $('body').append('<div id="ntcmsg" style="display:none;">'+ pop +'</div>');
            pop = $('#ntcmsg');
        }
        if(POPMENU[pop.attr('id')]) {
            $('#' + pop.attr('id') + '_popmenu').html(pop.html()).css({'height':pop.height()+'px', 'width':pop.width()+'px'});
        } else {
            pop.parent().append('<div class="dialogbox" id="'+ pop.attr('id') +'_popmenu" style="height:'+ pop.height() +'px;width:'+ pop.width() +'px;">'+ pop.html() +'</div>');
        }
        var popupobj = $('#' + pop.attr('id') + '_popmenu');
        console.log(popupobj.height())
        var left = (window.innerWidth - popupobj.width()) / 2;
        var top = (document.documentElement.clientHeight - popupobj.height()) / 2;
        popupobj.css({'display':'block','position':'fixed','left':left,'top':top,'z-index':120,'opacity':1});
        $('#mask').css({'display':'block','width':'100%','height':'100%','position':'fixed','top':'0','left':'0','background':'black','opacity':'0.2','z-index':'100'});
        POPMENU[pop.attr('id')] = pop;
    },
    close : function() {
        $('#mask').css('display', 'none');
        $.each(POPMENU, function(index, obj) {
            $('#' + index + '_popmenu').css('display','none');
        });
    }
};

$(document).ready(function() {
    if (isApp()) {
        var getArg = function (query) {
            var argsArr = new Object();
//            query = query.substring(1);

            var pairs = query.split("&"); //name=myname&password=1234&sex=male&address=nanjing

            for (var i = 0; i < pairs.length; i++) {
                var sign = pairs[i].indexOf("=");

                if (sign == -1) {
                    continue;
                }

                var aKey = pairs[i].substring(0, sign);
                var aValue = pairs[i].substring(sign + 1);

                argsArr[aKey] = aValue;
            }

            return argsArr;
        }

        if (location.href.split("?").length > 1) {
            var _arg = getArg(location.href.split("?")[1]);

            if (_arg.from == "app") {
                $("header.header").hide();
                $(".topbar").hide();
                $("#fastpostform").hide();
                $(".page").hide();
            }

        }

//        $("#login")
//            .on("click", function(e) {
//                toggleMenu();
//                WebEventTrigger("login", null);
//                e.preventDefault();
//            })
        $("#logout").hide();
        $("#paiApp")
            .show()
            .on("click", function(e) {
                WebEventTrigger("go_pai", null);
                e.preventDefault();
            })
        $("#settingApp")
            .show()
            .on("click", function(e) {
                WebEventTrigger("go_setting", null);
                e.preventDefault();
            })
    }

    $("#menu-btn")
        .on("click", function(e) {
			//alert(menuStatus);
            toggleMenu();
            e.preventDefault();
        });
})
