var external_entities = (function($) {
    
    return {
        
        init: function() {
    
            $('#external-entity-name').sluggo({
                target:             '#external-entity-slug',
                makeTargetReadonly: true
            });
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    external_entities.init();
});