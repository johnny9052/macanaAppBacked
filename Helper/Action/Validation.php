<?php

/**
 * Contiene el control de las acciones de la carga de los selects del sistema
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function ExecuteActionValidation($action, $obj, $dao) {

    switch ($action) {
       
        /* Validations */

        case "validateClient":
            $dao->Validate($obj, "validateclient");
            break;

        /* End Validations */

        default :
            echo 'No action found';
            break;
    }
}
