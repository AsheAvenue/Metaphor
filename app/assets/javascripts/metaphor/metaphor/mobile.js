// Logic for the article lightboxes
var mobile = new function() {

    var self = this;

    this.init = function() {
        self.submitForm();
    };
    
    this.submitForm = function() {
        $('.mobile .submit').on('click', function() {
            $('#article_slug').val(slugify($('#article_title').val()));
            $(this).text('Publishing...');
            $(this).parents('form').submit();
        });
    };
    
};

$(function() {
    mobile.init();
});
