<?php

/**
 * Definicion de acciones para la gestion de los roles
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class RazaVacaDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param RazaVacaDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(RazaVacaDTO $obj) {
        $query = $this->repository->buildQuerySimply("saverazavaca", array((int) $obj->getId(),
            (string) $obj->getNombre(), 
            (string) $obj->getObservaciones()    
                ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param RazaVacaDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(RazaVacaDTO $obj, $type) {
        $query = $this->repository->buildQuery("listrazavaca", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param RazaVacaDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(RazaVacaDTO $obj) {
        $query = $this->repository->buildQuery("searchrol", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param RazaVacaDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(RazaVacaDTO $obj) {
        $query = $this->repository->buildQuerySimply("saverazavaca", array((int) $obj->getId(),
            (string) $obj->getNombre(), 
            (string) $obj->getObservaciones()    
                ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param RazaVacaDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(RazaVacaDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleterol", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
