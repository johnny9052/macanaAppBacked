<?php

/**
 * Definicion de acciones para la gestion de los planmanejofertilizacionfertilizantees
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PlanManejoFertilizacionFertilizanteDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PlanManejoFertilizacionFertilizanteDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(PlanManejoFertilizacionFertilizanteDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveplanmanejofertilizacionfertilizante", array(
            (int) $obj->getIdplanfertilizacion(),
            (int) $obj->getIdfertilizacion(),
            (int) $obj->getCantidad(),
            (int) $obj->getIdresponsable()
        ));

        //echo $query;

        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param PlanManejoFertilizacionFertilizanteDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(PlanManejoFertilizacionFertilizanteDTO $obj, $type) {
        $query = $this->repository->buildQuery("listplanmanejofertilizacionfertilizante", array((int) $obj->getIdplanfertilizacion()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param PlanManejoFertilizacionFertilizanteDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(PlanManejoFertilizacionFertilizanteDTO $obj) {
        $query = $this->repository->buildQuery("searchplanmanejofertilizacionfertilizante", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param PlanManejoFertilizacionFertilizanteDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(PlanManejoFertilizacionFertilizanteDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateplanmanejofertilizacionfertilizante", array(
            (int) $obj->getId(),
            (int) $obj->getIdplanfertilizacion(),
            (int) $obj->getIdfertilizacion(),
            (int) $obj->getCantidad(),
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param PlanManejoFertilizacionFertilizanteDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(PlanManejoFertilizacionFertilizanteDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteplanmanejofertilizacionfertilizante", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
