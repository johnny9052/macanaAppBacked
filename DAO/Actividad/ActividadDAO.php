<?php

/**
 * Definicion de acciones para la gestion de los actividades
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class ActividadDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param ActividadDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(ActividadDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveactividad", array((int) $obj->getId(),
            (string) $obj->getNombre(), (string) $obj->getDescripcion()));
        //echo $query;        
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param ActividadDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(ActividadDTO $obj, $type) {
        $query = $this->repository->buildQuery("listactividad", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param ActividadDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(ActividadDTO $obj) {
        $query = $this->repository->buildQuery("searchactividad", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param ActividadDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(ActividadDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateactividad", array((int) $obj->getId(),
            (string) $obj->getNombre(), (string) $obj->getDescripcion()));
        //echo $query;
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param ActividadDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(ActividadDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteactividad", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
