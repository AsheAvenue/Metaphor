var categories = (function($) {
    
    return {
        
        init: function() {
    
            $('#category-name').sluggo({
                target:             '#category-slug',
                makeTargetReadonly: true
            });
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    categories.init();
});