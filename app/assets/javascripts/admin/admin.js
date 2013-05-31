$(function(){
    
    var slug_is_set = false;
    
    $('#article-title, #article-slug').focusout(function(){
        if(!slug_is_set) {
            
            //make sure we're only running the validation process if the value has actually changes.
            var original_slug = $(this).data('original-slug');
            var new_slug = $(this).val();
            
            if(original_slug != new_slug) {
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
    
    //handle the category change button
    $('#article-category-change').click(function(){
        if($('#article-category-container').is(':visible')) {
            $('#article-category-container').hide('fast');
            $('#article-category-display, #article-category-change').show('fast');
        } else {
            $('#article-category-container').show('fast');
            $('#article-category-display, #article-category-change').hide('fast');
        }
    });
    
    //show the category list if this is a new article
    if($.trim($('#article-category-display').html()).length == 0) {
        $('#article-category-container').show('fast');
        $('#article-category-display, #article-category-change').hide('fast');
    }
    
    //handle the series change button
    $('#article-series-change').click(function(){
        if($('#article-series-container').is(':visible')) {
            $('#article-series-container').hide('fast');
            $('#article-series-display, #article-series-change').show('fast');
        } else {
            $('#article-series-container').show('fast');
            $('#article-series-display, #article-series-change').hide('fast');
        }
    });
    
    //show the series list if this is a new article
    if($.trim($('#article-series-display').html()).length == 0) {
        $('#article-series-container').show('fast');
        $('#article-series-display, #article-series-change').hide('fast');
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
    
});

function slugify(t){
    t = $.trim(t);
    return t.toLowerCase().replace(/[-]/g, " ").replace(/[^\w ]+/g,'').replace(/ +/g,'-');
}