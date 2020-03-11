<?php

/**
 * Definicion de acciones para la gestion de los aforoes
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
class AforoDAO {

    private $repository;

    function __construct() {
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

    public function GeneratePDFList(AforoDTO $obj) {

        $query = $this->repository->buildQuery("listaforo", array((int) $obj->getId()));

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

            $cadenaHTML .= "<table class='titulo' style='width:100%;'>  
                              <tr>
                                  <td style='width:100%;'>
                                     Listado de aforos registrados
                                  </td>
                              </tr>
                              <tr>
                                  <td>
                                    <hr>
                                  </td>
                              </tr>
                            </table>
                            <br>";


            $cadenaHTML .= "<table id='customers' style='width:100%;'>";

            $cadenaHTML .= "<tr>";
            $cadenaHTML .= "<th style='width:14%;'>Fecha</th>";
            $cadenaHTML .= "<th style='width:14%;'>Numero potrero</th>";
            $cadenaHTML .= "<th style='width:14%;'>Pasto alto</th>";
            $cadenaHTML .= "<th style='width:14%;'>Pasto medio</th>";
            $cadenaHTML .= "<th style='width:14%;'>Pasto bajo</th>";
            $cadenaHTML .= "<th style='width:14%;'>Lance alto</th>";
            $cadenaHTML .= "<th style='width:14%;'>Lance medio</th>";
            $cadenaHTML .= "</tr>";

            for ($cont = 0; $cont < $resultado->rowCount(); $cont++) {
                $cadenaHTML .= "<tr>";
                $cadenaHTML .= "<td style='width:14%;'>" . $vec[$cont][1] . "</td>";
                $cadenaHTML .= "<td style='width:14%;'>" . $vec[$cont][22] . "</td>";
                $cadenaHTML .= "<td style='width:14%;'>" . $vec[$cont][3] . "</td>";
                $cadenaHTML .= "<td style='width:14%;'>" . $vec[$cont][4] . "</td>";
                $cadenaHTML .= "<td style='width:14%;'>" . $vec[$cont][5] . "</td>";
                $cadenaHTML .= "<td style='width:14%;'>" . $vec[$cont][6] . "</td>";
                $cadenaHTML .= "<td style='width:14%;'>" . $vec[$cont][7] . "</td>";
                $cadenaHTML .= "</tr>";
            }
            $cadenaHTML .= "</table>";
        } else {
            $cadenaHTML = "<label>No hay registros en la base de datos</label>";
        }

        $this->repository->BuildPDF($cadenaHTML, $vec[0][1]);
    }

    public function ReportCSVList(AforoDTO $obj) {
        $query = $this->repository->buildQuery("listaforo", array((int) $obj->getId()));
        $this->repository->BuildReportCSV($query, 'lista de aforos', $obj->getCaracter());
    }

}
