var article_editor = (function($) {
    
    return {
        
        init: function() {

        },
        
        select_top_video: function(video_id, position) {
            
            //post the new video to 
            $.post(
                $('#select_top_video').data('path'),
                {
                    article_id: $('#article').data('id'),
                    video_id: video_id,
                    position: position
                },
                function() {
                    //Adding the video to the top video section is handled by the 
                    //Rails select_top_video.js.erb template.
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