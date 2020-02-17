<?php

require_once ('../../DTO/BaseDTO.php');

class RotacionesDTO extends BaseDTO {
    
    private $id;
    private $nombre;
    private $cantvacas;
    private $idresponsable;

    
    function __construct($id, $nombre, $cantvacas, $idresponsable) {
        $this->id = $id;
        $this->nombre = $nombre;
        $this->cantvacas = $cantvacas;
        $this->idresponsable = $idresponsable;
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




}
