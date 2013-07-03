var users = (function($) {
    
    return {
        init: function() {
    
            //show the display name if this is a new user
            if($.trim($('#user-display-name-display').html()).length == 0) {
                $('#user-display-name-container').show('fast');
                $('#user-display-name-reset, #user-display-name-display').hide('fast');
            }
    
            //handle the display name change button
            $('#user-display-name-change').click(function(){
                $('#user-display-name-container').show('fast');
                $('#user-display-name-reset, #user-display-name-display').hide('fast');
            });
    
            //set the display name to the email address if it's not set
            $('#user-username').focusout(function(){
                if($('#user-display-name').val() == '') {
                    $('#user-display-name').val($('#user-username').val());
                }
            });
            
        },
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    users.init();
});