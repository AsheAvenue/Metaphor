var flags = (function($) {
    
    return {
        
        init: function() {
    
            $('#flag-name').sluggo({
                target:             '#flag-slug',
                makeTargetReadonly: true
            });
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    flags.init();
});