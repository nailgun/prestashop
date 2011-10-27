/* ---------------------------------------------
expandAll v.1.3.8
http://www.adipalaz.com/experiments/jquery/expand.html
Requires: jQuery v1.3+
Copyright (c) 2009 Adriana Palazova
Dual licensed under the MIT (http://www.adipalaz.com/docs/mit-license.txt) and GPL (http://www.adipalaz.com/docs/gpl-license.txt) licenses
------------------------------------------------ */
(function($) {
    $.fn.expandAll = function(options) {
        var o = $.extend({}, $.fn.expandAll.defaults, options);
        return this.each(function(index) {
            var $$ = $(this), $referent, $sw, $cllps, $tr, container, toggleTxt, toggleClass;
            (o.switchPosition == 'before') ? ($.fn.findSibling = $.fn.prev, $.fn.insrt = $.fn.before) : ($.fn.findSibling = $.fn.next, $.fn.insrt = $.fn.after);
            if (this.id.length) {
                container = '#' + this.id;
            } else if (this.className.length) {
                container = this.tagName.toLowerCase() + '.' + this.className.split(' ').join('.');
            } else {
                container = this.tagName.toLowerCase();
            }
            if (o.ref && $$.find(o.ref).length) {
                (o.switchPosition == 'before') ? $referent = $$.find("'" + o.ref + ":first'") : $referent = $$.find("'" + o.ref + ":last'");
            } else {
                return;
            }
            if (o.cllpsLength && $$.closest(container).find(o.cllpsEl).text().length < o.cllpsLength) {
                $$.closest(container).find(o.cllpsEl).addClass('dont_touch');
                return;
            }
            (o.initTxt == 'show') ? (toggleTxt = o.expTxt, toggleClass='') : (toggleTxt = o.cllpsTxt, toggleClass='open');
            if (o.state == 'hidden') {
                $$.find(o.cllpsEl + ':not(.shown, .dont_touch)').hide().findSibling().find('> a.open').removeClass('open');
            } else {
                $$.find(o.cllpsEl).show().findSibling().find('> a').addClass('open');
            }
            (o.oneSwitch) ? ($referent.insrt('<p class="switch"><a href="#" class="' + toggleClass + '">' + toggleTxt + '</a></p>')) :
            ($referent.insrt('<p class="switch"><a href="#" class="">' + o.expTxt + '</a>&nbsp;|&nbsp;<a href="#" class="open">' + o.cllpsTxt + '</a></p>'));
            $sw = $referent.findSibling('p').find('a');
            $cllps = $$.closest(container).find(o.cllpsEl).not('.dont_touch');
            $tr = (o.trigger) ? $$.closest(container).find(o.trigger + ' > a') : $$.closest(container).find('.expand > a');
            if (o.child) {
                $$.find(o.cllpsEl + '.shown').show().findSibling().find('> a').addClass('open').text(o.cllpsTxt);
                window.$vrbls = {
                    kt1 : o.expTxt, 
                    kt2 : o.cllpsTxt
                };
            }
            var scrollElem;
            (typeof scrollableElement == 'function') ? (scrollElem = scrollableElement('html', 'body')) : (scrollElem = 'html, body');
            $sw.click(function() {
                var $switch = $(this),
                $c = $switch.closest(container).find(o.cllpsEl +':first'),
                cOffset = $c.offset().top;
                if (o.parent) {
                    var $swChildren = $switch.parent().nextAll().children('p.switch').find('a');
                    kidTxt1 = $vrbls.kt1, kidTxt2 = $vrbls.kt2,
                    kidTxt = ($switch.text() == o.expTxt) ? kidTxt2 : kidTxt1;
                    $swChildren.text(kidTxt);
                    if ($switch.text() == o.expTxt) {
                        $swChildren.addClass('open');
                    } else {
                        $swChildren.removeClass('open');
                    }
                }
                if ($switch.text() == o.expTxt) {
                    if (o.oneSwitch) {
                        $switch.text(o.cllpsTxt).attr('class', 'open');
                    }
                    $tr.addClass('open');
                    $cllps[o.showMethod](o.speed);
                } else {
                    if (o.oneSwitch) {
                        $switch.text(o.expTxt).attr('class', '');
                    }
                    $tr.removeClass('open');
                    if (o.speed == 0 || o.instantHide) {
                        $cllps.hide();
                    } else {
                        $cllps[o.hideMethod](o.speed);
                    }
                    if (o.scroll && cOffset < $(window).scrollTop()) {
                        $(scrollElem).animate({
                            scrollTop: cOffset
                        },600);
                    }
                }
                return false;
            });
        });
    };
    $.fn.expandAll.defaults = {
        state : 'hidden',
        initTxt : 'show',
        expTxt : '[Expand All]',
        cllpsTxt : '[Collapse All]',
        oneSwitch : true,
        ref : '.expand',
        switchPosition: 'before',
        scroll : false,
        showMethod : 'slideDown',
        hideMethod : 'slideUp',
        speed : 600,
        cllpsEl : '.collapse',
        trigger : '.expand',
        localLinks : null,
        parent : false,
        child : false,
        cllpsLength : null,
        instantHide : false
    };
    /* ---------------------------------------------
Toggler - http://www.adipalaz.com/experiments/jquery/expand.html
------------------------------------------------ */
    $.fn.toggler = function(options) {
        var o = $.extend({}, $.fn.toggler.defaults, options);
        var $this = $(this);
        $this.wrapInner('<a style="display:block" href="#" title="Expand/Collapse" />');
        if (o.initShow) {
            $(o.initShow).addClass('shown');
        }
        $this.next(o.cllpsEl + ':not(.shown)').hide();
        return this.each(function() {
            var container;
            (o.container) ? container = o.container : container = 'html';
            if ($this.next('div.shown').length) {
                $this.closest(container).find('.shown').show().prev().find('a').addClass('open');
            }
            $(this).click(function() {
                $(this).find('a').toggleClass('open').end().next(o.cllpsEl)[o.method](o.speed);
                return false;
            });
        });
    };
    $.fn.toggler.defaults = {
        cllpsEl : 'div.collapse',
        method : 'slideToggle',
        speed : 'slow',
        container : '',
        initShow : '.shown'
    };
})(jQuery);



