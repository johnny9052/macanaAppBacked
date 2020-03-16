<?php

require_once ('../../DTO/BaseDTO.php');

class PresentacionDTO extends BaseDTO {
    
    private $id;
    private $nombre;
    private $observacion;
    function __construct($id, $nombre, $observacion) {
        $this->id = $id;
        $this->nombre = $nombre;
        $this->observacion = $observacion;
    }
    function getId() {
        return $this->id;
    }

    function getNombre() {
        return $this->nombre;
    }

    function getObservacion() {
        return $this->observacion;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    function setObservacion($observacion) {
        $this->observacion = $observacion;
    }


}
