<?php

require_once ('../../DTO/BaseDTO.php');

class RotacionesDTO extends BaseDTO {
    
    private $id;
    private $nombre;
    private $cantvacas;
    private $idresponsable;
    private $caracter;
    
    function __construct($id, $nombre, $cantvacas, $idresponsable, $caracter) {
        $this->id = $id;
        $this->nombre = $nombre;
        $this->cantvacas = $cantvacas;
        $this->idresponsable = $idresponsable;
        $this->caracter = $caracter;
    }
    function getId() {
        return $this->id;
    }

    function getNombre() {
        return $this->nombre;
    }

    function getCantvacas() {
        return $this->cantvacas;
    }

    function getIdresponsable() {
        return $this->idresponsable;
    }

    function getCaracter() {
        return $this->caracter;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    function setCantvacas($cantvacas) {
        $this->cantvacas = $cantvacas;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }

    function setCaracter($caracter) {
        $this->caracter = $caracter;
    }

}
