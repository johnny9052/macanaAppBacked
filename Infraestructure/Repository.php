<?php

/**
 * Repositorio con funciones genericas
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
require_once 'Internationalization.php';
require_once 'Cleaner.php';
require_once 'Connection.php';

require __DIR__ . '../../Resource/html2pdfnew/vendor/autoload.php';

use Spipu\Html2Pdf\Html2Pdf;
use Spipu\Html2Pdf\Exception\Html2PdfException;
use Spipu\Html2Pdf\Exception\ExceptionFormatter;

class Repository extends Internationalization {

    private $con;
    private $objCon;
    private $clean;
    private $emailSystem = "alexander9052@gmail.com";

    function Repository() {
        $this->clean = new Cleaner();
        $this->objCon = new Connection();
        $this->con = $this->objCon->connect();
    }

    function getObjCon() {
        return $this->objCon;
    }

    function setObjCon($objCon) {
        $this->objCon = $objCon;
    }

    /**
     * Construye una consulta sql y retorna el resultado en un cursor, este se
     * enfoca en procedimientos almacenados
     * @return string consulta armada
     * @param string $nameFunction Nombre de la funcion que se quiere ejecutar
     * @param array $array Vector que contiene los parametros que llevara la consulta
     * @author Johnny Alexander Salazar
     * @version 0.3
     */
    public function buildQuery($nameFunction, $array) {

        $query = "CALL " . $nameFunction . "(";

        if ($array) {//tiene parametros?
            for ($i = 0; $i < count($array); $i++) {
                (is_string($array[$i])) ? $query .= "'" . $this->cleanValue($array[$i]) . "'" : $query .= $array[$i]; //si es String pone comilla                
                if ((int) ($i) < (int) (count($array) - 1)) { //si quedan mas parametros pone una ,                    
                    $query .= ",";
                }
            }
        }
        $query .= ");";
        return $query;
    }

    /**
     * Construye una consulta sql y retorna un dato con el nombre de res, este
     * se enfoca en funciones de la base de datos
     *
     * @return string consulta armada
     * @param string $nameFunction Nombre de la funcion que se quiere ejecutar
     * @param array $array Vector que contiene los parametros que llevara la consulta
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function buildQuerySimply($nameFunction, $array) {
        $query = "SELECT " . $nameFunction . "(";

        for ($i = 0; $i < count($array); $i++) {
            (is_string($array[$i])) ? $query .= "'" . $this->cleanValue($array[$i]) . "'" : $query .= $array[$i]; //si es String pone comilla
            if ($i < count($array) - 1) { //si quedan mas parametros pone una ,
                $query .= ",";
            }
        }
        $query .= ");";
        return $query;
    }

    /**
     * Ejecuta una consulta sql y retorna su resultado, si encuentra algo inicia una sesion
     *
     * @return string Echo de resultado de la consulta en formato JSON
     * @param string $query Consulta a ejecutar     
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ExecuteLogIn($query) {

        //echo $query;

        /* Le asigno la consulta SQL a la conexion de la base de datos */
        $resultado = $this->objCon->getConnect()->prepare($query);
        /* Executo la consulta */
        $resultado->execute();
        /* Si obtuvo resultados, entonces paselos a un vector */
        if ($resultado->rowCount() > 0) {
            $vec = $resultado->fetchAll(PDO::FETCH_ASSOC);
        }

        if (isset($vec)) {
            echo(json_encode(['code' => '1',
                'profilePk' => $vec[0]['id'],
                'firstName' => $vec[0]['primer_nombre'],
                'lastName' => $vec[0]['primer_apellido'],
                'typeUser' => $vec[0]['rol'],
                'image_perfil' => $vec[0]['foto'],
                'typeUserName' => $vec[0]['rol_nombre']
            ]));
        } else {
            echo '{"code" : "error", "msg" :"' . $this->getLogInError() . '" }';
        }
    }

    /**
     * Ejecuta una consulta sql y retorna su resultado, si encuentra algo inicia una sesion
     *
     * @return string Echo de resultado de la consulta en formato JSON
     * @param string $query Consulta a ejecutar     
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ExecuteLogInPublic($query) {
        /* Le asigno la consulta SQL a la conexion de la base de datos */
        $resultado = $this->objCon->getConnect()->prepare($query);
        /* Executo la consulta */
        $resultado->execute();
        /* Si obtuvo resultados, entonces paselos a un vector */
        if ($resultado->rowCount() > 0) {
            $vec = $resultado->fetchAll(PDO::FETCH_ASSOC);
        }

        if (isset($vec)) {
            session_start();
            $_SESSION["identificationPublic"] = $vec[0]['id'];
            $_SESSION["namePublic"] = $vec[0]['nombre'];
            $_SESSION["emailPublic"] = $vec[0]['email'];
            $_SESSION["addressPublic"] = $vec[0]['direccion'];
            echo(json_encode(['res' => 'Success']));
        } else {
            echo '{"res" : "Error", "msg" :"' . $this->getLogInError() . '" }';
        }
    }

    /**
     * Valida si se tiene permisos para acceder a la pagina solicitada
     * @return string Echo de resultado de la consulta en formato JSON
     * @param string $query Consulta a ejecutar     
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ExecuteLoadPage($query) {

        /* Le asigno la consulta SQL a la conexion de la base de datos */
        $resultado = $this->objCon->getConnect()->prepare($query);
        /* Executo la consulta */
        $resultado->execute();

        /* Si obtuvo resultados, entonces paselos a un vector */
        if ($resultado->rowCount() > 0) {
            $vec = $resultado->fetchAll(PDO::FETCH_ASSOC);
        }

        if (isset($vec)) {
            $_SESSION["Page"] = $vec[0]['codigo'];
            header('location: ../../index.php');
        } else {
            $_SESSION["Page"] = "View/Home/Home";
            header('location: ../../index.php');
        }
    }

    /**
     * Ejecuta una consulta sql enfocada a seleccionar datos y retorna al 
     * cliente su resultado
     * @return string Echo de resultado de la consulta en formato JSON
     * @param string $query Consulta a ejecutar     
     * @author Johnny Alexander Salazar
     * @version 0.2
     */
    public function Execute($query) {
        try {
            /* Le asigno la consulta SQL a la conexion de la base de datos */
            $resultado = $this->objCon->getConnect()->prepare($query);
            /* Executo la consulta */
            $resultado->execute();
            /* Si obtuvo resultados, entonces paselos a un vector */
            if ($resultado->rowCount() > 0) {
                $vec = $resultado->fetchAll(PDO::FETCH_ASSOC);
            }

            if (isset($vec)) {
                echo(json_encode(['code' => '1',
                    'data' => json_encode($vec)]));
                //echo(json_encode($vec));
            } else {
                echo '{"res" : "NotInfo","code":"0","data":""}';
            }
        } catch (PDOException $exception) {
            /* Se captura el error de ejecucion SQL */
            echo ' {
                "res" : "' . $exception . '"
            }';
        }
    }

    /**
     * Ejecuta una consulta sql enfocada a escritura (save, delete, update)
     *
     * @return string Echo de resultado de la consulta en formato JSON
     * @param string $query Consulta a ejecutar     
     * @author Johnny Alexander Salazar
     * @version 0.2
     */
    public function ExecuteTransaction($query) {
        try {
            /* Le asigno la consulta SQL a la conexion de la base de datos */
            $resultado = $this->objCon->getConnect()->prepare($query);
            /* Executo la consulta */
            $resultado->execute();
            /* Si obtuvo resultados, entonces paselos a un vector */
            if ($resultado->rowCount() > 0) {
                $vec = $resultado->fetchAll(PDO::FETCH_NUM);
            }

            if ($vec[0][0] > 0) {
                echo(json_encode(['code' => '1', "msg" => $this->getOperationSuccess()
                ]));
            } else {
                echo(json_encode(['code' => '2', "msg" => $this->getOperationErrorForeign()]));
            }
        } catch (PDOException $exception) {
            echo(json_encode(['code' => '3', "msg" => $this->getOperationError(),
                'development' => $exception->getMessage()]));
        }
    }

    /**
     * Ejecuta una consulta sql y retorna al su ejecutador resultado
     *
     * @return string Echo de resultado de la consulta en formato JSON
     * @param string $query Consulta a ejecutar     
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function ExecuteReturn($query) {
        /* Le asigno la consulta SQL a la conexion de la base de datos */
        $resultado = $this->objCon->getConnect()->prepare($query);
        /* Executo la consulta */
        $resultado->execute();
        /* Si obtuvo resultados, entonces paselos a un vector */
        if ($resultado->rowCount() > 0) {
            $vec = $resultado->fetchAll(PDO::FETCH_ASSOC);
        }


        if (isset($vec)) {
            return(json_encode($vec));
        } else {
            echo ' {
                "res" : ' . $this->getOperationError() . '
            }';
        }
    }

    public function BuildPaginatorDataTable($query, $actionclick) {

        //Longitud maxima de los caracteres del listado
        $max = 25;

        /* Le asigno la consulta SQL a la conexion de la base de datos */
        $resultado = $this->objCon->getConnect()->prepare($query);
        /* Executo la consulta */
        $resultado->execute();

        /* Se meten los datos a un vector, organizados sus campos no por nombre, 
          si no enumarados */
        $vec = $resultado->fetchAll(PDO::FETCH_NUM);

        /* quedo pendiente mirar como saco todos los registros por un lado y 
         * los campos por el otro de ser necesario, para eso si se necesita 
         * sacar una copia de resultado despues del execute pues se hace.
         */

        if ($resultado->rowCount() > 0) {
            //$cadenaHTML = "<table class='centered responsive-table striped'>";
            $cadenaHTML = "<thead>";
            $cadenaHTML .= "<tr>";
            $cadenaHTML .= "<th>registro #</th>";



            for ($cont = 1; $cont < $resultado->columnCount(); $cont++) { //arma la cabecera de la tabla
                $col = $resultado->getColumnMeta($cont);
                //Coloca la cabecera reempleazando los guiones bajos con espacios
                $cadenaHTML .= "<th>" . str_replace("_", " ", $col['name']) . "</th>";
            }


            $cadenaHTML .= "</tr>";
            $cadenaHTML .= "</thead>";

            $cadenaHTML .= "<tbody>";


            for ($cont = 0; $cont < sizeof($vec); $cont++) { //recorre registro por registro
                //variable que contiene el tr con la funcion del selradio y el update data
                $funcion = "<tr class='seleccionable'  onclick=" . (($actionclick !== '') ? $actionclick : 'search') . "(";
                //variable que contiene los valores de los campos de la tabla
                $campos = "";
                //en el registro que se encuentre pinta sus campos y los saca para la funcion selradio y update data
                for ($posreg = 0; $posreg < $resultado->columnCount(); $posreg++) {//por cada valor del registro
                    //Si se quieren añadir todos los datos solo es quitar el if,
                    //en este caso solo se esta colocando el id
                    if ($posreg == 0) {
                        $funcion .= '\'' . $vec[$cont][$posreg] . "'"; //lo añade a la funcion updatedata    
                    }
                    if ($posreg > 0) {//omite el id para no mostrarlo en los campos de la tabla
                        $campos .= "<td>" . substr($vec[$cont][$posreg], 0, $max) .
                                ((strlen($vec[$cont][$posreg]) > $max) ? ".." : "") . "</td>";
                    }
                }


                //finaliza la funcion search
                $funcion .= ");>"; //finaliza la funcion updatedata
                $cadenaHTML .= $funcion . "<td>" . ($cont + 1) . "</td>";
                $cadenaHTML .= $campos . "</tr>";
            }

            $cadenaHTML .= "</tbody>";
            //$cadenaHTML.="</table>";
        } else {
            $cadenaHTML = "<label>No hay registros en la base de datos</label>";
        }
        echo '[{"res" :"' . $cadenaHTML . '"}]';
    }

    /**
     * Ejecuta una consulta sql y retorna una tabla HTML con el resultado de la consulta
     * @return string Echo de resultado de la consulta en formato JSON, con variable res y conteniendo la talba
     * @param string $query Consulta a ejecutar     
     * @author Johnny Alexander Salazar
     * @version 0.5
     */
    public function BuildDetail($query) {

        //Longitud maxima de los caracteres del listado
        $max = 25;

        /* Le asigno la consulta SQL a la conexion de la base de datos */
        $resultado = $this->objCon->getConnect()->prepare($query);
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
            //$cadenaHTML = "<table class='centered responsive-table striped'>";
            $cadenaHTML = "<thead>";
            $cadenaHTML .= "<tr>";
            $cadenaHTML .= "<th data-field='sel'>registro #</th>";



            for ($cont = 1; $cont < $resultado->columnCount(); $cont++) { //arma la cabecera de la tabla
                $col = $resultado->getColumnMeta($cont);
                //Coloca la cabecera reempleazando los guiones bajos con espacios
                $cadenaHTML .= "<th data-field='" . $col['name'] . "'>" . str_replace("_", " ", $col['name']) . "</th>";
                //VERIFICAR AQUI
            }


            $cadenaHTML .= "</tr>";
            $cadenaHTML .= "</thead>";

            $cadenaHTML .= "<tbody>";


            for ($cont = 0; $cont < sizeof($vec); $cont++) { //recorre registro por registro
                //variable que contiene el tr con la funcion del selradio y el update data
                //$funcion = "<tr class='rowTable' onclick=showData([";
                $funcion = "<tr class='rowTable' ";
                //variable que contiene los valores de los campos de la tabla
                $campos = "";
                //en el registro que se encuentre pinta sus campos y los saca para la funcion selradio y update data
                for ($posreg = 0; $posreg < $resultado->columnCount(); $posreg++) {//por cada valor del registro
                    //Si se quieren añadir todos los datos solo es quitar el if,
                    //en este caso solo se esta colocando el id
                    if ($posreg == 0) {
                        $funcion .= '\'' . $vec[$cont][$posreg] . "'"; //lo añade a la funcion updatedata    
                    }
                    if ($posreg > 0) {//omite el id para no mostrarlo en los campos de la tabla
                        $campos .= "<td>" . substr($vec[$cont][$posreg], 0, $max) .
                                ((strlen($vec[$cont][$posreg]) > $max) ? ".." : "") . "</td>";
                    }
                    //VERIFICAR AQUI
                    //if ($posreg < $resultado->columnCount() - 1) { //si quedan mas parametros por recorrer pone una ,
                    //$funcion.=",";
                    //}
                }


                //$funcion.= "]);showButton(false);>"; 
                //finaliza la funcion search
                $funcion .= ">"; //finaliza la funcion updatedata
                $cadenaHTML .= $funcion . "<td>" . ($cont + 1) . "</td>";
                //$cadenaHTML.=$funcion;
                $cadenaHTML .= $campos . "</tr>";
            }

            $cadenaHTML .= "</tbody>";
            //$cadenaHTML.="</table>";
        } else {
            $cadenaHTML = "<label>No hay registros en la base de datos</label>";
        }
        echo '[{"res" :"' . $cadenaHTML . '"}]';
    }

    public function BuildPDF($content, $nameFile) {

//        require_once('../../Resource/html2pdf/html2pdf.class.php'); // Se carga la libreria
//
//        ob_start(); //Habilita el buffer para la salida de datos 
//        ob_get_clean(); //Limpia lo que actualmente tenga el buffer

        $cadenaHTML = "<page backtop='40mm' backbottom='30mm' backleft='20mm' backright='20mm' footer='date;page'>";
        $cadenaHTML .= '<link href="../../Resource/Style/estilosPDF.css" type="text/css" rel="stylesheet">';


        $cadenaHTML .= " <page_header>
                                <table style='width: 100%;'>
                                    <tr>
                                        <td>
                                            <div><img class='logo' src='../../Resource/Images/logoPdf.png'></div>
                                        </td>                                        
                                    </tr>
                                </table>
                            </page_header>
                            
                            <page_footer>
                                <table style='width: 100%;'>
                                     <tr>
                                        <td>
                                            <div><img class='footer' src='../../Resource/Images/footerPdf.png'></div>
                                        </td>                                        
                                    </tr>
                                </table>
                            </page_footer>";


        $cadenaHTML .= $content;

        $cadenaHTML .= "</page>";


//        //formato del pdf (posicion (P=vertical L=horizontal), tamaño del pdf, lenguaje)
//        $html2pdf = new HTML2PDF('P', 'A4', 'es');
//        $html2pdf->WriteHTML($content); //Lo que tenga content lo pasa a pdf
//        ob_end_clean(); // se limpia nuevamente el buffer
//        $html2pdf->Output($nameFile . '.pdf'); //se genera el pdf, generando por defecto el nombre indicado para guardar

        try {
            /* El true indica si es o no unicode */
            $html2pdf = new Html2Pdf('P', 'A4', 'es', 'true', 'UTF-8');
            $html2pdf->pdf->SetDisplayMode('fullpage');
            $html2pdf->setTestTdInOnePage(false);
            $html2pdf->writeHTML($cadenaHTML);
            ob_end_clean(); // se limpia nuevamente el buffer        
            $html2pdf->output($nameFile . '.pdf');
        } catch (Html2PdfException $e) {
            $html2pdf->clean();
            $formatter = new ExceptionFormatter($e);
            echo $formatter->getHtmlMessage();
        }
    }

    /* Funciones para correo electronico */

    /**
     * Envia un correo electronico al correo de la empresa
     * @return void
     * @param string $titulo Tema del correo
     * @param string $mensaje Mensaje del correo
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function sendEmailSystem($titulo, $mensaje) {
        mail($this->emailSystem, $titulo, $mensaje);
    }

    /**
     * Envia un correo electronico al correo especificado
     * @return void
     * @param string $email Correo al cual se enviara el mensaje
     * @param string $titulo Tema del correo
     * @param string $mensaje Mensaje del correo
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function sendEmail($email, $titulo, $mensaje) {
        $mensaje = $mensaje . '------ Responder al correo: ' . $email;
        mail($this->emailSystem, 'Mensaje de: ' . $titulo, $mensaje);
    }

   
    /**
     * Ejecuta una consulta sql y retorna un archivo CSV con todos los datos
     * @return file.csv Retorna el archivo CSV con todos los datos
     * @param string $query Consulta a ejecutar     
     * @param string $fileName nombre del archivo que se generará
     * @author Johnny Alexander Salazar
     * @version 0.5
     */
    public function BuildReportCSV($query, $fileName) {
        /* Se define la zona horaria en Colombia para generar el archivo */
        date_default_timezone_set("America/Bogota");
        /* Se genera el nombre del archivo con la fecha y hora de la generacion */
        $fileName = $fileName . '-' . date("Y-m-d") . "(" . date("h:i:sa") . ")" . '.csv';
        /* Se define que se retornara un archivo CVS */
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment; filename=' . $fileName);

        /* Le asigno la consulta SQL a la conexion de la base de datos */
        $resultado = $this->objCon->getConnect()->prepare($query);
        /* Executo la consulta */
        $resultado->execute();

        /* Se meten los datos a un vector, organizados sus campos no por nombre, 
          si no enumarados */
        $vec = $resultado->fetchAll(PDO::FETCH_NUM);

        if ($resultado->rowCount() > 0) {

            $content = '';

            /* arma la cabecera de la tabla */
            for ($cont = 0; $cont < $resultado->columnCount(); $cont++) {
                $col = $resultado->getColumnMeta($cont);
                //Coloca la cabecera reempleazando los guiones bajos con espacios
                $content .= $col['name'] . ";";
            }

            /* Enter para separar cabecera de los registros */
            $content .= "\n";

            /* Se sacan los registros */
            for ($cont = 0; $cont < sizeof($vec); $cont++) { //recorre registro por registro
                for ($posreg = 0; $posreg < $resultado->columnCount(); $posreg++) {//por cada valor del registro
                    $content .= $vec[$cont][$posreg] . ';';
                }
                /* Enter para separar los diferentes registros */
                $content .= "\n";
            }
        } else {
            echo "No hay registros en la base de datos, por lo tanto no se puede generar el archivo";
        }
        echo $content;
    }

    /**
     * Limpia una cadena de caracteres extraños
     * @return string cadena de caracteres limpia
     * @param string $value Cadena a limpiar     
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    public function cleanValue($value) {
        return $this->clean->cleanValue($value);
    }

}
