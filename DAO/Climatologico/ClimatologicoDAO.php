<?php

/**
 * Definicion de acciones para la gestion de los roles
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class ClimatologicoDAO {

    private $repository;

    function __construct() {
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
            (float)  $obj->getPluviometria(),
            (string) $obj->getObservaciones(),
            (int)    $obj->getIdresponsable()    
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
            (float)  $obj->getPluviometria(),
            (string) $obj->getObservaciones(),
            (int)    $obj->getIdresponsable()    
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
    public function GeneratePDFList(ClimatologicoDTO $obj) {

        $query = $this->repository->buildQuery("listclimatologicocsv", array((int) $obj->getId()));

        //Longitud maxima de los caracteres del listado
        $max = 200;
        $cadenaHTML = "";
        /* Le asigno la consulta SQL a la conexion de la base de datos */
        $resultado = $this->repository->getObjCon()->getConnect()->prepare($query);
        /* Executo la consulta */
        $resultado->execute();

        /* Se meten los datos a un vector, organizados sus campos no por nombre, 
          si no enumarados */
        $vec = $resultado->fetchAll(PDO::FETCH_NUM);
        //echo $resultado->columnCount() . '----' . $resultado->rowCount();

        /* quedo pendiente mirar como saco todos los registros por un lado y 
         * los campos por el otro de ser necesario, para eso si se necesita 
         * sacar una copia de resultado despues del execute pues se hace.
         */

        if ($resultado->rowCount() > 0) {

            $cadenaHTML .= "<table id='customers' style='width:100%;'>";

            $cadenaHTML .= "<tr>";
            $cadenaHTML .= "<th style='width:14%;'>Actividad</th>";
            $cadenaHTML .= "<th style='width:14%;'>Fecha Programada</th>";
            $cadenaHTML .= "<th style='width:14%;'>Fecha Ejecutada</th>";
            $cadenaHTML .= "</tr>";

            $cadenaHTML .= "</table>";
        } else {
            $cadenaHTML = "<label>No hay registros en la base de datos</label>";
        }

        $this->repository->BuildPDF($cadenaHTML, $vec[0][1]);
    }

    public function ReportCSVList(ClimatologicoDTO $obj) {
        $query = $this->repository->buildQuery("listclimatologicocsv", array((int) $obj->getId()));
        $this->repository->BuildReportCSV($query, 'lista de estado climatologico', $obj->getCaracter());
    }

}
