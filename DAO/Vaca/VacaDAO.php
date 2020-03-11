<?php

/**
 * Definicion de acciones para la gestion de los vacaes
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class VacaDAO {

    private $repository;

    function __construct() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param VacaDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(VacaDTO $obj) {
        $query = $this->repository->buildQuerySimply("savevaca", array((int) $obj->getId(),
            (string) $obj->getNumero(), (string) $obj->getNombre(),
            (int) $obj->getIdRotacion(),(int) $obj->getSexo(),
            (int) $obj->getRaza(),(int) $obj->getTipoanimal(),
            (int) $obj->getEdad(), (int) $obj->getIdresponsable()));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param VacaDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(VacaDTO $obj, $type) {
        $query = $this->repository->buildQuery("listvaca", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param VacaDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(VacaDTO $obj) {
        $query = $this->repository->buildQuery("searchvaca", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param VacaDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(VacaDTO $obj) {
         $query = $this->repository->buildQuerySimply("updatevaca", array((int) $obj->getId(),
            (string) $obj->getNumero(), (string) $obj->getNombre(),
            (int) $obj->getIdRotacion(),(int) $obj->getSexo(),
            (int) $obj->getRaza(),(int) $obj->getTipoanimal(),
            (int) $obj->getEdad(), (int) $obj->getIdresponsable()));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param VacaDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(VacaDTO $obj) {
        $query = $this->repository->buildQuerySimply("deletevaca", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
