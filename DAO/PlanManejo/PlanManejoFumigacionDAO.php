<?php

/**
 * Definicion de acciones para la gestion de los planmanejofumigaciones
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PlanManejoFumigacionDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PlanManejoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(PlanManejoFumigacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveplanmanejofumigacion", array(
            (int) $obj->getId(),
            (string) $obj->getNombre(),
            (string) $obj->getFechainicio(),
            (string) $obj->getDescripcion(),
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param PlanManejoFumigacionDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(PlanManejoFumigacionDTO $obj, $type) {
        $query = $this->repository->buildQuery("listplanmanejofumigacion", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param PlanManejoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(PlanManejoFumigacionDTO $obj) {
        $query = $this->repository->buildQuery("searchplanmanejofumigacion", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param PlanManejoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(PlanManejoFumigacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateplanmanejofumigacion", array(
            (int) $obj->getId(),
            (string) $obj->getNombre(),
            (string) $obj->getFechainicio(),
            (string) $obj->getDescripcion(),
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param PlanManejoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(PlanManejoFumigacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteplanmanejofumigacion", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
