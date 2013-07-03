var pages = (function($) {
    
    return {
        init: function() {
    
            $('#page-name').sluggo('#page-slug');
            
            $('#page-submit').click(function(e){
              e.preventDefault();
              $('#page-form').submit();
            });
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    pages.init();
});