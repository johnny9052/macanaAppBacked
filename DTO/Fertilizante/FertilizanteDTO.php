<?php

require_once ('../../DTO/BaseDTO.php');

class FertilizanteDTO extends BaseDTO {
    
    private $id;
    private $nombre;
    private $marca;
    private $idpresentacion;
    private $idresponsable;
    
    function __construct($id, $nombre, $marca, $idpresentacion, $idresponsable) {
        $this->id = $id;
        $this->nombre = $nombre;
        $this->marca = $marca;
        $this->idpresentacion = $idpresentacion;
        $this->idresponsable = $idresponsable;
    }

    function getId() {
        return $this->id;
    }

    function getNombre() {
        return $this->nombre;
    }

    function getMarca() {
        return $this->marca;
    }

    function getIdpresentacion() {
        return $this->idpresentacion;
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

    function setMarca($marca) {
        $this->marca = $marca;
    }

    function setIdpresentacion($idpresentacion) {
        $this->idpresentacion = $idpresentacion;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }

}
