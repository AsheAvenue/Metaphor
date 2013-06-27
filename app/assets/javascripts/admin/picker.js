$(function(){
    
    /************ Picker ************/

    $('[data-picker]').click(function(event){
        
        //get the type of picker we want to display
        var picker_type = $(this).data('picker');
        
        //add the "has-right-bar" class to the content div
        $('#content').addClass('has-right-bar');
        $('#picker').load('/admin/picker/' + picker_type, function() {
            $('#picker').show();
            
            //make items draggable
            $('.pickercontent .item').draggable();
        });
    });
});