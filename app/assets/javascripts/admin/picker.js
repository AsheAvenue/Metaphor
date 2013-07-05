var picker = (function($) {

    var picker_type,
        picker_callback_scope,
        picker_callback_function,
        picker_position,
        picker_item;

    return {
        
        init: function() {

            //show the picker
            $('[data-picker]').on('click', function(event){
        
                //get the type of picker we want to display and the callback
                picker_type = $(this).data('picker');
                
                //disassemble the callback
                var picker_callback = $(this).data('picker-callback').split("#");
                picker_callback_scope = picker_callback[0];
                picker_callback_function = picker_callback[1];
                
                //get the position
                picker_position = $(this).data('picker-position');
                
                //add the "has-right-bar" class to the content div
                $('#content').addClass('has-right-bar');
                $('#picker').load('/admin/picker/' + picker_type, function() {
                    
                    //show the picker
                    $('#picker').show();
                    
                    //display the "content select" view
                    $('.pickercontent .content.select').show();
                    
                    //enable any slug fields within the picker
                    $('.pickercontent .picker-new-name').sluggo('.picker-new-slug');
                });
            });
    
            //handle single selection of an item
            $('#picker').on('click', '[data-picker-item]', function(event){
                //cancel the link click
                event.preventDefault();
        
                //get the value of this selected item
                picker_item = $(this).data('picker-item');
                
                //now return
                picker.select(picker_item);
                
            });
            
            //switch between tabs
            $('#picker').on('click', '.pickercontent .tabs .tab', function(event){
                
                //hide all content
                $('.pickercontent .content').hide();
                
                //show selected
                var content = $(this).data('content');
                $('.pickercontent .' + content).show();
            });
            
            //enable the video add button
            $('#picker').on('click', '#picker-add-video', function(event){
                event.preventDefault();
                picker.addVideo();
            });
        },
        
        select: function(picker_item) {
            //call back to the method passed in as a callback
            window[picker_callback_scope][picker_callback_function](picker_item, picker_position);
        }, 
        
        close: function() {
            //remove the picker
            $('#content').removeClass('has-right-bar');
            $('#picker').hide();
        },
        
        addVideo: function() {
            
            //get the values
            video_name = $('#video-name').val();
            video_slug = $('#video-slug').val();
            video_code = $('#video-code').val();
            
            //post to the picker's addVideo method
            //post the new article
            $.post(
                '/admin/picker/addVideo',
                {
                    video_name: video_name,
                    video_slug: video_slug,
                    video_code: video_code
                },
                function(data) {
                    //Adding the new video will return the id of the new Video object
                    //now select it as if it hadn't been added
                    picker.select(data);
                }
            );
        }
    };
})(jQuery);

jQuery(document).ready(function($) {
    picker.init();
});
