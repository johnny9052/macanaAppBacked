<?php

/**
 * Definicion de acciones para la gestion de los roles
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class PotreroDAO {

    private $repository;

    function __construct() {
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
            (int) $obj->getidresponsable(), 
            (int) $obj->getOrdenrotacion(),
            (int) $obj->getEstado()
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
            (int) $obj->getidresponsable(),
            (int) $obj->getOrdenrotacion(),
            (int) $obj->getEstado()
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

    
    public function GeneratePDFList(PotreroDTO $obj) {

        $query = $this->repository->buildQuery("listpotrero", array((int) $obj->getId()));

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

public function ReportCSVList(PotreroDTO $obj) {
    $query = $this->repository->buildQuery("listpotrerocsv", array((int) $obj->getId()));
    $this->repository->BuildReportCSV($query, 'lista de potreros', $obj->getCaracter());
   }

}
