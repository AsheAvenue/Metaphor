var articles = (function($) {
    
    return {
        init: function() {

            /************ New/Edit Article ************/
    
            //autosize the article textareas
            $('#article-title').autosize();
            $('#article-summary').autosize();
            $('#article-body').autosize();
    
            //hide the default image file form field on page load if we already have an image
            if($('#article-default-image .display').is(':visible')) {
                $('#article-default-image .upload').hide();
            }
    
            $('#article-default-image-view-all-sizes').magnificPopup({ 
                type: 'ajax',
                alignTop: true,
                overflowY: 'scroll',
                width: 400
            });

            //handle the remove image button
            $('#article-default-image-view-remove-image').click(function(e){
                e.preventDefault();
                $('#article-default-image .display').hide('fast');
                $('#article-default-image .upload').show('fast');
                $("#article-default-image-remove-checkbox").prop('checked', true);
            });
            
            //set the template on load
            var template = $('#article-template').val();
            if(template != null) {
                $('#template-' + template).addClass('active');
            }
            
            //template selection
            $('.template').click(function(){
                //get the template key
                var template_key = $(this).data("template");
                
                //swap highlight
                $('.template').removeClass("active");
                $(this).addClass("active");
                
                //set the article-template value
                $('#article-template').val(template_key);
            });
    
            //track the slug
            var slug_is_set = false;
    
            // don't let the slug be changed right off the bat if it's already been set
            var slug = $('#article-slug-display').text();
            if(slug != '' && slug != 'Awaiting article title...') {
                slug_is_set = true;
            }
    
            // create a slug if necessary when the article title is provided or the change button has been clicked
            $('#article-title, #article-slug').focusout(function(){
                if(!slug_is_set) {
            
                    //make sure we're only running the validation process if the value has actually changes.
                    var original_slug = $(this).data('original-slug');
                    var new_slug = $(this).val();
            
                    if(new_slug != '' && original_slug != new_slug) {
                        var slug = slugify(new_slug); //slugify
        
                        //set the slug display
                        $('#article-slug-display').html(slug);
        
                        //kick off the slug checker
                        $('#article-slug-check').show('fast');
                        $('#article-slug').val(slug);
                        $.post('/admin/articles/checkslug', 
                            {
                                slug: slug
                            },
                            function(data) {
                                if(data == "FALSE") {
                                    $("#article-slug-check").html('<span class="label label-success"><i class="icon-ok icon-large icon-white"></i> Slug is valid and available</span>');
                                    $('#article-slug-container').hide('fast');
                                    $('#article-slug-display').show('fast');
                                    $('#article-slug-reset').show('fast');
                                    slug_is_set = true;
                                } else if (data == "TRUE") {
                                    $("#article-slug-check").html('<span class="label label-warning"><i class="icon-remove icon-large icon-white"></i> Slug already in use. Please try a different slug.</span>');
                                    $('#article-slug-container').show('fast');
                                    $('#article-slug-display').hide('fast');
                                    $('#article-slug-reset').hide('fast');
                                }
                            }
                        );
                    } else {
                        //just reset the box
                        $('#article-slug-container').hide('fast');
                        $('#article-slug-display').show('fast');
                        $('#article-slug-reset').show('fast');
                    }
                }
            });
    
            //handle the slug change button
            $('#article-slug-change').click(function(){
                slug_is_set = false;
                $("#article-slug-check").html('<span class="label label-warning"><i class="icon-remove icon-large icon-white"></i> Slug already in use. Please try a different slug.</span>');
                $('#article-slug-container').show('fast');
                $('#article-slug-display').hide('fast');
                $('#article-slug-reset').hide('fast');
            });
    
            //handle the author change button
            $('#article-author-change').click(function(){
                $('#article-author-container, #article-author-other').show('fast');
                $('#article-author-display, #article-author-change').hide('fast');
                $('#article-author-other-name').val('');
            });
    
            //handle the author use other name button
            $('#article-author-use-other').click(function(){
                $('#article-author-container, #article-author-reset, #article-author-use-other').hide('fast');
                $('#article-author-other-name, #article-author-other-cancel').show('fast');
            });
    
            //go back to the author list if the user doesn't want to input an other author name after all
            $('#article-author-use-existing').click(function(){
                $('#article-author-other-name, #article-author-other-cancel').hide('fast');
                $('#article-author-container, #article-author-use-other').show('fast');
                $('#article-author-other-name').val('');
            });
    
            //show the author list if this is a new article
            if($.trim($('#article-author-display').html()).length == 0) {
                $('#article-author-container, #article-author-other, #article-author-use-other').show('fast');
                $('#article-author-display, #article-author-reset').hide('fast');
            }
    
            $("#article-publish-at").datetimepicker({
                format: "dd MM yyyy - hh:ii",
                autoclose: true,
                showMeridian: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });
    
            //hide the publish at view on page load if the article is currently published
            if($('#article-published').is(':checked')) {
                $('#schedule').hide();
            }
    
            //toggle the publish at view on the published switch change
            $('.article-published').on('switch-change', function (e, data) {
                var $el = $(data.el);
                var value = data.value;
        
                //show or hide the publish at section
                if(value == true) {
                    $('#schedule').slideUp('fast');
                } else {
                    $('#schedule').slideDown('fast');
                }
            });
    
            //handle the preview button
            $('#article-preview').click(function(e){
              e.preventDefault();
              window.location.href = $('#article-preview').attr('href');
            });
    
            $('#article-submit').click(function(e){
              e.preventDefault();
              $('#article-form').submit();
            });

            $('#article-edit').click(function(e){
              e.preventDefault();
              $('#article-form').append('<input type="hidden" name="edit-content" value="true" />');
              $('#article-form').submit();
            });
                
            /************ Preview Article ************/
    
            //preview size selection
            $('.preview-size').click(function(e){
              e.preventDefault();
              if(!$(this).hasClass('active')) {
                if($(this).attr('id') == "preview-size-screen") {
                  $('#preview-size-mobile').removeClass('active');
                  $(this).addClass('active');
                  $('#preview-list-iframe').animate({width:'100%'}, 'fast')
                  $('#preview-article-iframe').animate({width:'100%'}, 'fast')
                } else if($(this).attr('id') == "preview-size-mobile") {
                  $('#preview-size-screen').removeClass('active');
                  $(this).addClass('active');
                  $('#preview-list-iframe').animate({width:'320px'}, 'fast')
                  $('#preview-article-iframe').animate({width:'320px'}, 'fast')
                }
              }
            });
            
        },
        
    };
})(jQuery);

jQuery(document).ready(function($) {
    articles.init();
});

function slugify(t){
    t = $.trim(t);
    return t.toLowerCase().replace(/[-]/g, " ").replace(/[^\w ]+/g,'').replace(/ +/g,'-');
}

