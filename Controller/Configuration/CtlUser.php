<?php

/* IMPORTS */
require '../../DTO/Configuration/UserDTO.php';
require '../../DAO/Configuration/UserDAO.php';
include '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

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
$foto = (isset($_POST['']) ? $_POST[''] : "");


$user = (isset($_POST['usuario']) ? $_POST['usuario'] : "");
$password = (isset($_POST['password']) ? $_POST['password'] : "");
$rol = (isset($_POST['rolId']) ? $_POST['rolId'] : "");
$description = (isset($_POST['descripcion']) ? $_POST['descripcion'] : "");

/* DEFINICION DE OBJETOS */
$obj = new UserDTO($id, $firstName, $secondName, $firstLastName, $secondLastName, $cedula, $correo, $celular, $foto, $user, $password, $rol, $description);
$dao = new UserDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


