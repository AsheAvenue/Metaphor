var components = (function($) {
    
    return {
        
        init: function() {
    
            $('#component-name').sluggo({
                target:             '#component-slug',
                makeTargetReadonly: true
            });
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    components.init();
});