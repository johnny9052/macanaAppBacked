<?php

/**
 * Definicion de acciones para la gestion de los roles
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class InsumoFumigacionDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param InsumoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(InsumoFumigacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveinsumofumigacion", array(
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
     * @param InsumoFumigacionDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(InsumoFumigacionDTO $obj, $type) {
        $query = $this->repository->buildQuery("listinsumofumigacion", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param InsumoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(InsumoFumigacionDTO $obj) {
        $query = $this->repository->buildQuery("searchinsumofumigacion", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param InsumoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(InsumoFumigacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("updateinsumofumigacion", array(
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
     * @param InsumoFumigacionDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(InsumoFumigacionDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteinsumofumigacion", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
