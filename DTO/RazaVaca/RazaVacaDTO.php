<?php

require_once ('../../DTO/BaseDTO.php');

class RazaVacaDTO extends BaseDTO {
    
    private $id;
    private $nombre;
    private $observaciones;
    
    function __construct($id, $nombre, $observaciones) {
        $this->id = $id;
        $this->nombre = $nombre;
        $this->observaciones = $observaciones;
    }
    function getId() {
        return $this->id;
    }

    function getNombre() {
        return $this->nombre;
    }

    function getObservaciones() {
        return $this->observaciones;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    function setObservaciones($observaciones) {
        $this->observaciones = $observaciones;
    }


}
