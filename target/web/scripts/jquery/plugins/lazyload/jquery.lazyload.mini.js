(function(a){a.fn.lazyload=function(b){var c={threshold:0,failurelimit:0,event:"scroll",effect:"show",container:window,callback:function(){}};if(b){a.extend(c,b)}var d=this;if("scroll"==c.event){a(c.container).bind("scroll",function(g){var e=0;d.each(function(){if(a.abovethetop(this,c)||a.leftofbegin(this,c)){}else{if(!a.belowthefold(this,c)&&!a.rightoffold(this,c)){a(this).trigger("appear")}else{if(e++>c.failurelimit){return false}}}});var f=a.grep(d,function(h){return !h.loaded});d=a(f)})}this.each(function(){var e=this;if(undefined==a(e).attr("original")){a(e).attr("original",a(e).attr("src"))}if("scroll"!=c.event||undefined==a(e).attr("src")||c.placeholder==a(e).attr("src")||(a.abovethetop(e,c)||a.leftofbegin(e,c)||a.belowthefold(e,c)||a.rightoffold(e,c))){if(c.placeholder){a(e).attr("src",c.placeholder)}else{a(e).removeAttr("src")}e.loaded=false}else{e.loaded=true}a(e).one("appear",function(){a("<img />").bind("load",function(){a(e).hide().attr("src",a(e).attr("original"))[c.effect](c.effectspeed);e.loaded=true;c.callback(e)}).attr("src",a(e).attr("original"))});if("scroll"!=c.event){a(e).bind(c.event,function(f){if(!e.loaded){a(e).trigger("appear")}})}});a(c.container).trigger(c.event);return this};a.belowthefold=function(c,d){if(d.container===undefined||d.container===window){var b=a(window).height()+a(window).scrollTop()}else{var b=a(d.container).offset().top+a(d.container).height()}return b<=a(c).offset().top-d.threshold};a.rightoffold=function(c,d){if(d.container===undefined||d.container===window){var b=a(window).width()+a(window).scrollLeft()}else{var b=a(d.container).offset().left+a(d.container).width()}return b<=a(c).offset().left-d.threshold};a.abovethetop=function(c,d){if(d.container===undefined||d.container===window){var b=a(window).scrollTop()}else{var b=a(d.container).offset().top}return b>=a(c).offset().top+d.threshold+a(c).height()};a.leftofbegin=function(c,d){if(d.container===undefined||d.container===window){var b=a(window).scrollLeft()}else{var b=a(d.container).offset().left}return b>=a(c).offset().left+d.threshold+a(c).width()};a.extend(a.expr[":"],{"below-the-fold":"$.belowthefold(a, {threshold : 0, container: window})","above-the-fold":"!$.belowthefold(a, {threshold : 0, container: window})","right-of-fold":"$.rightoffold(a, {threshold : 0, container: window})","left-of-fold":"!$.rightoffold(a, {threshold : 0, container: window})"})})(jQuery);