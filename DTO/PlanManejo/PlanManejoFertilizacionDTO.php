<?php

require_once ('../../DTO/BaseDTO.php');

class PlanManejoFertilizacionDTO extends BaseDTO {

    private $id;
    private $periodicidad;
    private $fechainicio;
    private $fechafin;
    private $descripcion;
    private $idresponsable;

    function __construct($id, $periodicidad, $fechainicio, $fechafin, $descripcion, $idresponsable) {
        $this->id = $id;
        $this->periodicidad = $periodicidad;
        $this->fechainicio = $fechainicio;
        $this->fechafin = $fechafin;
        $this->descripcion = $descripcion;
        $this->idresponsable = $idresponsable;
    }

    function getId() {
        return $this->id;
    }

    function getPeriodicidad() {
        return $this->periodicidad;
    }

    function getFechainicio() {
        return $this->fechainicio;
    }

    function getFechafin() {
        return $this->fechafin;
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

    function setPeriodicidad($periodicidad) {
        $this->periodicidad = $periodicidad;
    }

    function setFechainicio($fechainicio) {
        $this->fechainicio = $fechainicio;
    }

    function setFechafin($fechafin) {
        $this->fechafin = $fechafin;
    }

    function setDescripcion($descripcion) {
        $this->descripcion = $descripcion;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }

}
