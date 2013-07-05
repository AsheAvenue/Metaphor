var article_editor = (function($) {
    
    return {
        
        init: function() {
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
                    //Adding the video to the top video section is handled by the 
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
                    //Adding the image to the top video section is handled by the 
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
                    //Adding the video to the top video section is handled by the 
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