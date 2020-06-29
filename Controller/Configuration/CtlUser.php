<?php

/* IMPORTS */
include '../../Infraestructure/CORS.php';
require '../../DTO/Configuration/UserDTO.php';
require '../../DAO/Configuration/UserDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Cleaner.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$firstName = getInfo('primerNombre');
$secondName = getInfo('segundoNombre');
$firstLastName = getInfo('primerApellido');
$secondLastName = getInfo('segundoApellido');


$cedula = getInfo('cedula');
$correo = getInfo('correo');
$celular = getInfo('celular');

$user = getInfo('usuario');
$password = getInfo('password');
$rol = getInfo('rolId');
$description = getInfo('descripcion');


/*Codificacion a base64*/
$foto = getInfo('foto');
/*Se indica si se modifico foto*/
$seActualizoFoto = getInfo('seActualizoFoto');
/*Ruta de la imagen previa por si se edito, o de la ruta actual para eliminar*/
$fotoCopiaRutaOriginal = getInfo('fotoCopiaRutaOriginal');



/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /*Si voy a guardar y me mandaron una imagen*/
    if ($action === 'save' && $foto != null && $foto != "") {
        /* Se crean las imagenes que se tengan que crear */
        $fotoGenerada = generateFiles('', '../../', '', 'Resource/Images/Users/', 1, $user, '.jpg', false);

        if ($fotoGenerada != null && $fotoGenerada != "") {
            $foto = $fotoGenerada;
        }
    }

    if ($action === 'update') {
        if ($seActualizoFoto === 'true') {
            // echo 'SI ES UPDATE Y ADEMAS SI SE ACTUALIZO LA FOTO';
            /* Se borran todas las imagenes que se tengan que eliminar */
            deleteFiles('', '../../', '', '', 1, '', false, '');
            /* Se crean las imagenes que se tengan que crear */
            $fotoGenerada = generateFiles('', '../../', '', 'Resource/Images/Users/', 1, $user, '.jpg', false);

            if ($fotoGenerada != null && $fotoGenerada != "") {
                $foto = $fotoGenerada;
            }
        } else {
            // echo 'SI ES UPDATE PERO NO SE ACTUALIZO LA MALDITA FOTO, EL VALOR DE LO QUE QUEDARA EN FOTO ES '.$fotoCopiaRutaOriginal;
            $foto = $fotoCopiaRutaOriginal;
        }
    }


    if ($action === 'delete') {
        deleteFiles('', '../../', '', '', 1, '', false, '');
    }



    /* DEFINICION DE OBJETOS */
    $obj = new UserDTO($id, $firstName, $secondName, $firstLastName, $secondLastName, $cedula, $correo, $celular, $foto, $user, $password, $rol, $description);
    $dao = new UserDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}
