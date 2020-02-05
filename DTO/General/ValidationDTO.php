<?php

require_once ('../../DTO/BaseDTO.php');

class ValidationDTO extends BaseDTO {

    private $id;

    public function __Construct($id) {
        $this->id = $id;
    }

    /**
     * Retorna el ID de busqueda y filtro para el llenado del select
     * @return int (Si retorna -2 es que no tiene campo de busqueda y traera
     *  todos los datos)
     * @author Johnny Alexander Salazar
     * @version 0.2
     */
    function getId() {
        return ($this->id == null || $this->id == "") ? -1 : $this->id;
    }

    function setId($Id) {
        $this->id = $Id;
    }

}
