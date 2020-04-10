<?php

/**
 * Definicion de acciones para la gestion de los planmanejofertilizaciones
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PlanManejoFertilizacionDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PlanManejoFertilizacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(PlanManejoFertilizacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveplanmanejofertilizacion", array(
            (int) $obj->getId(),
            (int) $obj->getPeriodicidad(),
            (string) $obj->getFechainicio(),
            (string) $obj->getFechafin(),
            (string) $obj->getDescripcion(),
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param PlanManejoFertilizacionDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(PlanManejoFertilizacionDTO $obj, $type) {
        $query = $this->repository->buildQuery("listplanmanejofertilizacion", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param PlanManejoFertilizacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(PlanManejoFertilizacionDTO $obj) {
        $query = $this->repository->buildQuery("searchplanmanejofertilizacion", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param PlanManejoFertilizacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(PlanManejoFertilizacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateplanmanejofertilizacion", array(
            (int) $obj->getId(),
            (int) $obj->getPeriodicidad(),
            (string) $obj->getFechainicio(),
            (string) $obj->getFechafin(),
            (string) $obj->getDescripcion(),
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param PlanManejoFertilizacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(PlanManejoFertilizacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteplanmanejofertilizacion", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
