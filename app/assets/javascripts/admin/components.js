var components = (function($) {
    
    return {
        
        init: function() {
    
            $('#component-name').sluggo('#component-slug');
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    components.init();
});