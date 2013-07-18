var admin = (function($) {
    
    return {
        init: function() {
    
            /************ List ************/
    
            $('#items').mixitup({
                layoutMode: 'list',
                effects: ['fade','blur'],  
                listEffects: ['fade','rotateX']
            });
            
        },
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    admin.init();
});

function slugify(t){
    t = $.trim(t);
    return t.toLowerCase().replace(/[-]/g, " ").replace(/[^\w ]+/g,'').replace(/ +/g,'-');
}

