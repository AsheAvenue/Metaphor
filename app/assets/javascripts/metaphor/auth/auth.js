var auth = (function($) {
    
    return {
        
        init: function() {
            
            $('#signin-button').on('click', function(e){
                e.preventDefault();
                $('#signin-form').submit();
            });
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    auth.init();
});