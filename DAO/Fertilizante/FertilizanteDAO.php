<?php

/**
 * Definicion de acciones para la gestion de los roles
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class FertilizanteDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param FertilizanteDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(FertilizanteDTO $obj) {
        $query = $this->repository->buildQuerySimply("savefertilizante",array(
                (int) $obj->getId(),
                (string) $obj->getNombre(), 
                (string) $obj->getMarca(),
                (int) $obj->getIdpresentacion(),
                (int) $obj->getIdresponsable()));
        $this->repository->ExecuteTransaction($query);
        //echo $query;
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param FertilizanteDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(FertilizanteDTO $obj, $type) {
        $query = $this->repository->buildQuery("listfertilizante", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param FertilizanteDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(FertilizanteDTO $obj) {
        $query = $this->repository->buildQuery("searchfertilizante", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param FertilizanteDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(FertilizanteDTO $obj) {
        $query = $this->repository->buildQuerySimply("updatefertilizante",array(
                (int) $obj->getId(),
                (string) $obj->getNombre(), 
                (string) $obj->getMarca(),
                (int) $obj->getIdpresentacion(),
                (int) $obj->getIdresponsable()));
        $this->repository->ExecuteTransaction($query);
        //echo $query;
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param FertilizanteDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(FertilizanteDTO $obj) {
        $query = $this->repository->buildQuerySimply("deletefertilizante", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
