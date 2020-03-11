<?php

/* IMPORTS */
include '../../Infraestructure/CORS.php';
require '../../DTO/Configuration/UserDTO.php';
require '../../DAO/Configuration/UserDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Cleaner.php';


/* RECEPCION DE DATOS */
$action = (isset($_REQUEST['action']) ? $_REQUEST['action'] : "");
$id = (isset($_POST['id']) ? $_POST['id'] : "");
$firstName = (isset($_POST['primerNombre']) ? $_POST['primerNombre'] : "");
$secondName = (isset($_POST['segundoNombre']) ? $_POST['segundoNombre'] : "");
$firstLastName = (isset($_POST['primerApellido']) ? $_POST['primerApellido'] : "");
$secondLastName = (isset($_POST['segundoApellido']) ? $_POST['segundoApellido'] : "");


$cedula = (isset($_POST['cedula']) ? $_POST['cedula'] : "");
$correo = (isset($_POST['correo']) ? $_POST['correo'] : "");
$celular = (isset($_POST['celular']) ? $_POST['celular'] : "");

$user = (isset($_POST['usuario']) ? $_POST['usuario'] : "");
$password = (isset($_POST['password']) ? $_POST['password'] : "");
$rol = (isset($_POST['rolId']) ? $_POST['rolId'] : "");
$description = (isset($_POST['descripcion']) ? $_POST['descripcion'] : "");


$foto = (isset($_POST['foto']) ? $_POST['foto'] : "");
$seActualizoFoto = (isset($_POST['seActualizoFoto']) ? $_POST['seActualizoFoto'] : "");
$fotoCopiaRutaOriginal = (isset($_POST['fotoCopiaRutaOriginal']) ? $_POST['fotoCopiaRutaOriginal'] : "");


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


if($action === 'delete'){
    deleteFiles('', '../../', '', '', 1, '', false, '');
}








/* DEFINICION DE OBJETOS */
$obj = new UserDTO($id, $firstName, $secondName, $firstLastName, $secondLastName, $cedula, $correo, $celular, $foto, $user, $password, $rol, $description);
$dao = new UserDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


