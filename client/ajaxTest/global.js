/*Funktio joka palauttaa käyttämällä connect.php tiedostoa esityksen
tietokannan hakutuloksesta. */
function mp_GetData() {
    $.ajax({
        type: "POST",
        url: "Default.aspx/GetData",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, sStatus, sErrorThrown) {
            alert( 'data:  ' + sErrorThrown);
            alert( 'Get Data Error:  ' + sStatus);
        },
        success: function (data) {
            $("#oTable").empty();
            var oTable = data.d;
            for (i = 0; i <= oTable.Rows.length - 1; i++) {
                $("#oTable").append("<tr><td>" + oTable.Rows[i].lTaskID + "</td><td>" + oTable.Rows[i].sDescription + "</td><td>" + new Date(parseInt(oTable.Rows[i].dtStartDate.substr(6))) + "</td><td>" + new Date(parseInt(oTable.Rows[i].dtEndDate.substr(6))) + "</td></tr>");
            }
        }
    });
}