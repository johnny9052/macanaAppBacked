<?php

require_once ('../../DTO/BaseDTO.php');

class AforoDTO extends BaseDTO {

    private $id;
    private $fecha;
    private $idpotrero;
    private $pastoalto;
    private $pastobajo;
    private $pastomedio;
    private $lancealto;
    private $lancemedio;
    private $lancebajo;
    private $cantlances;
    private $pesopastoalto;
    private $pesopastobajo;
    private $pesopastomedio;
    private $cantpasto;
    private $porcentajealtro;
    private $porcentajemedio;
    private $porcentajebajo;
    private $totalmetrocuadrado;
    private $cantpastopotrero;
    private $tiempopotrero;
    private $observaciones;
    private $idresponsable;
    private $fechaentrada;
    private $fechasalida;
    private $caracter;
    
    function __construct($id, $fecha, $idpotrero, $pastoalto, $pastobajo, $pastomedio, $lancealto, $lancemedio, $lancebajo, $cantlances, $pesopastoalto, $pesopastobajo, $pesopastomedio, $cantpasto, $porcentajealtro, $porcentajemedio, $porcentajebajo, $totalmetrocuadrado, $cantpastopotrero, $tiempopotrero, $observaciones, $idresponsable, $fechaentrada, $fechasalida, $caracter) {
        $this->id = $id;
        $this->fecha = $fecha;
        $this->idpotrero = $idpotrero;
        $this->pastoalto = $pastoalto;
        $this->pastobajo = $pastobajo;
        $this->pastomedio = $pastomedio;
        $this->lancealto = $lancealto;
        $this->lancemedio = $lancemedio;
        $this->lancebajo = $lancebajo;
        $this->cantlances = $cantlances;
        $this->pesopastoalto = $pesopastoalto;
        $this->pesopastobajo = $pesopastobajo;
        $this->pesopastomedio = $pesopastomedio;
        $this->cantpasto = $cantpasto;
        $this->porcentajealtro = $porcentajealtro;
        $this->porcentajemedio = $porcentajemedio;
        $this->porcentajebajo = $porcentajebajo;
        $this->totalmetrocuadrado = $totalmetrocuadrado;
        $this->cantpastopotrero = $cantpastopotrero;
        $this->tiempopotrero = $tiempopotrero;
        $this->observaciones = $observaciones;
        $this->idresponsable = $idresponsable;
        $this->fechaentrada = $fechaentrada;
        $this->fechasalida = $fechasalida;
        $this->caracter = $caracter;
    }

    function getId() {
        return $this->id;
    }

    function getFecha() {
        return $this->fecha;
    }

    function getIdpotrero() {
        return $this->idpotrero;
    }

    function getPastoalto() {
        return $this->pastoalto;
    }

    function getPastobajo() {
        return $this->pastobajo;
    }

    function getPastomedio() {
        return $this->pastomedio;
    }

    function getLancealto() {
        return $this->lancealto;
    }

    function getLancemedio() {
        return $this->lancemedio;
    }

    function getLancebajo() {
        return $this->lancebajo;
    }

    function getCantlances() {
        return $this->cantlances;
    }

    function getPesopastoalto() {
        return $this->pesopastoalto;
    }

    function getPesopastobajo() {
        return $this->pesopastobajo;
    }

    function getPesopastomedio() {
        return $this->pesopastomedio;
    }

    function getCantpasto() {
        return $this->cantpasto;
    }

    function getPorcentajealtro() {
        return $this->porcentajealtro;
    }

    function getPorcentajemedio() {
        return $this->porcentajemedio;
    }

    function getPorcentajebajo() {
        return $this->porcentajebajo;
    }

    function getTotalmetrocuadrado() {
        return $this->totalmetrocuadrado;
    }

    function getCantpastopotrero() {
        return $this->cantpastopotrero;
    }

    function getTiempopotrero() {
        return $this->tiempopotrero;
    }

    function getObservaciones() {
        return $this->observaciones;
    }

    function getIdresponsable() {
        return $this->idresponsable;
    }

    function getFechaentrada() {
        return $this->fechaentrada;
    }

    function getFechasalida() {
        return $this->fechasalida;
    }

    function getCaracter() {
        return $this->caracter;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    function setIdpotrero($idpotrero) {
        $this->idpotrero = $idpotrero;
    }

    function setPastoalto($pastoalto) {
        $this->pastoalto = $pastoalto;
    }

    function setPastobajo($pastobajo) {
        $this->pastobajo = $pastobajo;
    }

    function setPastomedio($pastomedio) {
        $this->pastomedio = $pastomedio;
    }

    function setLancealto($lancealto) {
        $this->lancealto = $lancealto;
    }

    function setLancemedio($lancemedio) {
        $this->lancemedio = $lancemedio;
    }

    function setLancebajo($lancebajo) {
        $this->lancebajo = $lancebajo;
    }

    function setCantlances($cantlances) {
        $this->cantlances = $cantlances;
    }

    function setPesopastoalto($pesopastoalto) {
        $this->pesopastoalto = $pesopastoalto;
    }

    function setPesopastobajo($pesopastobajo) {
        $this->pesopastobajo = $pesopastobajo;
    }

    function setPesopastomedio($pesopastomedio) {
        $this->pesopastomedio = $pesopastomedio;
    }

    function setCantpasto($cantpasto) {
        $this->cantpasto = $cantpasto;
    }

    function setPorcentajealtro($porcentajealtro) {
        $this->porcentajealtro = $porcentajealtro;
    }

    function setPorcentajemedio($porcentajemedio) {
        $this->porcentajemedio = $porcentajemedio;
    }

    function setPorcentajebajo($porcentajebajo) {
        $this->porcentajebajo = $porcentajebajo;
    }

    function setTotalmetrocuadrado($totalmetrocuadrado) {
        $this->totalmetrocuadrado = $totalmetrocuadrado;
    }

    function setCantpastopotrero($cantpastopotrero) {
        $this->cantpastopotrero = $cantpastopotrero;
    }

    function setTiempopotrero($tiempopotrero) {
        $this->tiempopotrero = $tiempopotrero;
    }

    function setObservaciones($observaciones) {
        $this->observaciones = $observaciones;
    }

    function setIdresponsable($idresponsable) {
        $this->idresponsable = $idresponsable;
    }

    function setFechaentrada($fechaentrada) {
        $this->fechaentrada = $fechaentrada;
    }

    function setFechasalida($fechasalida) {
        $this->fechasalida = $fechasalida;
    }

    function setCaracter($caracter) {
        $this->caracter = $caracter;
    }
}
