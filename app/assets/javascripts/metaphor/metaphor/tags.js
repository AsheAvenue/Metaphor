var tags = (function($) {
    
    return {
        
        init: function() {
    
            $('#article_tag_list').tagit({
                autocomplete: {
                    delay: 0,
                    minLength: 2,
                    messages: {
                        noResults: '',
                        results: function(){}
                    },
                    source: function(request,showChoices){
                        if(request.term.length>1){
                            $.ajax({
                                url:"/admin/articles/taglist/"+request.term,
                                dataType:"json",
                                success:function(data){
                                    showChoices(data);
                                }
                            });
                        }
                    }
                }
            });
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    tags.init();
});