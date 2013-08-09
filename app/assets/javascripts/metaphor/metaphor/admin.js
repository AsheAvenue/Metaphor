var admin = (function($) {
    
    return {
        init: function() {
    
            /************ List ************/
    
            $('#items').mixitup({
                layoutMode: 'list',
                effects: ['fade','blur'],  
                listEffects: ['fade','rotateX']
            });
            
            var $filters = $('#Filters').find('li'),
				dimensions = {
					template: 'all',
					flag: 'all',
                    status: 'all'
				};
	
			// Bind checkbox click handlers:

			$filters.on('click',function(){
				var $t = $(this),
					dimension = $t.attr('data-dimension'),
					filter = $t.attr('data-filter'),
					filterString = dimensions[dimension];
		
				if(filter == 'all'){
					$t.addClass('active').siblings().removeClass('active');
					filterString = 'all';	
				} else {
					if(!$t.hasClass('active')){
                        $t.siblings('[data-filter]').removeClass('active');
    					$t.addClass('active');
						filterString = filter;
					} else {
                        $t.siblings('[data-filter="all"]').addClass('active');
    					filterString = 'all';
                        $t.removeClass('active');
						var re = new RegExp('(\\s|^)'+filter);
						filterString = filterString.replace(re,'');
					};
				};
	
				dimensions[dimension] = filterString;
				$('#items').mixitup('filter',[dimensions.template, dimensions.flag, dimensions.status])			
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

