<?php

require_once ('../../DTO/BaseDTO.php');

class ClimatologicoDTO extends BaseDTO {

    private $id;
    private $fecha;
    private $nubosidad;
    private $pluviometria;
    private $observaciones;
    private $idresponsable;
    private $caracter;
    
    function __construct($id, $fecha, $nubosidad, $pluviometria, $observaciones, $idresponsable, $caracter) {
        $this->id = $id;
        $this->fecha = $fecha;
        $this->nubosidad = $nubosidad;
        $this->pluviometria = $pluviometria;
        $this->observaciones = $observaciones;
        $this->idresponsable = $idresponsable;
        $this->caracter = $caracter;
    }
    
    function getId() {
        return $this->id;
    }

    function getFecha() {
        return $this->fecha;
    }

    function getNubosidad() {
        return $this->nubosidad;
    }

    function getPluviometria() {
        return $this->pluviometria;
    }

    function getObservaciones() {
        return $this->observaciones;
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

    function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    function setNubosidad($nubosidad) {
        $this->nubosidad = $nubosidad;
    }

    function setPluviometria($pluviometria) {
        $this->pluviometria = $pluviometria;
    }

    function setObservaciones($observaciones) {
        $this->observaciones = $observaciones;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }

    function setCaracter($caracter) {
        $this->caracter = $caracter;
    }
      
}
