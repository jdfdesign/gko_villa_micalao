//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap/transition.js
//= require twitter/bootstrap/alert.js
//= require twitter/bootstrap/button.js
//= require twitter/bootstrap/collapse.js
//= require twitter/bootstrap/dropdown.js
//= require jquery.throttledresize.js
//= require jquery.mousewheel.3.0.6.js
//= require jquery.jscrollpane.js
//= require flexslider/jquery.flexslider.js


$(document).ready(function() {

    /////////////////////////////////////////////////
    var slider = $(".content-wrapper"),
		use_slider = true, // system set to false if page has no text
    gallery = $('#background-slideshow'),
    body = $("body"),
    scrollpane = $('.content-inner'),
    header_height = $('header.navbar').outerHeight(),
    footer_height = $('footer.footer').outerHeight(),
    slider_tab = $("#content-tab"),
    slider_tab_size = $("#content-tab").outerHeight(),
    slider_max_size = 400,
    slide_open = true,
    thumbs_tab,
    thumbs_open = true,
    scrollpane_api,
		available_size = {w:0, h:0},
		//TODO : should be set by rails
    preferred_size = {
        w: 896,
        h: 570
    };

    /////////////////////////////////////////////////
    init_slide = function() {
        slider_tab.bind('click',
        function(e) {
            if (!slide_open) {
                show_slide(slider);
            } else {
                hide_slide(slider);
            }
            e.preventDefault();
        });
    }
    /////////////////////////////////////////////////
    show_slide = function(el) {
        if (slide_open) {
            return;
        }
        slide_open = !slide_open;

        // Hide the thumbsbar
        if (thumbs_tab && thumbs_open) {
            thumbs_tab.click();
        }

		el.stop().animate({'right': 0}, {
			queue: false,
			duration: 500
		});
		
        slider_tab.addClass("open");
    }
    /////////////////////////////////////////////////
    hide_slide = function(el) {
        if (!slide_open) {
            return;
        }
        slide_open = !slide_open;

		el.stop().animate({'right': 300}, {
			queue: false,
			duration: 500
		});
        slider_tab.removeClass("open");
    }

    /////////////////////////////////////////////////
    rescale = function(e) {
        getAvailableSize();
		
		if (typeof scrollpane_api !== "undefined" && scrollpane_api !== null) {
			scrollpane_api.reinitialise();
		}
        
    }
    /////////////////////////////////////////////////
    getScreenSize = function() {
        /*var orientation = jQuery.event.special.orientationchange.orientation(),
        port = orientation === "portrait",
        winHeightMin = port ? 480 : 320,
        winWidthMin = port ? 320 : 480,
        screenHeight = port ? screen.availHeight : screen.availWidth,
        screenWidth = port ? screen.availWidth : screen.availHeight,
        winHeight = Math.max(winHeightMin, $(window).height()),
        winWidth = Math.max(winWidthMin, $(window).width()),
        pageSize = {
            w: winWidth,//Math.min(screenWidth, winWidth),
            h: winHeight//Math.min(screenHeight, winHeight)
        };
				//log("port" + port + "getScreenSize screenWidth " + screenWidth + " winWidth " + winWidth);
        return pageSize;*/

return 		{
            w: $(window).width(),//Math.min(screenWidth, winWidth),
            h: $(window).height()//Math.min(screenHeight, winHeight)
        }
    }
    /////////////////////////////////////////////////
    getAvailableSize = function() {
        var size = getScreenSize();
        available_size.w = Math.min(size.w, preferred_size.w);
        available_size.h = Math.min(size.h, preferred_size.h);
    }
    /////////////////////////////////////////////////
	getAvailableSize();
	if (typeof slider !== "undefined" && slider !== null) {
		init_slide();
        scrollpane.jScrollPane({
	        showArrows: false,
			autoReinitialise: true
	    })
	scrollpane_api = scrollpane.data('jsp');
	}

	Slideshow.init();

    // Handle window.resize or orientationchange event
    $(window).bind("throttledresize",
    function(e) {
        rescale(e);
    });

});

var Slideshow = {
	
	init : function() {
	 // The slider being synced must be initialized first
	  $('.carousel-flexslider').flexslider({
	    animation: "slide",
	    controlNav: false,
	    animationLoop: false,
	    slideshow: false,
	    itemWidth: 160,
	    itemMargin: 1,
	    asNavFor: '#slider'
	  });

	  $('.slider-flexslider').flexslider({
	    animation: "slide",
	    controlNav: false,
	    animationLoop: false,
	    slideshow: false,
	    sync: "#carousel"
	  });
	}
}