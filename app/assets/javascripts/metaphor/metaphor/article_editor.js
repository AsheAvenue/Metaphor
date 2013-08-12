var article_editor = (function($) {
    
    var self;
    var body_has_changed;
    
    return {
                
        init: function() {
            
            self = this;
            body_has_changed = false;
            
            $('#article-preview').click(function(){
                if($('#article-preview').html() == "Preview") {
                    $('#article_editor .selected-buttons').hide('fast');
                    $('#article-body-toolbar, #article_editor .redactor_box').addClass('preview');
                    picker.close();
                    $('#article-preview').html('Done Previewing');
                } else {
                    $('#article_editor .selected-buttons').show('fast');
                     $('#article-body-toolbar, #article_editor .redactor_box').removeClass('preview');
                    $('#article-preview').html('Preview');
                }
            });
            
            //fire up redactor
            $('.redactor').redactor({ 
                convertImageLinks: true,
                convertVideoLinks: true,
                removeEmptyTags: false,
                linkAnchor: false,
                toolbarExternal: '#article-body-toolbar',
                placeholder: 'Enter body text...',
                buttons: ['html', '|', 'formatting', '|', 'bold', 'italic', 'deleted', '|', 'unorderedlist', 'orderedlist', '|', 'add_image', 'add_video', 'add_sound', 'link', '|', 'horizontalrule'],
                formattingTags: ['blockquote', 'h3'],
                buttonsCustom: {
                    add_image: {
                        title: 'Add Image', 
                        callback: self.add_image_to_body
                    },
                    add_video: {
                        title: 'Add Video', 
                        callback: self.add_video_to_body
                    },
                    add_sound: {
                        title: 'Add Sound', 
                        callback: self.add_sound_to_body
                    } 
                },
                changeCallback: function() {
            		body_has_changed = true;
            	}
            });
            
            //catch the toolbar and make it sticky if it goes offscreen
            var catcher        = $('#article-body-toolbar-catcher'),
                sticky         = $('#article-body-toolbar'),
                toolbarHeight  = 50;
            $(window).scroll(function() {
                if($(sticky).is(':visible')) {
                    if(sticky.data('stuck') != 'true' && $(window).scrollTop() > ($(catcher).offset().top - toolbarHeight)) {
                        sticky.css({
                            position: 'fixed',
                            top: toolbarHeight + 'px'
                        });
                        sticky.data('stuck', 'true');
                    } 
                    if(sticky.data('stuck') == 'true' && $(window).scrollTop() < ($(catcher).offset().top - toolbarHeight)) {
                        sticky.css({
                            position: 'relative',
                            top:      'auto'
                        });
                        sticky.data('stuck', 'false');
                    }
                }
            });
            
            //tweak redactor things we want changed 
            $('.redactor_format_h3').html('Header');
            
            $('#article-save-in-editor').click(function(event){
                event.preventDefault();
                self.save_body(true);
            });
            
            $('#article-back').click(function(event){
               event.preventDefault(); 
               
               if(body_has_changed) {
                   //alert the user that they should save
                   $('#article-save-in-editor, #article-preview, #article-back').hide();
                   $('#article-save-confirm, #article-cancel, #article-dont-save, #bottom-bar .article-needs-save-message').show();
                   
                   $('#article-save-confirm').click(function(){
                       self.save_body(false);
                       window.location.href = $('#article-back').attr('href');
                   });
                   
                   $('#article-dont-save').click(function(){
                       window.location.href = $('#article-back').attr('href');
                   });
                   
                   $('#article-cancel').click(function(){
                       $('#article-save-confirm, #article-cancel, #article-dont-save, #bottom-bar .article-needs-save-message').hide();
                       $('#article-save-in-editor, #article-preview, #article-back').show();
                   });
               } else {
                   window.location.href = $(this).attr('href');
               }
            });
        
        },
        
        select_video: function(video_id, position) {
            
            //post the new video to 
            $.post(
                $('#select_video').data('path'),
                {
                    article_id: $('#article').data('id'),
                    video_id: video_id,
                    position: position
                },
                function() {
                    //Adding the video to the video section is handled by the 
                    //Rails select_video.js.erb template.
                    //
                    //Just close the picker.
                    picker.close();
                }
            );
        },
        
        select_image: function(image_id, position) {
            
            //post the new video to 
            $.post(
                $('#select_image').data('path'),
                {
                    article_id: $('#article').data('id'),
                    image_id: image_id,
                    position: position
                },
                function() {
                    //Adding the image to the image section is handled by the 
                    //Rails select_video.js.erb template.
                    //
                    //Just close the picker.
                    picker.close();
                }
            );
        },
        
        select_gallery: function(gallery_id, position) {
            
            //post the new video to 
            $.post(
                $('#select_gallery').data('path'),
                {
                    article_id: $('#article').data('id'),
                    gallery_id: gallery_id,
                    position: position
                },
                function() {
                    //Adding the gallery to the gallery section is handled by the 
                    //Rails select_video.js.erb template.
                    //
                    //Just close the picker.
                    picker.close();
                }
            );
        },
        
        select_sound: function(sound_id, position) {
            
            //post the new video to 
            $.post(
                $('#select_sound').data('path'),
                {
                    article_id: $('#article').data('id'),
                    sound_id: sound_id,
                    position: position
                },
                function() {
                    //Adding the sound to the sound section is handled by the 
                    //Rails select_video.js.erb template.
                    //
                    //Just close the picker.
                    picker.close();
                }
            );
        },
        
        add_image_to_body: function(obj) {
            picker.launchPicker('image', 'article_editor#select_image_for_body', -1);
        },
        
        add_video_to_body: function(obj) {
            picker.launchPicker('video', 'article_editor#select_video_for_body', -1);
        },
        
        add_sound_to_body: function(obj) {
            picker.launchPicker('sound', 'article_editor#select_sound_for_body', -1);
        },
        
        select_image_for_body: function(obj) {
            $.post(
                $('#get_image_for_body').data('path'),
                {
                    image_id: obj
                },
                function() {
                    picker.close();
                }
            );
        },
        
        select_video_for_body: function(obj) {
            $.post(
                $('#get_video_for_body').data('path'),
                {
                    video_id: obj
                },
                function() {
                    picker.close();
                }
            );
        },
        
        select_sound_for_body: function(obj) {
            $.post(
                $('#get_sound_for_body').data('path'),
                {
                    sound_id: obj
                },
                function() {
                    picker.close();
                }
            );
        },
        
        save_body: function(refresh){
            $.post(
                $('#update_body').data('path'),
                {
                    body: $('.redactor').redactor('get')
                },
                function() {
                    if(refresh) {
                        window.location.reload();
                    }
                }
            );
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    article_editor.init();
});

