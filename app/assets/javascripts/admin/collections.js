var collections = (function($) {
    
    return {
        
        init: function() {

            $('#content .pinned-articles').sortable(
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
        
        add_pinned_article: function(article_id) {
            
            //post the new article
            $.post(
                $('#add_pinned_article').data('path'),
                {
                    article_id: article_id
                },
                function() {
                    //Adding the new item to the list is handled by the 
                    //Rails add_pinned_article.js.erb template.
                    //
                    //Just close the picker.
                    picker.close();
                }
            );
        }
    };
})(jQuery);

jQuery(document).ready(function($) {
    collections.init();
});