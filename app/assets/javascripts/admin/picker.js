var picker = (function($) {

    var picker_type,
        picker_callback_scope,
        picker_callback_function,
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
                
                //add the "has-right-bar" class to the content div
                $('#content').addClass('has-right-bar');
                $('#picker').load('/admin/picker/' + picker_type, function() {
                    $('#picker').show();
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
            
            $('#picker').on('click', '.pickercontent .tabs .tab', function(event){
                
                //hide all content
                $('.pickercontent .content').hide();
                
                //show selected
                var content = $(this).data('content');
                $('.pickercontent .' + content).show();
            });
        },
        
        select: function(picker_item) {
            //call back to the method passed in as a callback
            window[picker_callback_scope][picker_callback_function](picker_item);
        }, 
        
        close: function() {
            //remove the picker
            $('#content').removeClass('has-right-bar');
            $('#picker').hide();
        }
    };
})(jQuery);

jQuery(document).ready(function($) {
    picker.init();
});
