<?php

require_once ('../../DTO/BaseDTO.php');

class PlandemanejoDTO extends BaseDTO {
    
    private $id;
    private $fecha;
    private $nombre;
    private $idResponsable;
    private $observaciones;
    
    function __construct($id, $fecha, $nombre, $idResponsable, $observaciones) {
        $this->id = $id;
        $this->fecha = $fecha;
        $this->nombre = $nombre;
        $this->idResponsable = $idResponsable;
        $this->observaciones = $observaciones;
    }
    function getId() {
        return $this->id;
    }

    function getFecha() {
        return $this->fecha;
    }

    function getNombre() {
        return $this->nombre;
    }

    function getIdResponsable() {
        return $this->idResponsable;
    }

    function getObservaciones() {
        return $this->observaciones;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    function setIdResponsable($idResponsable) {
        $this->idResponsable = $idResponsable;
    }

    function setObservaciones($observaciones) {
        $this->observaciones = $observaciones;
    }

}