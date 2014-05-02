$(document).ready(function() {

    $('#add_link').click(function(event){
        // Browser, please do not follow this link.
        event.preventDefault();
        $(this).hide();

        $.get('/contacts/new', function(form){
            $('.container').append(form);
        }).fail(function(){
            $('#add_link').show();
        });

    });

    $('.container').on('submit', '#new_contact', function(event){
        // Browser, please do not submit this form.
        event.preventDefault();
        var url = $(this).attr('action');
        var data = $(this).serialize();

        $.post(url, data, function(table_row){
            console.log(table_row);
            $('tbody').append(table_row);
        });

        $('h1:last').remove();
        $(this).remove();
        $('#add_link').show();

    });

});
