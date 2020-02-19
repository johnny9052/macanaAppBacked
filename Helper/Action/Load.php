<?php

/**
 * Contiene el control de las acciones de la carga de los selects del sistema
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function ExecuteActionLoad($action, $obj, $dao) {

    switch ($action) {

        /* Load selects */

        case "loadRol":
            $dao->LoadSelect($obj, "loadrol");
            break;


        case "loadSexoVaca":
            $dao->LoadSelect($obj, "listsexovaca");
            break;

        case "loadRazaVaca":
            $dao->LoadSelect($obj, "listrazavaca");
            break;

        case "loadTipoVaca":
            $dao->LoadSelect($obj, "listtipovaca");
            break;

        /* End load selects */


        default :
            echo 'No action found';
            break;
    }
}
