
$(document).ready(function(){

    $("#wiki_form_source_code").attr('disabled', true) ;
    $("#wiki_form_source_name").attr('disabled', true) ;


    $("#wiki_form_url").change(function(){
        var url_val = $(this).val().split('/')[2];

        if (host_hash[url_val]){
            $("#wiki_form_source_code").val(host_hash[url_val][0]);
            $("#wiki_form_source_name").val(host_hash[url_val][1]);
        }
        else
        {
            $("#wiki_form_source_code").attr('disabled', false);
            $("#wiki_form_source_name").attr('disabled', false);
        }
    });

    $("#wiki_form_from_row").change(function(){

        if ($(this).val().indexOf(",") !== -1){
            $('#wiki_form_to_row').attr('disabled', true);

        }
        else {
            $('#wiki_form_to_row').attr('disabled', false);
        }

    });

    $("#wiki_form_select_from_row").change(function(){

        if ($(this).val().indexOf(",") !== -1){
            $('#wiki_form_select_to_row').attr('disabled', true);

        }
        else {
            $('#wiki_form_select_to_row').attr('disabled', false);
        }

    });

    $("#wiki_form_from_col").change(function(){

        if ($(this).val().indexOf(",") !== -1){
            $('#wiki_form_to_col').attr('disabled', true);

        }
        else {
            $('#wiki_form_to_col').attr('disabled', false);

        }

    });

    $("#wiki_form_select_from_col").change(function(){

        if ($(this).val().indexOf(",") !== -1){
            $('#wiki_form_select_to_col').attr('disabled', true);

        }
        else {
            $('#wiki_form_select_to_col').attr('disabled', false);

        }

    });

    $("#wiki_form_dataset_code").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#wiki_form_token").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#wiki_form_url").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#wiki_form_source_code").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#wiki_form_source_name").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#wiki_form_dataset_name").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#wiki_form_dataset_description").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#wiki_form_parser_name").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#wiki_form_which_table").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#wiki_form_col_spec").change(function(){

        $('#send_button').attr('disabled', true);
    });

    $("#preview_button").click(function() {
        $('#send_button').attr('disabled', false);
        $("#wiki_form_source_code").attr('disabled', false);
        $("#wiki_form_source_name").attr('disabled', false);
    });


    $("#wiki_form_url").change(function(){

        var value = $(this).val();
        $("#import_url_iframe").attr("src", value);
    });

    $("#delimiter").hide();
    $("#criteria").hide();
    $("#which_table").hide();
    $("#which_sheet").hide();
    $("#from_row").hide();
    $("#to_row").hide();
    $("#from_col").hide();
    $("#to_col").hide();
    $("#match").hide();
    $("#strip_from").hide();
    $('#content-type').hide();
    $("#select_from_row").hide();
    $("#select_to_row").hide();
    $("#select_from_col").hide();
    $("#select_to_col").hide();
    $("#move_from_row").hide();
    $("#move_to_row").hide();


    $("#wiki_form_url").change(function () {
        $.ajax({
            type: "GET",
            url: "/wiki_forms/content",
            data: {
                input_url: $("#wiki_form_url").val()
            },
            dataType: "json"
        }).done(function (data) {

                if (data[0] == "text/html")
                {
                    $("#wiki_form_parser_name").val("html");
                    $("#wiki_form_criteria").val("table");
                    $("#wiki_form_which_table").val(data[1]);
                    $("#which_table").show();
                    $("#criteria").show();
                    $("#wiki_form_col_spec").val(data[2]);

                }
                else if (data[0] == "text/csv")
                {
                    $("#wiki_form_parser_name").val("csv");
                    $("#wiki_form_delimiter").val("comma");
                    $("#delimiter").show();
                    $('#import_url_iframe').hide();
                    $('#content-type').html('<h3>This is a csv file</h3>');

                    var array_data = CSVToArray(data[1], ",");

                    var table = document.createElement('table');
                    table.border = '1';

                    for (var i = 0; i < array_data.length; i++) {
                        var line = array_data[i];
                        var tr = document.createElement('tr');
                        for (var j = 0; j < line.length; j++) {
                            var td = document.createElement('td');
                            td.innerHTML = line[j];
                            tr.appendChild(td);
                            table.appendChild(tr);
                        }
                    }
                    $('#content-type').append(table);
                    $('#content-type').show();
                    $("#wiki_form_col_spec").val(data[2]);

                }

                else if (data[0] == "text/xls" || data[0] == "application/vnd.ms-excel")
                {
                    $("#wiki_form_parser_name").val("xls");
                    $("#wiki_form_which_sheet").val("0");
                    $("#which_sheet").show();
                    $('#import_url_iframe').hide();
                    $('#content-type').html('<h3>This is a  xls file</h3>');

                    var array_data = CSVToArray(data[1], ",");

                    var table = document.createElement('table');
                    table.border = '1';

                    for (var i = 0; i < array_data.length; i++) {
                        var line = array_data[i];
                        var tr = document.createElement('tr');
                        for (var j = 0; j < line.length; j++) {
                            var td = document.createElement('td');
                            td.innerHTML = line[j];
                            tr.appendChild(td);
                            table.appendChild(tr);
                        }
                    }

                    $('#content-type').append(table);
                    $('#content-type').show();
                    $("#wiki_form_col_spec").val(data[2]);

                }

                else if (data[0] == "text/xlsx")
                {
                    $("#wiki_form_parser_name").val("xlsx");
                    $("#which_sheet").show();

                }

            }).fail(function () {
                alert("failed AJAX call");
            });
    });

    $("#wiki_form_parser_name").change(function(){
        if ($("#wiki_form_parser_name").val()=="csv") {
        $("#criteria").hide();
        $("#which_table").hide();
        $("#which_sheet").hide();
        $("#delimiter").show();
        }
    else if ($("#wiki_form_parser_name").val()=="html"){
        $("#delimiter").hide();
        $("#which_sheet").hide();
        $("#which_table").show();
        $("#criteria").show();
        }
    else if ($("#wiki_form_parser_name").val()=="xls" || $("#wiki_form_parser_name").val()=="xlsx"){
        $("#delimiter").hide();
        $("#criteria").hide();
        $("#which_table").hide();
        $("#which_sheet").show();
        }
    });

    $('#strip_row').val($(this).is(':checked'));
    $('#strip_column').val($(this).is(':checked'));
    $('#transpose').val($(this).is(':checked'));
    $('#select_row').val($(this).is(':checked'));
    $('#select_column').val($(this).is(':checked'));
    $('#move_row').val($(this).is(':checked')) ;
    $('#move_column').val($(this).is(':checked')) ;
    $('#strip_until').val($(this).is(':checked'))  ;



    $('#strip_row').change(function() {
        if ( $('#strip_row').val($(this).is(':checked'))){

        $("#from_row").show();
        $("#to_row").show();

        }

        if ( $('#strip_row').val() == "false"){

        $("#from_row").hide();
        $("#to_row").hide();

        }
    });

    $('#select_row').change(function() {
        if ( $('#select_row').val($(this).is(':checked'))){
            $("#select_from_row").show();
            $("#select_to_row").show();

        }

        if ( $('#select_row').val() == "false"){
            $("#select_from_row").hide();
            $("#select_to_row").hide();

        }
    });

    $('#move_row').change(function() {
        if ( $('#move_row').val($(this).is(':checked'))){
            $("#move_from_row").show();
            $("#move_to_row").show();

        }

        if ( $('#move_row').val() == "false"){
            $("#move_from_row").hide();
            $("#move_to_row").hide();

        }
    });

    $('#strip_column').change(function() {
        if ( $('#strip_column').val($(this).is(':checked'))){
        $("#from_col").show();
        $("#to_col").show();

        }

    if ( $('#strip_column').val() == "false"){
        $("#from_col").hide();
        $("#to_col").hide();

        }
    });

    $('#select_column').change(function() {
        if ( $('#select_column').val($(this).is(':checked'))){
            $("#select_from_col").show();
            $("#select_to_col").show();

        }

        if ( $('#select_column').val() == "false"){
            $("#select_from_col").hide();
            $("#select_to_col").hide();

        }
    });

    $('#move_column').change(function() {
        if ( $('#move_column').val($(this).is(':checked'))){
            $("#from_col").show();
            $("#to_col").show();

        }

        if ( $('#move_column').val() == "false"){
            $("#from_col").hide();
            $("#to_col").hide();

        }
    });

    $('#transpose').change(function() {
        $('#transpose').val($(this).is(':checked'));
        });


    $('#strip_until').change(function() {
        if ( $('#strip_until').val($(this).is(':checked'))){
        $("#match").show();
        $("#strip_from").show();

        }

    if ( $('#strip_until').val() == "false"){
        $("#match").hide();
        $("#strip_from").hide();

        }
    });

    // This will parse a delimited string into an array of
