var article_editor = (function($) {
    
    var self;
    
    return {
        
        init: function() {
            
            self = this;
            
            //fire up redactor
            $('.redactor').redactor({ 
                convertImageLinks: true,
                convertVideoLinks: true,
                removeEmptyTags: false,
                linkAnchor: false,
                placeholder: 'Enter body text...',
                buttons: ['html', '|', 'formatting', '|', 'bold', 'italic', 'deleted', '|', 'unorderedlist', 'orderedlist', '|', 'add_image', 'add_video', 'link', '|', 'horizontalrule'],
                formattingTags: ['p', 'blockquote', 'h3'],
                buttonsCustom: {
                    add_image: {
                        title: 'Add Image', 
                        callback: self.add_image_to_body
                    },
                    add_video: {
                        title: 'Add Video', 
                        callback: self.add_video_to_body
                    } 
                }
                
            });
            
            //tweak redactor things we want changed 
            $('.redactor_format_h3').html('Header');
            
            $('#article-save-in-editor').click(function(event){
                event.preventDefault();
                $.post(
                    $('#update_body').data('path'),
                    {
                        body: $('.redactor').redactor('get').val()
                    },
                    function() {
                        window.location.reload();
                    }
                );
                
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
        }
    };
})(jQuery);

jQuery(document).ready(function($) {
    article_editor.init();
});