<?php

/**
 * Definicion de acciones para la gestion de los planmanejofumigacioninsumofumigaciones
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PlanManejoFumigacionInsumoFumigacionDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PlanManejoFumigacionInsumoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(PlanManejoFumigacionInsumoFumigacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveplanmanejofumigacioninsumofumigacion", array(
            (int) $obj->getIdplanfumigacion(),
            (int) $obj->getIdfumigacion(),
            (int) $obj->getCantidad(),
            (int) $obj->getIdresponsable()
        ));

        //echo $query;

        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param PlanManejoFumigacionInsumoFumigacionDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(PlanManejoFumigacionInsumoFumigacionDTO $obj, $type) {
        $query = $this->repository->buildQuery("listplanmanejofumigacioninsumofumigacion", array((int) $obj->getIdplanfumigacion()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param PlanManejoFumigacionInsumoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(PlanManejoFumigacionInsumoFumigacionDTO $obj) {
        $query = $this->repository->buildQuery("searchplanmanejofumigacioninsumofumigacion", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param PlanManejoFumigacionInsumoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(PlanManejoFumigacionInsumoFumigacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateplanmanejofumigacioninsumofumigacion", array(
            (int) $obj->getId(),
            (int) $obj->getIdplanfumigacion(),
            (int) $obj->getIdfumigacion(),
            (int) $obj->getCantidad(),
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param PlanManejoFumigacionInsumoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(PlanManejoFumigacionInsumoFumigacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteplanmanejofumigacioninsumofumigacion", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
