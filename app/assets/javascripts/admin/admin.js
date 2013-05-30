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
    
    $('#article-slug-change').click(function(){
        slug_is_set = false;
        $("#article-slug-check").html('<span class="label label-warning"><i class="icon-remove icon-large icon-white"></i> Slug already in use. Please try a different slug.</span>');
        $('#article-slug-container').show('fast');
        $('#article-slug-display').hide('fast');
        $('#article-slug-reset').hide('fast');
    });
    
    $("#article-publish-switch").datetimepicker({
        format: "dd MM yyyy - hh:ii",
        autoclose: true,
        showMeridian: true,
        todayBtn: true,
        pickerPosition: "bottom-left"
    });
    
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