<?php

/**
 * Definicion de acciones para la gestion de los aforoes
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class AforoDAO {

    private $repository;

    function AforoDAO() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param AforoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(AforoDTO $obj) {
        $query = $this->repository->buildQuerySimply("saveaforo", array(
            (int) $obj->getId(),
            (string) $obj->getFecha(), (int) $obj->getIdpotrero(),
            (float) $obj->getPastoalto(), (float) $obj->getPastomedio(),
            (float) $obj->getPastobajo(), (int) $obj->getLancealto(),
            (int) $obj->getLancemedio(), (int) $obj->getLancebajo(),
            (int) $obj->getCantlances(), (float) $obj->getPesopastoalto(),
            (float) $obj->getPesopastomedio(), (float) $obj->getPesopastobajo(),
            (float) $obj->getCantpasto(), (float) $obj->getPorcentajealtro(),
            (float) $obj->getPorcentajemedio(), (float) $obj->getPorcentajebajo(),
            (float) $obj->getTotalmetrocuadrado(), (float) $obj->getCantpastopotrero(),
            (float) $obj->getTiempopotrero(), (string) $obj->getObservaciones(), 
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param AforoDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(AforoDTO $obj, $type) {
        $query = $this->repository->buildQuery("listaforo", array((int) $obj->getIdUser()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un buscar en la base de datos
     * @param AforoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(AforoDTO $obj) {
        $query = $this->repository->buildQuery("searchaforo", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param AforoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(AforoDTO $obj) {
          $query = $this->repository->buildQuerySimply("updateaforo", array(
            (int) $obj->getId(),
            (string) $obj->getFecha(), (int) $obj->getIdpotrero(),
            (float) $obj->getPastoalto(), (float) $obj->getPastomedio(),
            (float) $obj->getPastobajo(), (int) $obj->getLancealto(),
            (int) $obj->getLancemedio(), (int) $obj->getLancebajo(),
            (int) $obj->getCantlances(), (float) $obj->getPesopastoalto(),
            (float) $obj->getPesopastomedio(), (float) $obj->getPesopastobajo(),
            (float) $obj->getCantpasto(), (float) $obj->getPorcentajealtro(),
            (float) $obj->getPorcentajemedio(), (float) $obj->getPorcentajebajo(),
            (float) $obj->getTotalmetrocuadrado(), (float) $obj->getCantpastopotrero(),
            (float) $obj->getTiempopotrero(), (string) $obj->getObservaciones(), 
            (int) $obj->getIdresponsable()
        ));
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param AforoDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(AforoDTO $obj) {
        $query = $this->repository->buildQuerySimply("deleteaforo", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
