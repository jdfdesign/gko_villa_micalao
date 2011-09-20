$(document).ready(function() {

    /////////////////////////////////////////////////
    var slider = $("#wrapper-wide-main"),
		use_slider = true, // system set to false if page has no text
    gallery = $('#background-slideshow'),
    body = $("body"),
    scrollpane = $('#main'),
    header_height = $('#wrapper-wide-header').outerHeight(),
    footer_height = $('#wrapper-wide-footer').outerHeight(),
    slider_tab = $("#content-tab"),
    slider_tab_size = $("#content-tab").outerHeight(),
    slider_max_size = 400,
    slide_open = true,
    slide_originals = {},
    content_options = {
        location: "right",
        duration: 300,
        tab_indicator: "#content-tab",
        css: {}
    },
    scroll_options = {
        showArrows: true,
				autoReinitialise: true
    },
    thumbs_tab,
    thumbs_open = true,
    scrollpane_api,
		available_size = {w:0, h:0},
		//TODO : should be set by rails
    preferred_size = {
        w: 896,
        h: 570
    };

    ////////////////
    init_slideshow = function() {
        return gallery.galleria({
            transition: 'fade',
            thumb_crop: 'height',
            autoplay: true,
            image_crop: "width",
            image_pan: true,
            thumb_crop: true,
            show_info: true,
            show_counter: true,
            carousel_location: 'bottom',
            carousel: true,
            // set this to false if you want to keep the thumbnails visible:
            _hide_dock: true,
            // set this to true if you want to shrink the carousel when clicking a thumbnail:
            _close_on_click: true,
            _show_controls: false,
            width: available_size.w,
            height: available_size.h,
            extend: function(options) {
                $.extend(Galleria, {
                    // Event placeholders
                    HIDE_THUMBS: 'g_hide_thumbs',
                    SHOW_THUMBS: 'g_show_thumbs'
                });

                var self = this;
                this.addElement("thumbnails-tab", "controls-container", "controls-play");
                this.append({
                    "thumbnails-container": "thumbnails-tab",
                    container: ["controls-container"],
                    "controls-container": ["controls-play"]
                });

                // cache some stuff
                var toggle = this.$('image-nav-left,image-nav-right'),
                tab = this.$('thumbnails-tab'),
                thumbs = this.$('thumbnails-container'),
								thumbnails_container = this.$('thumbnails-container'),
                thumbnails_list = this.$('thumbnails-list'),
                container = this.$('container'),
                controls = this.$('controls-container'),
                playbtn = this.$('controls-play'),
                counter = this.$('counter'),
                THUMBS_OPEN = true,
                THUMBS_POS = 0;

                thumbs.addClass(options.carousel_location);
                tab.addClass(options.carousel_location);

                if (this.getDataLength() == 1) {
                    //alert("unique");
                    this.$('image-nav-left,image-nav-right,loader').css('visibility', 'hidden');
                    counter.css('visibility', 'hidden');
                    controls.css('visibility', 'hidden');
                    thumbnails_container.css('visibility', 'hidden');
                }
                else {
                    // show loader with opacity
                    this.$('loader').show().css('opacity', .4);
                    // some stuff for non-touch browsers
                    if (!$.support.touch) {
                        // fade thumbnails
                        this.$('thumbnails').children().hover(function() {
                            $(this).not('.active').children().stop().fadeTo(100, 1);
                        },
                        function() {
                            $(this).not('.active').children().stop().fadeTo(400, .6);
                        });
                        this.addIdleState(this.get('image-nav-left'), {
                            left: -50
                        });
                        this.addIdleState(this.get('image-nav-right'), {
                            right: -50
                        });
                    }
                    this.$('image-nav-left, image-nav-right').css('opacity', 0.01).hover(function() {
                        $(this).animate({
                            opacity: 0.7
                        },
                        100);
                    },
                    function() {
                        $(this).animate({
                            opacity: 0
                        });
                    }).show();
                    if (options.show_counter) {
                        this.addIdleState(counter, {
                            opacity: 0
                        });
                    } else {
                        counter.css('visibility', 'hidden');
                    }

                    // Play/Pause buttons ?
                    if (options._show_controls) {
                        if (options.autoplay) {
                            playbtn.addClass("player-ui-icon player-ui-icon-pause");
                        } else {
                            playbtn.addClass("player-ui-icon player-ui-icon-play");
                        }
                        playbtn.click(this.proxy(function() {
                            if (this._playing) {
                                this.pause();
                            } else {
                                this.play();
                            }
                        }));
                        // Binds play/pause events
                        this.bind(Galleria.PAUSE,
                        function(e) {
                            //playbtn
                            //.removeClass("player-ui-icon player-ui-icon-pause")
                            //.addClass("player-ui-icon player-ui-icon-play");
                        });
                        this.bind(Galleria.PLAY,
                        function(e) {
                            //playbtn
                            //.removeClass("player-ui-icon player-ui-icon-play")
                            //.addClass("player-ui-icon player-ui-icon-pause");
                        });

                    } else {
                        controls.css('visibility', 'hidden');
                    }

                    if (options._hide_dock) {
                        tab.click(this.proxy(function() {
                            tab.toggleClass('open', !THUMBS_OPEN);
                            if (!THUMBS_OPEN) {
                                this.trigger({
                                    type: Galleria.HIDE_THUMBS
                                });
                                thumbs.animate({
                                    bottom: - thumbnails_list.outerHeight() + 2
                                },
                                400, 'galleria');
                            } else {
                                this.trigger({
                                    type: Galleria.SHOW_THUMBS
                                });
                                thumbs.animate({
                                    bottom: THUMBS_POS
                                },
                                400, 'galleria');
                            }
                            THUMBS_OPEN = !THUMBS_OPEN;
                        }));
                        tab.css('visibility', 'visible');
                    } else {
                        //this.bind(Galleria.THUMBNAIL,
                        //function() {
                        //    thumbs.css('bottom', THUMBS_POS - thumbnails_list.outerHeight() + 2);
                        //});
                        tab.css('visibility', 'visible');
                    }

                    // Binds thumbs events
                    this.bind(Galleria.THUMBNAIL,
                    function(e) {
                        $(e.thumbTarget)
                        .parent(':not(.active)').children().css('opacity', .6)
                        .click(function() {
                            if (THUMBS_OPEN && options._close_on_click) {
                                tab.click();
                            }
                        });
                    });

                    // Binds load events
                    this.bind(Galleria.LOADSTART,
                    function(e) {
                        if (!e.cached) {
                            this.$('loader').show().fadeTo(200, .4);
                        }
                        $(e.thumbTarget).css('opacity', 1).parent().siblings().children().css('opacity', .6);
                    });
                    this.bind(Galleria.LOADFINISH,
                    function(e) {
                        this.$('loader').fadeOut(200);
                    });

                }
            }
        }).bind(Galleria.READY,
        function(e) {
            thumbs_tab = $('.galleria-thumbnails-tab');
            //thumbs_tab.click();
					if(use_slider) {
            gallery.bind(Galleria.SHOW_THUMBS,
            function(e) {
                hide_slide(slider);
                thumbs_open = true;
            });
            gallery.bind(Galleria.HIDE_THUMBS,
            function(e) {
                thumbs_open = false;
            });
					}
        })
    }

    /////////////////////////////////////////////////
    refresh_slideshow = function(images_html) {
				Galleria.get(0).pause().load(images_html);
    }
    /////////////////////////////////////////////////
    init_scrollpane = function() {
        scrollpane.jScrollPane(scroll_options);
        scrollpane_api = scrollpane.data('jsp');
    }
    /////////////////////////////////////////////////
    refresh_scrollpane = function(content_html) {
        scrollpane_api.getContentPane().find("#content").html(content_html);
        scrollpane_api.reinitialise();
    }


    /////////////////////////////////////////////////
    init_slide = function() {
        if (slider_tab != 1) {
            slider.prepend("<div id='content-tab'></div");
            slider_tab = slider.find("#content-tab");
        }

        slide_originals[content_options.location] = $.gecko.parseValue(slider.css(content_options['location'])) || 0;
        slide_originals['max-width'] = $.gecko.parseValue(slider.css('max-width')) || '100%';
        slide_originals['max-height'] = $.gecko.parseValue(slider.css('max-height')) || '100%';

        /*	
        var slider_tab_css = {};
        var slider_css = {};

				if (content_options.location == "bottom" || content_options.location == "top") {
				slider_css[content_options.location] = $.gecko.parseValue( slider.css(content_options.location) ) || 0;
				slider_css.width = $.gecko.parseValue( slider.css('width') ) || '100%';
				slider_css.height = Math.min(slider_max_size, available_size.h);
			}

			if (content_options.location == "left" || content_options.location == "right") {
				slider_css[content_options.location] = $.gecko.parseValue( slider.css(content_options.location) ) || 0;
				slider_css.width = Math.min(slider_max_size, available_size.w);
				slider_css.height = $.gecko.parseValue( slider.css('height') ) || '100%';
			}
			
		//	slider_tab_css[content_options.location] = $.gecko.parseValue( slider_tab.css(content_options.location) ) || '0px';
		//	slider_tab_css['margin-' + content_options.location] = $.gecko.parseValue( slider_tab.css(content_options.location) ) || -slider_tab_size;
			
			slider.css(slider_css);*/
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

        move_slide(el, slide_originals);
        slider_tab.addClass("open");
    }
    /////////////////////////////////////////////////
    hide_slide = function(el) {
        if (!slide_open) {
            return;
        }
        slide_open = !slide_open;

        var dest = {};
        if (content_options.location == "right" || content_options.location == "left") {
            dest[content_options.location] = -el.outerWidth();
        }
        else {
            dest[content_options.location] = slide_originals[content_options.location] - el.outerHeight();
        }
        move_slide(el, dest);
        slider_tab.removeClass("open");
    }
    /////////////////////////////////////////////////
    move_slide = function(el, options) {
        el.stop().animate(options, {
            queue: false,
            duration: content_options.duration
        });
        return el;
    }

    /////////////////////////////////////////////////
    rescale = function(e) {
        getAvailableSize();

        var wasPlaying = gallery.isPlaying;
        if (wasPlaying) {
            gallery.stop();
        };

        // Hack ! galleria is buggy when rescale
        // Just rescale the gallery if no width or height are set in its parents dom selector
        gallery.find('.galleria-container:first').css({
            width: available_size.w,
            height: available_size.h
        })
       // log("w: " + available_size.w + "   h: " + available_size.h);
        Galleria.get(0).rescale(available_size.w, available_size.h, e);
        if (wasPlaying) {
            gallery.start();
        };

        scrollpane_api.reinitialise();
    }
    /////////////////////////////////////////////////
    getScreenSize = function() {
        var orientation = jQuery.event.special.orientationchange.orientation(),
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
        return pageSize;
    }
    /////////////////////////////////////////////////
    getAvailableSize = function() {
        var size = getScreenSize();
        available_size.w = Math.min(size.w, preferred_size.w);
        available_size.h = Math.min(size.h, preferred_size.h);
    }
    /////////////////////////////////////////////////
    init_ajax = function() {
        $('h2#site-title a, .menu a').attr('data-remote', 'true')
        .attr('data-method', 'get')
				.attr('data-type', 'html')
        .live("ajax:beforeSend.rails",
        function(xhr, settings) {
            $.gecko.attachLoading("#main");
        })
        .live("ajax:success.rails",
        function(data, status, xhr) {
            //log("success: ", status);
						var obj = $(status);
						refresh_slideshow(obj.find("div.images:first"));
						obj.eq(0).empty();
						refresh_scrollpane(obj);
        })
        .live("ajax:error.rails",
        function(xhr, status, error) {
           // log("error html: ", xhr);
        })
        .live("ajax:complete.rails",
        function(xhr, status) {
            $.gecko.removeLoading("#main");
        });
    }

    /////////////////////////////////////////////////
		getAvailableSize();
    //init_ajax();
		$('#content div.images:first').css({'display':'none'});

		if($('#content .description').length > 0) {
			init_slide();
			init_scrollpane();
		} else {
			slider.hide();
			use_slider = false;
		}

    init_slideshow();

    // Handle window.resize or orientationchange event
    $(window).bind("throttledresize",
    function(e) {
        rescale(e);
    });

});