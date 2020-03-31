<?php

/**
 * Definicion de acciones para la gestion de los roles
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PresentacionDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PresentacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(PresentacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("savepresentacion", array((int) $obj->getId(),
            (string) $obj->getNombre(), 
            (string) $obj->getObservacion()));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param PresentacionDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(PresentacionDTO $obj, $type) {
        $query = $this->repository->buildQuery("listPresentacion", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param PresentacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(PresentacionDTO $obj) {
        $query = $this->repository->buildQuery("searchrol", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param PresentacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(PresentacionDTO $obj) {
 $query = $this->repository->buildQuerySimply("updatepresentacion", array((int) $obj->getId(),
            (string) $obj->getNombre(), 
            (string) $obj->getObservacion()));
        //echo $query;
       $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param PresentacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(PresentacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("deletepresentacion", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
