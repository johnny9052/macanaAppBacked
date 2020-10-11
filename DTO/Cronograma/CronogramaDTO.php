<?php

require_once ('../../DTO/BaseDTO.php');

class CronogramaDTO extends BaseDTO {
    
    private $id;
    private $idactividad;
    private $fechaProgramada;
    private $fechaEjecutada;
    private $idPotrero;
    private $idResponsable;
    private $ejecutado;
    private $caracter;
    
    function __construct($id, $idactividad, $fechaProgramada, $fechaEjecutada, $idPotrero, $idResponsable, $ejecutado, $caracter) {
        $this->id = $id;
        $this->idactividad = $idactividad;
        $this->fechaProgramada = $fechaProgramada;
        $this->fechaEjecutada = $fechaEjecutada;
        $this->idPotrero = $idPotrero;
        $this->idResponsable = $idResponsable;
        $this->ejecutado = $ejecutado;
        $this->caracter = $caracter;
    }
    function getId() {
        return $this->id;
    }

    function getIdactividad() {
        return $this->idactividad;
    }

    function getFechaProgramada() {
        return $this->fechaProgramada;
    }

    function getFechaEjecutada() {
        return $this->fechaEjecutada;
    }

    function getIdPotrero() {
        return $this->idPotrero;
    }

    function getIdResponsable() {
        return $this->idResponsable;
    }

    function getEjecutado() {
        return $this->ejecutado;
    }

    function getCaracter() {
        return $this->caracter;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setIdactividad($idactividad) {
        $this->idactividad = $idactividad;
    }

    function setFechaProgramada($fechaProgramada) {
        $this->fechaProgramada = $fechaProgramada;
    }

    function setFechaEjecutada($fechaEjecutada) {
        $this->fechaEjecutada = $fechaEjecutada;
    }

    function setIdPotrero($idPotrero) {
        $this->idPotrero = $idPotrero;
    }

    function setIdResponsable($idResponsable) {
        $this->idResponsable = $idResponsable;
    }

    function setEjecutado($ejecutado) {
        $this->ejecutado = $ejecutado;
    }

    function setCaracter($caracter) {
        $this->caracter = $caracter;
    }


}
