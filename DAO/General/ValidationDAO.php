<?php

/**
 * Definicion de acciones generales del sistema, como selects, etc.
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class ValidationDAO {

    private $repository;

    function ValidationDAO() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta una consulta que sera cargado como foranea en un select 
     * en la interfaz
     * @param GeneralDTO $obj
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.2
     */
    public function Validate(ValidationDTO $obj, $name) {
        $query = $this->repository->buildQuery($name, array((int) $obj->getId()));
        //echo $query;
        $this->repository->Execute($query);
    }

}
