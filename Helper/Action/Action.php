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

        case "generatePDFList":
            $dao->GeneratePDFList($obj);
            break;

        /* END Transaction CRUD */


        /* Other transactions */

        case "reportCSVList":
            $dao->ReportCSVList($obj);
            break;


        case "register":
            $dao->Register($obj);
            break;

        case "detail":
            $dao->Detail($obj);
            break;

        case "updatePassword":
            $dao->UpdatePassword($obj);
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

/**
 * Obtiene una variable de sesion, especificandole el nombre
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function getInfoSesion($name) {
    return (isset($_SESSION[$name]) ? $_SESSION[$name] : "");
}

/**
 * Obtiene una variable por get o post, especificandole el nombre
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function getInfo($name) {
    return (isset($_REQUEST[$name]) ? $_REQUEST[$name] : "");
}

/* (Cadena BASE 64,ruta archivo + nombre  + extension) */

function base64_to_jpeg($base64_string, $output_file) {
    $ifp = fopen($output_file, "wb");
    $data = explode(',', $base64_string);
    fwrite($ifp, base64_decode($data[0]));
    fclose($ifp);
    return $output_file;
}

/**
 * Contiene el control de las acciones basicas del sistema
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function base64ToFile($base64_string, $output_file) {
    // echo $output_file;
    $ifp = fopen($output_file, "wb");
    $data = explode(',', $base64_string);
    fwrite($ifp, base64_decode($data[0]));
    fclose($ifp);
    return $output_file;
}

/**
 * Contiene el control de las acciones basicas del sistema
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function base64_to_file($base64_string, $output_file) {
    $ifp = fopen($output_file, "wb");
    $data = explode(',', $base64_string);
    fwrite($ifp, base64_decode($data[0]));
    fclose($ifp);
    return $output_file;
}

/**
 * Crea todos los archivos que se le especifique
 * @param String $prefixFile Prefijo de las variables que contienen la informacion 
 * de los archivos
 * @param String $routePrefix Prefijo de navegacion desde donde se llama a la
 * carpeta donde se crearan los archivos
 * @param String $routeDBPrefix Prefijo de navegacion desde la intefaz grafica 
 * hasta la carpeta donde se crearan los archivos (Esta es la que se almacena en 
 * base de datos)
 * @param String $routeReal Ruta de navegacion sin los prefijos
 * @param Int $maxFiles Cantidad maxima de archivos a leer, si es solo 1 se manda 
 * cero (0) o 1, por parametro
 * @param String $indicatorNameFile Prefijo que se le quiera dar al nombre de los 
 * archivos cuando estos sean creados
 * @param String $extensionsFiles Extension de los archivos que seran creados 
 * @param Boolean $dateStatus True si se desea agregar la fecha y hora de creacion 
 * a los archivos creados, false si no
 * @return String-Array Si el numero de archivos a crear se indico con 0, retorna 
 * un String con la ruta del archivo creado, sino retorna un array con todas las 
 * rutas de los archivos creados
 * @author Johnny Alexander Salazar
 * @version 0.4
 */
