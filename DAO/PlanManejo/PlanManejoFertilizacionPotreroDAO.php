<?php

/**
 * Definicion de acciones para la gestion de los planmanejofertilizacionpotreroes
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PlanManejoFertilizacionPotreroDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PlanManejoFertilizacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(PlanManejoFertilizacionPotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveplanmanejofertilizacionpotrero", array(
            (int) $obj->getIdplanfertilizacion(),
            (int) $obj->getIdpotrero(),
            (int) $obj->getIdresponsable()
        ));

        //echo $query;

        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param PlanManejoFertilizacionPotreroDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(PlanManejoFertilizacionPotreroDTO $obj, $type) {
        $query = $this->repository->buildQuery("listplanmanejofertilizacionpotrero", array((int) $obj->getIdplanfertilizacion()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param PlanManejoFertilizacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(PlanManejoFertilizacionPotreroDTO $obj) {
        $query = $this->repository->buildQuery("searchplanmanejofertilizacionpotrero", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param PlanManejoFertilizacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(PlanManejoFertilizacionPotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateplanmanejofertilizacionpotrero", array(
            (int) $obj->getId(),
            (int) $obj->getIdplanfertilizacion(),
            (int) $obj->getIdpotrero(),
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param PlanManejoFertilizacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(PlanManejoFertilizacionPotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteplanmanejofertilizacionpotrero", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

    public function SavePotrerosPorRotaciones(PlanManejoFertilizacionPotreroConfiguracionDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveplanmanejofertilizacionpotreroporcaracteristica", array(
            (int) $obj->getIdplanmanejo(),
            (int) $obj->getIdrotacion(),
            (string) $obj->getIdresponsable()
        ));

        //echo $query;

        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PlanManejoFertilizacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function SavePotreroOperario(PlanManejoFertilizacionPotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateplanmanejofertilizacionpotreroByOperario", array(            
            (int) $obj->getIdplanfertilizacion(),
            (int) $obj->getIdpotrero(),
            (string) $obj->getFecha(),
            (string) $obj->getObservaciones(),
            (int) $obj->getEjecutado(),
            (int) $obj->getIdresponsable()
        ));
        
       // echo $query;
       $this->repository->ExecuteTransaction($query);
    }

    
    public function ListPotrerosByPlanesManejo(PlanManejoFertilizacionPotreroDTO $obj) {
        $query = $this->repository->buildQuery("listplanmanejofertilizacionpotreroByPlanManejo", array((int) $obj->getIdplanfertilizacion()));
        $this->repository->Execute($query);
    }

}
