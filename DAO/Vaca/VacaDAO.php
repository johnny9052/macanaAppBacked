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

    public function GeneratePDFList(VacaDTO $obj) {

        $query = $this->repository->buildQuery("listvaca", array((int) $obj->getId()));

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

public function ReportCSVList(VacaDTO $obj) {
    $query = $this->repository->buildQuery("listvacacsv", array((int) $obj->getId()));
    $this->repository->BuildReportCSV($query, 'lista de vacas', $obj->getCaracter());
   }
}
