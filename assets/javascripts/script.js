function loadGroupPermission(id) {
    $.ajax({
        method: "GET",
        dataType: "json",
        url: $('#privatPerm').attr('data-url'),
        data: { id: id },
        success: function(data) {
            var items = '';
            $.each(data[0].groups, function(key,val) {
                items += "<li id='" + val.id + "'><div class='groups'>" + val.lastname + "</div></li>";
            });
            $('#privatPerm').html(items);
        }
    });
    $("#privateWikiUserDialog").dialog('close');
}

function loadForm(id) {
    $.ajax({
        method: "GET",
        dataType: "json",
        url: $('#addWikiUser').attr('href'),
        data: { id: id },
        success: function(data) {
            var items = '';
            console.log(data[0]);
            $.each(data[0].groups, function(key,val) {
                var val = val[0];
                items += "<div>";
                items += '<label>'
                if(val.checked) {
                    items += '<input name="private_group" id="private_group" value="' + val.id + '" type="checkbox" checked="checked">' + val.name;
                } else {
                    items += '<input name="private_group" id="private_group" value="' + val.id + '" type="checkbox">' + val.name;
                }
                items += '</label>';
                items += "</div>";
//                 console.log(items);
            });
            $('#privateWikiUserDialog form.form').html(items);
        }
    });
}


$(function() {
    $("#privateWikiUserDialog").dialog({
        autoOpen: false,
        modal: true,
        width: 400,
        buttons: {
            Save: function() {
                var form = $('#privateWikiUserDialog .form');
                var ids = $('#privateWikiUserDialog input:checked').map(function() {
                    return this.value;
                }).get().join(',');
            
                $.ajax({
                    method: "POST",
                    dataType: "json",
                    url: form.attr('data-url'),
                    data: { title: form.attr('data-title'), wiki_id: form.attr('data-wiki'), groups: ids },
                    success: function(data) {
                        var data = data[0];
                        loadGroupPermission(data.id);
                    }
                })
            },
            Cancel: function() {
              $( this ).dialog("close");
            }
          }
        });
    $( "#addWikiUser" ).click(function(e) {
        e.preventDefault();
        loadForm($('#privatPerm').attr('data-id'));
        $("#privateWikiUserDialog").dialog("open");
    });
});
