<?php

/**
 * Definicion de acciones para la gestion de los roles
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PotreroDAO {

    private $repository;

    function PotreroDAO() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param PotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(PotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("savepotrero", array((int) $obj->getId(),
            (int) $obj->getnumero(), 
            (float) $obj->getarea(),
            (string) $obj->getobservacion(),
            (int) $obj->getidrotacion(),
            (int) $obj->getidresponsable()
                ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param PotreroDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(PotreroDTO $obj, $type) {
        $query = $this->repository->buildQuery("listpotrero", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param PotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(PotreroDTO $obj) {
        $query = $this->repository->buildQuery("searchpotrero", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param PotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(PotreroDTO $obj) {
         $query = $this->repository->buildQuerySimply("updatepotrero", array((int) $obj->getId(),
            (int) $obj->getnumero(), 
            (float) $obj->getarea(),
            (string) $obj->getobservacion(),
            (int) $obj->getidrotacion(),
            (int) $obj->getidresponsable()
                ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param PotreroDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(PotreroDTO $obj) {
        $query = $this->repository->buildQuerySimply("deletepotrero", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
