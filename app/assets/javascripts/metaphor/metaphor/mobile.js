// Logic for the article lightboxes
var mobile = new function() {

    var self = this,
        submitted = false;

    this.init = function() {
        self.submitForm();
    };
    
    this.submitForm = function() {
        $('.mobile .submit').on('click', function() {
            if(submitted == false) {
                $('#article_slug').val(slugify($('#article_title').val()));
                $(this).text('Publishing...');
                $(this).parents('form').submit();
                submitted = true;
            }
        });
    };
    
};

$(function() {
    mobile.init();
});
