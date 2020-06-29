<?php


require_once ('../../DTO/BaseDTO.php');

class PlanManejoFertilizacionPotreroConfiguracionDTO extends BaseDTO {

    private $idplanmanejo;
    private $idrotacion;
    private $idresponsable;
    
    
    function __construct($idplanmanejo, $idrotacion, $idresponsable) {
        $this->idplanmanejo = $idplanmanejo;
        $this->idrotacion = $idrotacion;
        $this->idresponsable = $idresponsable;
    }

    
    function getIdplanmanejo() {
        return $this->idplanmanejo;
    }

    function getIdrotacion() {
        return $this->idrotacion;
    }

    function getIdresponsable() {
        return $this->idresponsable;
    }

    function setIdplanmanejo($idplanmanejo) {
        $this->idplanmanejo = $idplanmanejo;
    }

    function setIdrotacion($idrotacion) {
        $this->idrotacion = $idrotacion;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }


    
}
