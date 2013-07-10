var series = (function($) {
    
    return {
        
        init: function() {
    
            $('#series-name').sluggo({
                target:             '#series-slug',
                makeTargetReadonly: true
            });
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    series.init();
});