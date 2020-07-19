<?php

require_once ('../../DTO/BaseDTO.php');

class PlanManejoFumigacionPotreroDTO extends BaseDTO {

    private $id;
    private $idplanfumigacion;
    private $idpotrero;
    private $fecha;
    private $observaciones;
    private $idresponsable;
    private $ejecutado;


    function __construct($id, $idplanfumigacion, $idpotrero, $fecha, $observaciones, $idresponsable, $ejecutado) {
        $this->id = $id;
        $this->idplanfumigacion = $idplanfumigacion;
        $this->idpotrero = $idpotrero;
        $this->fecha = $fecha;
        $this->observaciones = $observaciones;
        $this->idresponsable = $idresponsable;
        $this->ejecutado = $ejecutado;
    }

    
    function getId() {
        return $this->id;
    }

    function getIdplanfumigacion() {
        return $this->idplanfumigacion;
    }

    function getIdpotrero() {
        return $this->idpotrero;
    }

    function getFecha() {
        return $this->fecha;
    }

    function getObservaciones() {
        return $this->observaciones;
    }

    function getIdresponsable() {
        return $this->idresponsable;
    }

    function getEjecutado() {
        return $this->ejecutado;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setIdplanfumigacion($idplanfumigacion) {
        $this->idplanfumigacion = $idplanfumigacion;
    }

    function setIdpotrero($idpotrero) {
        $this->idpotrero = $idpotrero;
    }

    function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    function setObservaciones($observaciones) {
        $this->observaciones = $observaciones;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }

    function setEjecutado($ejecutado) {
        $this->ejecutado = $ejecutado;
    }


}
