<?php

/**
 * Contiene el control de las acciones basicas del sistema
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function ExecuteAction($action, $obj, $dao) {

    switch ($action) {

        /* Transaction CRUD */

        case "save":
            $dao->Save($obj);
            break;

        case "search":
            $dao->Search($obj);
            break;

        case "delete":
            $dao->Delete($obj);
            break;

        case "update":
            $dao->Update($obj);
            break;

        case "list":
            $dao->ListAll($obj, false);
            break;
        
        case "listNoTable":
            $dao->ListAllNoTable($obj, false);
            break;

        case "listfilter":
            $dao->ListAll($obj, true);
            break;

        case "GeneratePDF":
            $dao->GeneratePDF($obj);
            break;
        
        /* END Transaction CRUD */


        /* Other transactions */

        case "reportcsv":
            $dao->ReportCSV($obj);
            break;


        case "register":
            $dao->Register($obj);
            break;

        case "detail":
            $dao->Detail($obj);
            break;


        /* Other transactions */
        case "updatestate":
            $dao->UpdateState($obj);
            break;


        default :
            echo 'No action found';
            break;
    }
}




/*(Cadena BASE 64,ruta archivo + nombre  + extension)*/
function base64_to_jpeg($base64_string, $output_file) {
    $ifp = fopen($output_file, "wb");
    $data = explode(',', $base64_string);
    fwrite($ifp, base64_decode($data[0]));
    fclose($ifp);
    return $output_file;
}
