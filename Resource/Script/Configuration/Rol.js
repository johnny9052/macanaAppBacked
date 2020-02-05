/* Funciones jQuery */
$(window).on("load", function (e) {
    list();    
});

function save() {
    if (validateForm() === true) {
        Execute(scanInfo('save', true), 'Configuration/CtlRol', '', 'closeWindow();list();');
    }
}

function list() {
    Execute(scanInfo('listfilter'), 'Configuration/CtlRol', '', 'buildPaginator(info);');
}


function search(id) {
    $("#txtId").val(id);
    Execute(scanInfo('search', true), 'Configuration/CtlRol', '', 'showData(info);');
}


function showData(info) {
    $("#txtId").val(info[0].id);
    $("#txtName").val(info[0].nombre);
    $("#txtDescription").val(info[0].descripcion);
    openWindow();
    showButton(false);
}


function update() {
    if (validateForm() === true) {
        Execute(scanInfo('update', true), 'Configuration/CtlRol', '', 'closeWindow();list();');
    }
}


function deleteInfo() {
    if (validateForm() === true) {
        Execute(scanInfo('delete', true), 'Configuration/CtlRol', '', 'closeWindow("ModalConfirm");list();cleanForm("ModalNew");');
    }
}
