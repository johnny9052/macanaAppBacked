<?php

require_once ('../../DTO/BaseDTO.php');

class UserDTO extends BaseDTO {

    private $id;
    private $firstName;
    private $secondName;
    private $firstLastName;
    private $secondLastName;
    private $cedula;
    private $correo;
    private $celular;
    private $foto;
    private $user;
    private $password;
    private $rol;
    private $description;

    function __construct($id, $firstName, $secondName, $firstLastName, $secondLastName, $cedula, $correo, $celular, $foto, $user, $password, $rol, $description) {
        $this->id = $id;
        $this->firstName = $firstName;
        $this->secondName = $secondName;
        $this->firstLastName = $firstLastName;
        $this->secondLastName = $secondLastName;
        $this->cedula = $cedula;
        $this->correo = $correo;
        $this->celular = $celular;
        $this->foto = $foto;
        $this->user = $user;
        $this->password = $password;
        $this->rol = $rol;
        $this->description = $description;
    }

    function getId() {
        return $this->id;
    }

    function getFirstName() {
        return $this->firstName;
    }

    function getSecondName() {
        return $this->secondName;
    }

    function getFirstLastName() {
        return $this->firstLastName;
    }

    function getSecondLastName() {
        return $this->secondLastName;
    }

    function getUser() {
        return $this->user;
    }

    function getPassword() {
        return $this->password;
    }

    function getRol() {
        return $this->rol;
    }

    function getDescription() {
        return $this->description;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setFirstName($firstName) {
        $this->firstName = $firstName;
    }

    function setSecondName($secondName) {
        $this->secondName = $secondName;
    }

    function setFirstLastName($firstLastName) {
        $this->firstLastName = $firstLastName;
    }

    function setSecondLastName($secondLastName) {
        $this->secondLastName = $secondLastName;
    }
    
    
    
    
    function getCedula() {
        return $this->cedula;
    }

    function getCorreo() {
        return $this->correo;
    }

    function getCelular() {
        return $this->celular;
    }

    function getFoto() {
        return $this->foto;
    }

    function setCedula($cedula) {
        $this->cedula = $cedula;
    }

    function setCorreo($correo) {
        $this->correo = $correo;
    }

    function setCelular($celular) {
        $this->celular = $celular;
    }

    function setFoto($foto) {
        $this->foto = $foto;
    }

        

    function setUser($user) {
        $this->user = $user;
    }

    function setPassword($password) {
        $this->password = $password;
    }

    function setRol($rol) {
        $this->rol = $rol;
    }

    function setDescription($description) {
        $this->description = $description;
    }

}
