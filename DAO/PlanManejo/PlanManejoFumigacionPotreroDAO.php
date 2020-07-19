<?php

/**
 * Definicion de acciones para la gestion de los planmanejofumigacionpotreroes
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PlanManejoFumigacionPotreroDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PlanManejoFumigacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(PlanManejoFumigacionPotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveplanmanejofumigacionpotrero", array(
            (int) $obj->getIdplanfumigacion(),
            (int) $obj->getIdpotrero(),
            (int) $obj->getIdresponsable()
        ));

        //echo $query;

        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param PlanManejoFumigacionPotreroDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(PlanManejoFumigacionPotreroDTO $obj, $type) {
        $query = $this->repository->buildQuery("listplanmanejofumigacionpotrero", array((int) $obj->getIdplanfumigacion()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param PlanManejoFumigacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(PlanManejoFumigacionPotreroDTO $obj) {
        $query = $this->repository->buildQuery("searchplanmanejofumigacionpotrero", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param PlanManejoFumigacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(PlanManejoFumigacionPotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateplanmanejofumigacionpotrero", array(
            (int) $obj->getId(),
            (int) $obj->getIdplanfumigacion(),
            (int) $obj->getIdpotrero(),
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param PlanManejoFumigacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(PlanManejoFumigacionPotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteplanmanejofumigacionpotrero", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

    public function SavePotrerosPorRotaciones(PlanManejoFumigacionPotreroConfiguracionDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveplanmanejofumigacionpotreroporcaracteristica", array(
            (int) $obj->getIdplanmanejo(),
            (int) $obj->getIdrotacion(),
            (string) $obj->getIdresponsable()
        ));

        //echo $query;

        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PlanManejoFumigacionPotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function SavePotreroOperario(PlanManejoFumigacionPotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateplanmanejofumigacionpotreroByOperario", array(            
            (int) $obj->getIdplanfumigacion(),
            (int) $obj->getIdpotrero(),
            (string) $obj->getFecha(),
            (string) $obj->getObservaciones(),
            (int) $obj->getEjecutado(),
            (int) $obj->getIdresponsable()
        ));
        
       // echo $query;
       $this->repository->ExecuteTransaction($query);
    }

    
    public function ListPotrerosByPlanesManejo(PlanManejoFumigacionPotreroDTO $obj) {
        $query = $this->repository->buildQuery("listplanmanejofumigacionpotreroByPlanManejo", array((int) $obj->getIdplanfumigacion()));
        $this->repository->Execute($query);
    }

}
