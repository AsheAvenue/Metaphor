/*
 * jQuery paneSlide
 * Version 1.0
 * http://asheavenue.com/
 *
 * HEAVILY influenced by and based on jquery-pageslide
 * with gratitude to Scott Robbin
 * http://srobbin.com/jquery-pageslide/
 *
 * jQuery Javascript plugin that slides a pane in from the left or right.
 *
 * Copyright (c) 2013 Ashe Avenue. Created by Tim Boisvert
 * Dual licensed under the MIT and GPL licenses.
*/

;(function($){
    // Convenience vars for accessing elements
    var $paneslide = $('#paneslide');
    
    var _sliding = false,   // Mutex to assist closing only once
        _lastCaller;        // Used to keep track of last element to trigger paneslide
    
	// If the paneslide element doesn't exist, create it
    if( $paneslide.length == 0 ) {
         $paneslide = $('<div />').attr( 'id', 'paneslide' )
                                  .css( 'display', 'none' )
                                  .appendTo( $('body') );
    }
    
    /*
     * Private methods 
     */
    function _load( url, useIframe ) {
        // Are we loading an element from the page or a URL?
        if ( url.indexOf("#") === 0 ) {                
            // Load a page element                
            $(url).clone(true).appendTo( $paneslide.empty() ).show();
        } else {
            // Load a URL. Into an iframe?
            if( useIframe ) {
                var iframe = $("<iframe />").attr({
                                                src: url,
                                                frameborder: 0,
                                                hspace: 0
                                            })
                                            .css({
                                                width: "100%",
                                                height: "100%"
                                            });
                
                $paneslide.html( iframe );
            } else {
                $paneslide.load( url );
            }
            
            $paneslide.data( 'localEl', false );
            
        }
    }
    
    // Function that controls opening of the paneslide
    function _start( position, speed, maincontainer ) {
        var slideWidth = $paneslide.outerWidth( true ),
            slideAnimateIn = {},
            maincontainerAnimateIn = {};
        
        // If the slide is open or opening, just ignore the call
        if( $paneslide.is(':visible') || _sliding ) return;	        
        _sliding = true;
                                                      
        switch( position ) {
            case 'right':
                $paneslide.css({ left: 'auto', right: '-' + slideWidth + 'px' });
                slideAnimateIn['right'] = '+=0';
                
                if(maincontainer) {
                    maincontainerAnimateIn['margin-right'] = slideWidth;
                }
                
                break;
            default:
                $paneslide.css({ left: '-' + slideWidth + 'px', right: 'auto' });
                slideAnimateIn['left'] = '+=0';
                
                if(maincontainer) {
                    maincontainerAnimateIn['margin-left'] = slideWidth;
                }
                
                break;
        }
                    
        // Animate the maincontainer resize
        if(maincontainer) {
            $(maincontainer).animate(maincontainerAnimateIn, speed);
        }
        
        // Animate the slide, and attach this slide's settings to the element
        $paneslide.show()
                  .animate(slideAnimateIn, speed, function() {
                      _sliding = false;
                  });
    }
      
    /*
     * Declaration 
     */
    $.fn.paneslide = function(options) {
        var $elements = this;
        
        // On click
        $elements.click( function(e) {
            var $self = $(this),
                settings = $.extend({ href: $self.data('pane') }, options);
            
            // Prevent the default behavior and stop propagation
            e.preventDefault();
            e.stopPropagation();
            
            if ( $paneslide.is(':visible') && $self[0] == _lastCaller ) {
                // If we clicked the same element twice, toggle closed
                $.paneslide.close();
            } else {                 
                // Open
                $.paneslide( settings );

                // Record the last element to trigger paneslide
                _lastCaller = $self[0];
            }       
        });                   
	};
	
	/*
     * Default settings 
     */
    $.fn.paneslide.defaults = {
        speed:          200,        // Accepts standard jQuery effects speeds (i.e. fast, normal or milliseconds)
        position:      'right',     // Accepts 'left' or 'right'
        modal:          true,      // If set to true, you must explicitly close paneslide using $.paneslide.close();
        iframe:         false,       // By default, linked pages are loaded into an iframe. Set this to false if you don't want an iframe.
        href:           null,       // Override the source of the content. Optional in most cases, but required when opening paneslide programmatically.
        maincontainer:  null,       // A container that should be resized according to the width of the paneslide
    };
	
	/*
     * Public methods 
     */
	
	// Open the paneslide
	$.paneslide = function( options ) {	    
	    // Extend the settings with those the user has provided
        var settings = $.extend({}, $.fn.paneslide.defaults, options);
	    
	    // Are we trying to open in different position?
        if( $paneslide.is(':visible') && $paneslide.data( 'position' ) != settings.position) {
            $.paneslide.close(function(){
                _load( settings.href, settings.iframe );
                _start( settings.position, settings.speed, settings.maincontainer);
            });
        } else {                
            _load( settings.href, settings.iframe );
            if( $paneslide.is(':hidden') ) {
                _start( settings.position, settings.speed, settings.maincontainer);
            }
        }
        
        $paneslide.data( settings );
	}
	
	// Close the paneslide
	$.paneslide.close = function( callback ) {
        var $paneslide = $('#paneslide'),
            slideWidth = $paneslide.outerWidth( true ),
            speed = $paneslide.data( 'speed' ),
            maincontainer = $paneslide.data( 'maincontainer'),
            slideAnimateIn = {},
            maincontainerAnimateIn = {};
        // If the slide isn't open, just ignore the call
        if( $paneslide.is(':hidden') || _sliding ) return;	        
        _sliding = true;
        
        switch( $paneslide.data( 'position' ) ) {
            case 'left':
                slideAnimateIn['left'] = '-=' + slideWidth;
                if(maincontainer) {
                    maincontainerAnimateIn['margin-left'] = '-=0';
                }
                break;
            default:
                slideAnimateIn['right'] = '-=' + slideWidth;
                if(maincontainer) {
                    maincontainerAnimateIn['margin-right'] = '-=0';
                }
                break;
        }
        
        // Animate the maincontainer resize
        if(maincontainer) {
            $(maincontainer).animate(maincontainerAnimateIn, speed);
        }
        
        $paneslide.animate(slideAnimateIn, speed, function() {
            $paneslide.hide();
            _sliding = false;
            if( typeof callback != 'undefined' ) callback(); 
        });
    }
	
	/* Events */
	
	// Don't let clicks to the paneslide close the window
    $paneslide.click(function(e) {
        e.stopPropagation();
    });

	// Close the paneslide if the document is clicked or the users presses the ESC key, unless the paneslide is modal
	$(document).bind('click keyup', function(e) {
	    // If this is a keyup event, let's see if it's an ESC key
        if( e.type == "keyup" && e.keyCode != 27) return;
	    
	    // Make sure it's visible, and we're not modal	    
	    if( $paneslide.is( ':visible' ) && !$paneslide.data( 'modal' ) ) {	        
	        $.paneslide.close();
	    }
	});
	
})(jQuery);
