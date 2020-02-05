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

        case "loadAmargor":
            $dao->LoadSelect($obj, "loadamargor");
            break;

        case "loadTypeInventary":
            $dao->LoadSelect($obj, "loadtypeinventary");
            break;

        case "loadBeerType":
            $dao->LoadSelect($obj, "loadbeertype");
            break;

        case "loadClientType":
            $dao->LoadSelect($obj, "loadclienttype");
            break;

        case "loadTypeExpense":
            $dao->LoadSelect($obj, "loadexpensetype");
            break;


        case "loadBeerTypeStock":
            $dao->LoadSelect($obj, "loadbeertypestock");
            break;

        case "loadDepartment":
            $dao->LoadSelect($obj, "loaddepartment");
            break;

        case "loadCity":
            $dao->LoadSelect($obj, "loadcity");
            break;

        /* End load selects */
 

        default :
            echo 'No action found';
            break;
    }
}
