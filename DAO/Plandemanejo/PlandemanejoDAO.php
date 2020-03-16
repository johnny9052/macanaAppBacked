<?php

/**
 * Definicion de acciones para la gestion de los roles
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PlandemanejoDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PlandemanejoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(PlandemanejoDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveplandemanejo", 
                array((int) $obj->getId(),
                (string) $obj->getFecha(), 
                (string) $obj->getNombre(),
                (int) $obj->getIdResponsable(),
                (string) $obj->getObservaciones()));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param PlandemanejoDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(PlandemanejoDTO $obj, $type) {
        $query = $this->repository->buildQuery("listplandemanejo", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param PlandemanejoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(PlandemanejoDTO $obj) {
        $query = $this->repository->buildQuery("searchrol", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param PlandemanejoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(PlandemanejoDTO $obj) {
       $query = $this->repository->buildQuerySimply("updaeplandemanejo", 
                array((int) $obj->getId(),
                (string) $obj->getFecha(), 
                (string) $obj->getNombre(),
                (int) $obj->getIdResponsable(),
                (string) $obj->getObservaciones()));
        $this->repository->ExecuteTransaction($query);
       //echo $query;
       
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param PlandemanejoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(PlandemanejoDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteplandemanejo", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    //echo $query;
        
    }

}
