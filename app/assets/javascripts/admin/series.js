var series = (function($) {
    
    return {
        
        init: function() {
    
            $('#series-name').sluggo('#series-slug');
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    series.init();
});