// arrays. The default delimiter is the comma, but this
// can be overriden in the second argument.


    function CSVToArray(strData, strDelimiter) {
        // Check to see if the delimiter is defined. If not,
        // then default to comma.
        strDelimiter = (strDelimiter || ",");

        // Create a regular expression to parse the CSV values.
        var objPattern = new RegExp((
            // Delimiters.
            "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +

                // Quoted fields.
                "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +

                // Standard fields.
                "([^\"\\" + strDelimiter + "\\r\\n]*))"), "gi");


        // Create an array to hold our data. Give the array
        // a default empty first row.
        var arrData = [[]];

        // Create an array to hold our individual pattern
        // matching groups.
        var arrMatches = null;


        // Keep looping over the regular expression matches
        // until we can no longer find a match.
        while (arrMatches = objPattern.exec(strData)) {

            // Get the delimiter that was found.
            var strMatchedDelimiter = arrMatches[1];

            // Check to see if the given delimiter has a length
            // (is not the start of string) and if it matches
            // field delimiter. If id does not, then we know
            // that this delimiter is a row delimiter.
            if (
                strMatchedDelimiter.length && (strMatchedDelimiter != strDelimiter)) {

                // Since we have reached a new row of data,
                // add an empty row to our data array.
                arrData.push([]);

            }


            // Now that we have our delimiter out of the way,
            // let's check to see which kind of value we
            // captured (quoted or unquoted).
            if (arrMatches[2]) {

                // We found a quoted value. When we capture
                // this value, unescape any double quotes.
                var strMatchedValue = arrMatches[2].replace(
                    new RegExp("\"\"", "g"), "\"");

            } else {

                // We found a non-quoted value.
                var strMatchedValue = arrMatches[3];

            }


            // Now that we have our value string, let's add
            // it to the data array.
            arrData[arrData.length - 1].push(strMatchedValue);
        }

        // Return the parsed data.
        return (arrData);
    }
    });