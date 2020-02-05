<?php

/**
 * Definicion de acciones para la gestion de los noticiaes
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class NewDAO {

    private $repository;

    function NewDAO() {
        require_once '../../Infraestructure/Repository.php';
        $this->repository = new Repository();
    }

    /**
     * Ejecuta un guardar en la base de datos
     * @param NewDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Save(NewDTO $obj) {
        $query = $this->repository->buildQuerySimply("savenoticia", array((int) $obj->getId(),
            (string) $obj->getTitle(), (string) $obj->getDescription(),
            (string) $obj->getDate(), (string) $obj->getUrlImage(),
            (string) $obj->getUrlVideo()));
        //echo $query;
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un listar en la base de datos
     * @param NewDTO $obj
     * @param boolean $type indica si se quiere filtro o no 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ListAll(NewDTO $obj, $type) {
        $query = $this->repository->buildQuery("listnoticia", array((int) $obj->getIdUser()));
        $this->repository->BuildPaginatorDataTable($query, '');
    }
    
    
     public function ListAllNoTable(NewDTO $obj, $type) {
        $query = $this->repository->buildQuery("listnoticia", array((int) $obj->getIdUser()));        
        $this->repository->Execute($query);
    }
    

    /**
     * Ejecuta un buscar en la base de datos
     * @param NewDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Search(NewDTO $obj) {
        $query = $this->repository->buildQuery("searchnoticia", array((int) $obj->getId()));
        $this->repository->Execute($query);
    }
    
    
    
    public function GeneratePDF(NewDTO $obj) {
        $query = $this->repository->buildQuery("searchnoticia", array((int) $obj->getId()));
        $this->repository->BuildPDF($query);
    }

    /**
     * Ejecuta un actualizar en la base de datos
     * @param NewDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Update(NewDTO $obj) {
        $query = $this->repository->buildQuerySimply("updatenoticia", array((int) $obj->getId(),
            (string) $obj->getTitle(), (string) $obj->getDescription(),
            (string) $obj->getDate(), (string) $obj->getUrlImage(),
            (string) $obj->getUrlVideo()));
        //echo $query;
        $this->repository->ExecuteTransaction($query);
    }

    /**
     * Ejecuta un borrar en la base de datos
     * @param NewDTO $obj 
     * @return void      
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function Delete(NewDTO $obj) {

        //echo $obj->getUrlImage();
        //Se elimina la imagen, siempre y cuando exista
        if ($obj->getUrlImage() != null) {            
            unlink($obj->getUrlImage());
        }

        $query = $this->repository->buildQuerySimply("deletenoticia", array((int) $obj->getId()));
        $this->repository->ExecuteTransaction($query);
    }

}
