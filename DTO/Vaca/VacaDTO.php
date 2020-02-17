<?php

require_once ('../../DTO/BaseDTO.php');

class VacaDTO extends BaseDTO {
    
    private $id;
    private $numero;
    private $nombre;
    private $idRotacion;
    private $sexo;
    private $raza;
    private $tipoanimal;
    private $edad;
    private $idresponsable;
    
    function __construct($id, $numero, $nombre, $idRotacion, $sexo, $raza, $tipoanimal, $edad, $idresponsable) {
        $this->id = $id;
        $this->numero = $numero;
        $this->nombre = $nombre;
        $this->idRotacion = $idRotacion;
        $this->sexo = $sexo;
        $this->raza = $raza;
        $this->tipoanimal = $tipoanimal;
        $this->edad = $edad;
        $this->idresponsable = $idresponsable;
    }
    
    
    function getId() {
        return $this->id;
    }

    function getNumero() {
        return $this->numero;
    }

    function getNombre() {
        return $this->nombre;
    }

    function getIdRotacion() {
        return $this->idRotacion;
    }

    function getSexo() {
        return $this->sexo;
    }

    function getRaza() {
        return $this->raza;
    }

    function getTipoanimal() {
        return $this->tipoanimal;
    }

    function getEdad() {
        return $this->edad;
    }

    function getIdresponsable() {
        return $this->idresponsable;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setNumero($numero) {
        $this->numero = $numero;
    }

    function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    function setIdRotacion($idRotacion) {
        $this->idRotacion = $idRotacion;
    }

    function setSexo($sexo) {
        $this->sexo = $sexo;
    }

    function setRaza($raza) {
        $this->raza = $raza;
    }

    function setTipoanimal($tipoanimal) {
        $this->tipoanimal = $tipoanimal;
    }

    function setEdad($edad) {
        $this->edad = $edad;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }



    
}