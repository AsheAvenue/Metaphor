var pages = (function($) {
    
    return {
        init: function() {
    
            $('#page-name').sluggo({
                target:             '#page-slug',
                makeTargetReadonly: true
            });
            
            $('#page-submit').click(function(e){
              e.preventDefault();
              $('#page-form').submit();
            });
            
            $('#page-content').wymeditor();
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    pages.init();
});