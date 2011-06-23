$(document).ready(function(){ 
    $("input[name=sign_up]").live('click', function() {

        var value = $(this).val();
        $(".sign_up_form").hide();
        $("#"+value).show();
    }); 
});