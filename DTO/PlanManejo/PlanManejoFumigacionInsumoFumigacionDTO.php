<?php

require_once ('../../DTO/BaseDTO.php');

class PlanManejoFumigacionInsumoFumigacionDTO extends BaseDTO {

    private $id;
    private $idplanfumigacion;
    private $idinsumofumigacion;
    private $cantidad;
    private $idresponsable;
    
    function __construct($id, $idplanfumigacion, $idinsumofumigacion, $cantidad, $idresponsable) {
        $this->id = $id;
        $this->idplanfumigacion = $idplanfumigacion;
        $this->idinsumofumigacion = $idinsumofumigacion;
        $this->cantidad = $cantidad;
        $this->idresponsable = $idresponsable;
    }
    
    
    function getId() {
        return $this->id;
    }

    function getIdplanfumigacion() {
        return $this->idplanfumigacion;
    }

    function getIdfumigacion() {
        return $this->idinsumofumigacion;
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

    function setIdplanfumigacion($idplanfumigacion) {
        $this->idplanfumigacion = $idplanfumigacion;
    }

    function setIdfumigacion($idinsumofumigacion) {
        $this->idinsumofumigacion = $idinsumofumigacion;
    }

    function setCantidad($cantidad) {
        $this->cantidad = $cantidad;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }




    
}
