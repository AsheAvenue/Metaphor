var pages = (function($) {
    
    return {
        init: function() {
    
            $('#page-name').sluggo({
                target:             '#page-slug',
                makeTargetReadonly: true
            });
            
            //fire up redactor
            $('#page-content').redactor({ 
                convertImageLinks: true,
                convertVideoLinks: true,
                removeEmptyTags: false,
                linkAnchor: false,
                placeholder: 'Enter page text...',
                buttons: ['html', '|', 'formatting', '|', 'bold', 'italic', 'deleted', '|', 'unorderedlist', 'orderedlist', '|', 'link', '|', 'horizontalrule'],
                formattingTags: ['blockquote', 'h3']
            });
            
        }
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    pages.init();
});