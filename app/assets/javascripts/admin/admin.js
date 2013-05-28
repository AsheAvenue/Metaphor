$(function(){
    $('#settings-bar .item .top').click(function(){
        $(this).next().toggle('fast');
    });
});