<?php

require_once ('../../DTO/BaseDTO.php');

class PlanManejoFertilizacionFertilizanteDTO extends BaseDTO {

    private $id;
    private $idplanfertilizacion;
    private $idfertilizante;
    private $cantidad;
    private $idresponsable;
    
    function __construct($id, $idplanfertilizacion, $idfertilizante, $cantidad, $idresponsable) {
        $this->id = $id;
        $this->idplanfertilizacion = $idplanfertilizacion;
        $this->idfertilizante = $idfertilizante;
        $this->cantidad = $cantidad;
        $this->idresponsable = $idresponsable;
    }
    
    
    function getId() {
        return $this->id;
    }

    function getIdplanfertilizacion() {
        return $this->idplanfertilizacion;
    }

    function getIdfertilizacion() {
        return $this->idfertilizante;
    }

    function getCantidad() {
        return $this->cantidad;
    }

    function getIdresponsable() {
        return $this->idresponsable;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setIdplanfertilizacion($idplanfertilizacion) {
        $this->idplanfertilizacion = $idplanfertilizacion;
    }

    function setIdfertilizacion($idfertilizante) {
        $this->idfertilizante = $idfertilizante;
    }

    function setCantidad($cantidad) {
        $this->cantidad = $cantidad;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }




    
}
