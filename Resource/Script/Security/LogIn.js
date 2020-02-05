/* Funciones jQuery */

$(window).on("load", function (e) {
    $("#txtUser").focus();
});


function activarViaEnter(e) {
    if (e.keyCode === 13) {
        LogIn();
    }
}

     
/* Identificar a un usuario del sistema */
function LogIn() {
    if (validateForm() === true) {
        Execute(scanInfo('', true), 'Security/CtlLogIn', '', 'location.reload();');
    }
}