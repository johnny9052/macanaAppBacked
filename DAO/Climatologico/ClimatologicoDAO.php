<?php

/**
 * Definicion de acciones para la gestion de los roles
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class ClimatologicoDAO {

    private $repository;

    function ClimatologicoDAO() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param ClimatologicoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(ClimatologicoDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveclimatologico", array((int) $obj->getId(),
            (string) $obj->getFecha(), 
            (string) $obj->getNubosidad(),
            (float) $obj->getPluviometria(),
            (string) $obj->getObservaciones(),
            (int) $obj->getIdresponsable()    
                ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param ClimatologicoDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(ClimatologicoDTO $obj, $type) {
        $query = $this->repository->buildQuery("listclimatologico", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param ClimatologicoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(ClimatologicoDTO $obj) {
        $query = $this->repository->buildQuery("searchrol", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param ClimatologicoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(ClimatologicoDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateclimatologico", array((int) $obj->getId(),
            (string) $obj->getFecha(), 
            (string) $obj->getNubosidad(),
            (float) $obj->getPluviometria(),
            (string) $obj->getObservaciones(),
            (int) $obj->getIdresponsable()    
                ));
        
        //echo $query;
        
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param ClimatologicoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(ClimatologicoDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteclimatologico", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
