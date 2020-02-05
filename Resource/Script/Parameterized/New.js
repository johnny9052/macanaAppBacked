/* Funciones jQuery */
$(window).on("load", function (e) {
    list();
});

function save() {
    if (validateForm() === true) {

        /*Se seleccionan los campos de fecha que se tengan disponibles*/
        var inputFile = $('input[type="file"]');
        var file = inputFile[0].files[0];

        /*Si existen campos de fecha con archivos cargados*/
        if (file !== undefined) {

            /*Convierte la imagen seleccionada a BASE64*/
            base64($('input[type="file"]'), function (data) {
                /*Se añade la imagen como campo adicional*/
                var plusImagen = new Array();
                plusImagen.push("imagen");
                plusImagen.push((data.base64 !== undefined) ? data.base64 : ""); // prints the base64 string                                

                Execute(scanInfo('save', true, '', [{datos: plusImagen}]), 'Parameterized/CtlNew', '', 'closeWindow();list();');
            });
        } else {/*Si no se encontraron imagenes para cargar*/
            var plusImagen = new Array();
            plusImagen.push("imagen");
            plusImagen.push(""); // prints the base64 string
            Execute(scanInfo('save', true, '', [{datos: plusImagen}]), 'Parameterized/CtlNew', '', 'closeWindow();list();');
        }


    }
}

function list() {
    Execute(scanInfo('listfilter'), 'Parameterized/CtlNew', '', 'buildPaginator(info);');
}


function search(id) {
    $("#txtId").val(id);
    Execute(scanInfo('search', true), 'Parameterized/CtlNew', '', 'showData(info);');
}


function showData(info) {    
    $("#txtId").val(info[0].id);
    $("#txtTitulo").val(info[0].titulo);
    $("#txtDescription").val(info[0].descripcion);    
    
    $("#txtFecha").val(info[0].fecha);
    $("#lblImagenPrevia").html(info[0].foto);
    $("#txtVideo").val(info[0].video);

    openWindow();
    showButton(false);
}


function update() {
    if (validateForm() === true) {

        /*Se seleccionan los campos de fecha que se tengan disponibles*/
        var inputFile = $('input[type="file"]');
        var file = inputFile[0].files[0];
        /*Si existen campos de fecha con archivos cargados*/
        if (file !== undefined) {
            /*Convierte la imagen seleccionada a BASE64*/
            base64($('input[type="file"]'), function (data) {
                /*Se añade la imagen como campo adicional*/
                var plusImagen = new Array();
                plusImagen.push("imagen");
                plusImagen.push((data.base64 !== undefined) ? data.base64 : ""); // prints the base64 string

                /*Se manda una imagen previa seleccionada*/
                plusImagen.push("imagenPrevia");
                plusImagen.push($("#lblImagenPrevia").html());


                Execute(scanInfo('update', true, '', [{datos: plusImagen}]), 'Parameterized/CtlNew', '', 'closeWindow();list();');
            });
        } else {
            var plusImagen = new Array();
            plusImagen.push("imagen");
            plusImagen.push(""); // prints the base64 string

            //Se manda una imagen previa seleccionada
            plusImagen.push("imagenPrevia");
            plusImagen.push($("#lblImagenPrevia").html());


            Execute(scanInfo('update', true, '', [{datos: plusImagen}]), 'Parameterized/CtlNew', '', 'closeWindow();list();');
        }


    }
}


function deleteInfo() {
    if (validateForm() === true) {
        var plusImagen = new Array();
        /*Se manda una imagen previa seleccionada, la cual sera tambien eliminada*/
        plusImagen.push("imagenPrevia");
        plusImagen.push($("#lblImagenPrevia").html());
        Execute(scanInfo('delete', true, '', [{datos: plusImagen}]), 'Parameterized/CtlNew', '', 'closeWindow("ModalConfirm");list();cleanForm("ModalNew");');
    }
}