function generateFiles($prefixFile, $routePrefix, $routeDBPrefix, $routeReal, $maxFiles, $indicatorNameFile, $extensionsFiles, $dateStatus) {

    $nameFiles = 'nameFile' . $prefixFile;
    $nameBase64Files = 'base64File' . $prefixFile;

    /* Objeto que permite quitar caracteres extraños al nombre del archivo */
    $cleaner = new Cleaner();

    /* Array donde se almacenan las rutas de los archivos creados */
    $arrayFiles = array();

    /* Ahora se pasan a crear los archivos */
    for ($x = 0; $x <= ($maxFiles - 1); $x++) {
        /* Se obtiene la codificacion del archivo */
        $base64Code = getInfo($nameBase64Files . $x);
        /* Se obtiene la ruta del archivo o el nombre de este */
        $filePath = getInfo($nameFiles . $x);
        /* Este se obtiene para tener refencia del nombre original sin modificaciones */
        $filePathOriginal = getInfo($nameFiles . $x);



        /* Si pudo obtener un archivo */
        if ($filePath != null && $filePath != "") {
            /* Se construye la ruta donde quedara el archivo, pero con el prefijo 
              designado para quedar en base de datos */
            $filePathDB = $routeDBPrefix . $routeReal . $cleaner->cleanValueFileName($indicatorNameFile . '_' . $filePath) . (($dateStatus) ? '_' . $cleaner->cleanValueDate(date('Y-m-d H:i:s')) : '') . $extensionsFiles;
            /* Se construye la ruta donde quedara el archivo, pero con el prefijo 
              designado para crear el archivo desde la ruta de llamado */
            $filePath = $routePrefix . $routeReal . $cleaner->cleanValueFileName($indicatorNameFile . '_' . $filePath) . (($dateStatus) ? '_' . $cleaner->cleanValueDate(date('Y-m-d H:i:s')) : '') . $extensionsFiles;
            /* Si no existe el archivo que se va a crear */
            /* Se quitan las ñ y tildes de los nombres */


            // echo '******************LA RUTA2 ES**************** '.$filePath;

            $filePathDB = $cleaner->cleanValueSpanish($filePathDB);
            $filePath = $cleaner->cleanValueSpanish($filePath);

            // echo '******************LA RUTA2 ES**************** '.$filePath;

            if (!file_exists(str_replace($routeDBPrefix, $routePrefix, $filePathOriginal))) {
                if ($base64Code !== 'NotBase64') {
                    /* Se crea el archivo */
                    base64ToFile($base64Code, $filePath);
                }
            }
            /* Se añade a la lista de los archivos creados o que ya existian previamente */
            $arrayFiles[] = $filePathDB;
        } else {
            /* Si no encontro el dato solicitado, se rompe el ciclo para no preguntar por mas */
            break;
        }
    }


    /* Si el numero maximo de archivos es 0 solo se retorna la ruta del unico archivo creado */
    if ($maxFiles <= 1) {
        if (count($arrayFiles) >= 1) {
            return $arrayFiles[0];
        } else {
            return '';
        }
    } else {
        /* Si es mas de un archivo, se retorna el array con todos los datos */
        return $arrayFiles;
    }
}

/**
 * Borra todos los archivos que se le indiquen
 * @param String $fileNameToDeletePrefix Prefijo de las variables que contienen la informacion 
 * de los archivos
 * @param String $routePrefix Prefijo de la ruta desde este punto, para la creacion de los archivos
 * @param String $routeDBPrefix Prefijo de la ruta desde la raiz del proyecto, para 
 * su referencia en la base de datos
 * @param String $routeReal Ruta desde la raiz del system del proyecto, para indicar
 * donde se almacenaran los archivos
 * @param Int $maxFiles Cantidad maxima de archivos a leer, si es solo 1 se manda 
 * cero (0) o 1, por parametro
 * @param String $indicatorFileName Prefijo que se le quiera dar al nombre de los 
 * archivos cuando estos sean creados 
 * @param Boolean $statusDate True si se desea agregar la fecha y hora de creacion 
 * @param String $extensionsFiles Extension de los archivos que seran creados 
 * a los archivos creados, false si no
 * @return VOID 
 * @author Johnny Alexander Salazar
 * @version 0.3
 */
function deleteFiles($fileNameToDeletePrefix, $routePrefix, $routeDBPrefix, $routeReal, $maxFiles, $indicatorFileName, $statusDate, $extensionsFiles) {
    $fileNameToDeletePrefix = 'nameFile' . $fileNameToDeletePrefix . 'Delete';

    /* Objeto que permite quitar caracteres extraños al nombre del archivo */
    $cleaner = new Cleaner();
    /* Primero se recorren todos los archivos que se han eliminado desde la 
      interfaz, por si estos ya existen en el server, puedan ser eliminados */
    for ($y = 0; $y <= $maxFiles; $y++) {
        /* Se preguntan por los datos que tienen el nombre-prefijo indicado */
        $filePathDeleted = getInfo($fileNameToDeletePrefix . $y);

        /* Si se pudo obtener algun dato para validarlo */
        if ($filePathDeleted != null && $filePathDeleted != "") {
            /* Se contruye la ruta */
            //VERSION ORIGINAL
            // $filePathDeleted = $routePrefix . $routeReal . $cleaner->cleanValueFileName($indicatorFileName . '_' . $filePathDeleted) . (($statusDate) ? '_' . $cleaner->cleanValueDate(date('Y-m-d H:i:s')) : '') . $extensionsFiles;
            $filePathDeleted = $routePrefix . $filePathDeleted;
            //echo 'EL VALOR ES  ' . $filePathDeleted;
            /* Se valida si existe el archivo eliminado */
            if (file_exists($filePathDeleted)) {
                /* Si existe, se elimina el archivo */
                unlink($filePathDeleted);
            }
        } else {
            /* Si no se pudo obtener dato, es porque no existen mas datos a 
              eliminar */
            break;
        }
    }
}
