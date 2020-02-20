<?php

require_once ('../../DTO/BaseDTO.php');

class PotreroDTO extends BaseDTO {
    
    private $id;
    private $numero;
    private $area;
    private $observacion;
    private $idrotacion;
    private $idresponsable;
    
    function __construct($id, $numero, $area, $observacion, $idrotacion, $idresponsable) {
        $this->id = $id;
        $this->numero = $numero;
        $this->area = $area;
        $this->observacion = $observacion;
        $this->idrotacion = $idrotacion;
        $this->idresponsable = $idresponsable;
    }
    
    function getId() {
        return $this->id;
    }

    function getNumero() {
        return $this->numero;
    }

    function getArea() {
        return $this->area;
    }

    function getObservacion() {
        return $this->observacion;
    }

    function getIdrotacion() {
        return $this->idrotacion;
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

    function setArea($area) {
        $this->area = $area;
    }

    function setObservacion($observacion) {
        $this->observacion = $observacion;
    }

    function setIdrotacion($idrotacion) {
        $this->idrotacion = $idrotacion;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }

}
