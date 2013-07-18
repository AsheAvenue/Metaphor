var article_editor = (function($) {
    
    var self;
    
    return {
        
        init: function() {
            
            self = this;
            
            $('#article-preview').click(function(){
                if($('#article-preview').html() == "Preview") {
                    $('#article_editor .selected-buttons').hide('fast');
                    picker.close();
                    $('#article-preview').html('Done Previewing');
                } else {
                    $('#article_editor .selected-buttons').show('fast');
                    $('#article-preview').html('Preview');
                }
            });
            
            // Enable the contenteditable fields
    		$("#article").contentEditable().change(function(e){
    			//post if the content has been changed
                if(e.action == "save") {
                    
                    //fade in the border
                    $('.body-container').animate({"border-color": "#16a085"}, 250);
                    
                    $.post(
                        $('#update_body').data('path'),
                        {
                            article_id: $('#article').data('id'),
                            body: $('.body-container').html()
                        }, 
                        function() {
                            $('.body-container').animate({"border-color": "transparent"}, 250);
                        }
                    );
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
        }
    };
})(jQuery);

jQuery(document).ready(function($) {
    article_editor.init();
});