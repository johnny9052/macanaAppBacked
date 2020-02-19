<?php

/**
 * Definicion de acciones para la gestion de los rotaciones
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class RotacionesDAO {

    private $repository;

    function RotacionesDAO() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param RotacionesDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(RotacionesDTO $obj) {
        $query = $this->repository->buildQuerySimply("saverotacion", array(
            (int) $obj->getId(),
            (string) $obj->getNombre(), 
            (int) $obj->getCantvacas(),
            (int) $obj->getIdresponsable()
                ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param RotacionesDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(RotacionesDTO $obj, $type) {
        $query = $this->repository->buildQuery("listrotacion", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param RotacionesDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(RotacionesDTO $obj) {
        $query = $this->repository->buildQuery("searchrotacion", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param RotacionesDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(RotacionesDTO $obj) {
        $query = $this->repository->buildQuerySimply("updaterotacion", array((int) $obj->getId(),
            (string) $obj->getName(), (string) $obj->getDescription()));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param RotacionesDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(RotacionesDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleterotacion", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
