var templates = (function($) {
    
    return {
        
        init: function() {
            
            $('#template-name').sluggo({
                target:             '#template-slug',
                makeTargetReadonly: true
            });
            
            $('#content .components').sortable(
                {
                    axis: 'y',
                    update: function(){
                        $.post(
                            $(this).data('update-url'), 
                            $(this).sortable('serialize')
                        );
                    }
                }
            );
            
        },
        
        add_component: function(component_id) {
            
            //post the new article
            $.post(
                $('#add_component').data('path'),
                {
                    component_id: component_id
                },
                function() {
                    //Adding the new item to the list is handled by the 
                    //Rails add_component.js.erb template.
                    //
                    //Just close the picker.
                    picker.close();
                }
            );
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    templates.init();
});