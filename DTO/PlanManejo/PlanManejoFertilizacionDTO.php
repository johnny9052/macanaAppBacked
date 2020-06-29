<?php

require_once ('../../DTO/BaseDTO.php');

class PlanManejoFertilizacionDTO extends BaseDTO {

    private $id;
    private $nombre;
    private $fechainicio;
    private $descripcion;
    private $idresponsable;

    
    function __construct($id, $nombre, $fechainicio, $descripcion, $idresponsable) {
        $this->id = $id;
        $this->nombre = $nombre;
        $this->fechainicio = $fechainicio;
        $this->descripcion = $descripcion;
        $this->idresponsable = $idresponsable;
    }
    
    
    function getId() {
        return $this->id;
    }

    function getNombre() {
        return $this->nombre;
    }

    function getFechainicio() {
        return $this->fechainicio;
    }

    function getDescripcion() {
        return $this->descripcion;
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

    function setFechainicio($fechainicio) {
        $this->fechainicio = $fechainicio;
    }

    function setDescripcion($descripcion) {
        $this->descripcion = $descripcion;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }



  
}
