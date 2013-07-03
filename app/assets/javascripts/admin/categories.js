var categories = (function($) {
    
    return {
        
        init: function() {
    
            $('#category-name').sluggo('#category-slug');
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    categories.init();
});