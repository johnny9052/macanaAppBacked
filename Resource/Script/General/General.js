$(document).ready(function () {

    $.fn.modal.Constructor.DEFAULTS.backdrop = 'static';
    $.fn.modal.Constructor.DEFAULTS.keyboard = false;


    /*Se inicializan los campos de fecha*/
    $('.dateAction').datepicker({
        autoclose: true
    });

});




/**
 * Muestra un mensaje en un toast 
 * @param {String} message Mensaje a mostrar en la ventana emergente
 * @param {String} type Tipo de mensaje a mostrar {error,warning,sucess}, si no 
 * se especifica sera uno por defecto
 * @returns {void} 
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function showToast(message, type) {

    if (message) {

        $("#modal-default").removeClass("modal-danger modal-warning modal-success");

        switch (type) {
            case "error":
                $("#lblTituloMensajeModal").html("Error");
                $("#modal-default").addClass("modal-danger");
                break;

            case "warning":
                $("#lblTituloMensajeModal").html("Cuidado");
                $("#modal-default").addClass("modal-warning");
                break;

            case "success":
                $("#lblTituloMensajeModal").html("Exito");
                $("#modal-default").addClass("modal-success");
                break;

            default:
                $("#lblTituloMensajeModal").html("Informacion");
                break;

        }

        $("#lblMessageModal").html(message);
        setTimeout(function () {
            $('#modal-default').modal('show');
        }, 400);

    }
}




/**
 * Muestra u oculta una barra de progreso
 * @param {boolena} status Se indica con true y false si se muestra o no la barra de progreso
 * @returns {void} 
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function showLoadBar(status) {

    if (status) {
        $(".progress").show();
    } else {

        $(".progress").hide();
    }
}


/**
 * Ejecuta una funcion por Ajax
 * @param {Array} dataSend Array nombrado con los datos a enviar
 * @param {String} url Paquete y nombre del controlador a ejecutar
 * @param {String} before Codigo javascript que se quiere ejecutar antes de enviar la informacion
 * @param {String} success Codigo javascript que se quiere ejecutar cuando se recibe una respuesta
 * @returns {void} 
 * @author Johnny Alexander Salazar
 * @version 0.2
 */
function Execute(dataSend, url, before, success) {

    console.log("Lo que se envia: "+dataSend);


    //alert("ffsfsdfsd");
    $.ajax({
        type: 'post',
        url: "Controller/" + url + ".php",
        beforeSend: function () {
            showLoadBar(true);
            if (before !== "") {
                eval(before);
            }
        },
        data: dataSend,
        success: function (data) {
            console.log(data);
            //document.write(data);
            //alert(data);
            showLoadBar(false);

            /*Se reemplaza cualquier tipo de ENTER se que encuentre, ya que esto 
             * afecta la estructura del JSON*/
            var info = eval("(" + data.replace(/\n/ig, "") + ")");
            var response = (info.res !== undefined) ? info.res : info[0].res;
            var msg = (info.msg !== undefined) ? info.msg : "";
            switch (response) {

                case "Success":
                    /*Funcion que refresca la pagina*/
                    showToast(info.msg, "success");

                    if (success !== "") {
                        /*Si en la estructura enviada se tienen datos, entonces
                         * se sacan, parseandolos como objetos*/
                        info = (info.data !== undefined || info.data !== "") ? eval("(" + info.data + ")") : info;
                        eval(success);
                    }

                    break;

                case "NotInfo":
                    if (success !== "") {
                        info = "";
                        eval(success);
                    }
                    break;

                case "Error":
                    showToast(info.msg, "error");
                    break;
                case undefined:
                default :
                    /*En el caso de que sea un listar info, buscar o pintar menu*/
                    if (dataSend.action === "list" || dataSend.action === "listfilter" ||
                            dataSend.action === "menu" || dataSend.action === "search"
                            || dataSend.action === "detail" || dataSend.action.indexOf("load") > -1) {
                        if (success !== "") {
                            eval(success);
                        }
                    }

                    break;
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            showToast("Error detectado: " + textStatus + "\nExcepcion: " + errorThrown, "error");
            showToast("Verifique la ruta del archivo", "error");
        }
    });
}



/**
 * Ejecuta una peticion al servidor por get, mostrando los resultados en una 
 * nueva pestaña en el navegador
 * @param {Array} dataSend Array nombrado con los datos a enviar
 * @param {String} url Paquete y nombre del controlador a ejecutar
 * @returns {void} 
 * @author Johnny Alexander Salazar
 * @version 0.2
 */
function ExecuteNewTab(dataSend, url) {
    url = "Controller/" + url + ".php?" + dataSend;
    var win = window.open(url, '_blank');
    win.focus();
}



/**
 * Scanea un formulario, detecta los input tipo text y password, y añade
 * sus valores a un array para ser enviados por post. Adicionalmente añade por 
 * defecto el valor type mandado por parametro 
 * @param {String} type : Accion que se ejecutara en el server
 * @param {String} form : Id del formulario donde se encuentran los inputs
 * @param {Array} dataPlus : Array de arrays con datos adicionales, la primera posicion
 * de cada objeto en cada posicion del array padre, es el nombre que se le asignara
 * a dichos datos. Recordar que el array padre se llamara datos, por lo que se debe mandar
 * el parametro asi [{datos: arrayQueSeManda }]
 * @param {Boolean} status : Determina si escanea los campos del formulario
 * @returns {Object} Objeto o array nombrado que se enviara por POST
 * @author Johnny Alexander Salazar
 * @version 0.5
 */
function scanInfo(type, status, form, dataPlus) {
    var arrayParameters = new Array();
    form = defualtForm(form);
    arrayParameters.push(newArg("action", type));

    /*Inputs sencillos*/
    if (status) {
        var campos = '#' + form + ' :input,\n\
                 #' + form + ' select, \n\
                 #' + form + ' textarea';
//        var campos = '#' + form + ' :input:text,\n\
//                  #' + form + ' :input:password, \n\
//                  #' + form + ' textarea, \n\
//                  #' + form + ' select';

        $(campos).each(function () {
            var elemento = this;
            /*Si es un radio, retornamos 1 si esta checkeado, 0 si no*/
            if (elemento.type === "checkbox") {
                arrayParameters.push(newArg(elemento.name, (elemento.checked) ? 1 : 0));
            } else {
                /*Si es un radio, retornamos 1 si esta checkeado, 0 si no*/
                if (elemento.type === "textarea") {
                    arrayParameters.push(newArg(elemento.name, elemento.value));
                } else {
                    arrayParameters.push(newArg(elemento.name, elemento.value));
                }
            }
            //alert("detectado");
        });
    }

    //SI EXISTE INFO ADICIONAL
    if (dataPlus !== undefined) {
        if (dataPlus.length > 0) {
            for (var x in dataPlus) {
                var valTemp = new Array();
                for (var y in dataPlus[x].datos) {
                    valTemp.push(dataPlus[x].datos[y]);
                }

                /*Escanea todos los datos adicionados*/
                while (valTemp.length > 0) {
                    var nombreData = valTemp.shift();
                    var data = valTemp.shift();
                    arrayParameters.push(newArg(nombreData, data));
                }
            }
        }

    }

    //alert(arrayToObject(arrayParameters));
    return arrayToObject(arrayParameters);
}






function base64(file, callback) {

    var coolFile = {};
    function readerOnload(e) {
        var base64 = btoa(e.target.result);
        coolFile.base64 = base64;
        callback(coolFile);
    }
    ;

    var reader = new FileReader();
    reader.onload = readerOnload;

    var file = file[0].files[0];

    coolFile.filetype = file.type;
    coolFile.size = file.size;
    coolFile.filename = file.name;
    reader.readAsBinaryString(file);

}



/**
 * Scanea un formulario, detecta los input tipo text y password, y añade
 * sus valores a un array para ser enviados por GET. Adicionalmente añade por 
 * defecto el valor type mandado por parametro. Este se utiliza para mandar los
 * datos por la URL y esperar los resultados en una nueva pestaña del navegador
 * @param {String} type : Accion que se ejecutara en el server
 * @param {String} form : Id del formulario donde se encuentran los inputs
 * @param {Array} dataPlus : Array con datos adicionales, la primera posicion
 * de cada objeto en cada posicion del array, es el nombre que se le asignara
 * a dichos datos
 * @param {Boolean} status : Determina si escanea los campos del formulario
 * @returns {String} listado de variables estructuradas para mandar por la URL
 * @author Johnny Alexander Salazar
 * @version 0.3
 */
function scanInfoNewTab(type, status, form, dataPlus) {
    var arrayParameters = new Array();
    form = defualtForm(form);
    arrayParameters.push(newArg("action", type));

    /*Inputs sencillos*/
    if (status) {
        var campos = '#' + form + ' :input,\n\
                 #' + form + ' select, \n\
                 #' + form + ' textarea';

        $(campos).each(function () {
            var elemento = this;
            /*Si es un radio, retornamos 1 si esta checkeado, 0 si no*/
            if (elemento.type === "checkbox") {
                arrayParameters.push(newArg(elemento.name, (elemento.checked) ? 1 : 0));
            } else {
                arrayParameters.push(newArg(elemento.name, elemento.value));
            }
        });
    }

    //SI EXISTE INFO ADICIONAL
    if (dataPlus !== undefined) {
        if (dataPlus.length > 0) {
            for (var x in dataPlus) {
                var valTemp = new Array();
                for (var y in dataPlus[x].datos) {
                    valTemp.push(dataPlus[x].datos[y]);
                }
                var nombreData = valTemp.shift();
                arrayParameters.push(newArg(nombreData, valTemp.toString()));
            }
        }

    }

    return arrayParameters.join('&');
}



/**
 * Ingresa un codigo html al listado general
 * @param {String-html} info : html con la tabla
 * @param {String} id : Id del contenedor de la lista
 * @author Johnny Alexander Salazar
 * @version 0.3
 */
function buildPaginator(info, id) {
    id = DefaultTableList(id);
    $("#" + id).html(info[0].res);
    $("#" + id).DataTable({
        'paging': true,
        'lengthChange': true,
        'searching': true,
        'ordering': true,
        'info': true,
        'autoWidth': true,
        'bDestroy': true
    });
}

/**
 * Ingresa un codigo angular html al listado general y almacena los datos 
 * para pintar dicha tabla
 * @param {String-html} info : JSON con la tabla y los datos 
 * @author Johnny Alexander Salazar
 * @version 0.2
 */
function buildPaginatorFilter(info) {
    /*Se referencia el controlador angular*/
    var scope = angular.element($("#divListController")).scope();
    /*Se almacenan los datos que se puntaran en la tabla*/
    scope.objGeneral = info[0].datos;
    /*Se ejecuta la funcion del controller angular para estructurar la tabla*/
    scope.$apply(function () {
        scope.cargarTabla(info[0].res);
    });
    /*Se ejecuta la funcion del controller angular para definir el buscador*/
    scope.$apply(function () {
        scope.cargarBuscador(info[0].search);
    });
}

/**
 * Carga un combo especificado, con los datos que se envian por parametro
 * @param {json} info : Datos que seran agragados
 * @param {int} idSelect : Id del select
 * @author Johnny Alexander Salazar
 * @version 0.3
 */
function buildSelect(info, idSelect) {

    //alert(info);

    var combo = document.getElementById(idSelect);

    while (combo.length > 1) {
        combo.remove(combo.length - 1);
    }

    for (var x in info) {
        combo.options[combo.length] = new Option(info[x].nombre, info[x].id);
    }

    refreshSelect(idSelect, -1);
}


/**
 * Refresca un select
 * @param {string} id : id del select a refrescar
 * @param {string} val : valor por defecto que sera seleccionado
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function refreshSelect(id, val) {
    $("#" + id).val(val);
    //$('#' + id).material_select('destroy');
    //$('#' + id).material_select();
}


/**
 * Valida todos los inputs required de un formulario (si recibe el parametro
 * tomara el id, si no evaluara el form "fMain"), para determinar si son 
 * validos o no, si no son validos muestra un mensaje emergente con los campos
 * que se solicita que sean llenados
 * @param {String} form id del formulario
 * @returns {boolean} true si es correctamente validado, false si tiene errores
 * en la validacion
 * @author Johnny Alexander Salazar
 * @version 0.3
 */
function validateForm(form) {
    var status = true;
    form = defualtForm(form);


    var campos = '#' + form + ' :input,\n\
                 #' + form + ' select, \n\
                 #' + form + ' textarea';

    $(campos).each(function () {
        var elemento = this;

        /*Si es un select se valida que no sea -1*/
        if (elemento.type === "select-one") {
            if (elemento.value === "-1") { //es valido?   
                $(elemento).parent().closest('div').addClass("has-error");
                //$(elemento.id).addClass("invalid");
                status = false; // si no es valido retorne falso                               
            } else {
                $(elemento).parent().closest('div').removeClass("has-error");
            }
        } else {
            /*Si es cualquier otro elementos diferente a select*/
            if (!elemento.validity.valid) { //es valido?                                                             
                $(elemento).parent().closest('div').addClass("has-error");
                status = false; // si no es valido retorne falso                               
            } else {
                $(elemento).parent().closest('div').removeClass("has-error");
            }
        }

    });

    if (!status) {
        showToast("Ingrese o valide los datos requeridos", "error");
    }

    return status;
}




/**
 * Prepara un dato para ser añadido al array de datos que seran enviados por 
 * ajax
 * @param {String} key Nombre del dato
 * @param {String} value Valor del dato
 * @returns {String} el dato codificado
 * @author Johnny Alexander Salazar
 * @version 0.2
 */
function newArg(key, value) {
    return key + "==" + value;
}



/**
 * Determina si debe o no colocar el form generico, si no recibe
 * un parametro tomara el id como "FormContainer"
 * @param {String} form id del formulario
 * @returns {String} id del form generico si no recibe parametro
 * @author Johnny Alexander Salazar
 * @version 0.2
 */
function defualtForm(form) {
    return (form === undefined || form === "") ? 'FormContainer' : form;
}


/**
 * Convierte un array de datos a un objeto, y debe tener separado el nombre de
 * la futura variable y su valor por = 
 * @param {Array} arrayParameters : Array que sera pasado a un objeto
 * @returns {Object} Objeto o array nombrado que se enviara por POST
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function arrayToObject(arrayParameters) {
    var myObj = new Object;
    for (var x in arrayParameters) {
        myObj[((arrayParameters[x]).split("=="))[0]] = ((arrayParameters[x]).split("=="))[1];
    }
    return myObj;
}


/**
 * Limpia los input tipo text, password, label de error, textarea de un formulario, si no recibe
 * un parametro tomara el id como "FormContainer"
 * @param {String} form id del formulario
 * @returns {void}
 * @author Johnny Alexander Salazar
 * @version 0.2
 */
function cleanForm(form) {

    form = DefaultModal(form);

    var campos = '#' + form + ' :input,\n\
                 #' + form + ' select, \n\
                 #' + form + ' textarea';


//    var campos = '#' + form + ' :input:text,\n\
//                  #' + form + ' :input:password, \n\
//                  #' + form + ' :input:email, \n\
//                  #' + form + ' textarea';

    $(campos).each(function () {
        var elemento = this;
        if (elemento.id !== "txtFlag") {
            if (elemento.value) {
                /*Si es un select, coloca el -1*/
                if (elemento.type === "select-one") {
                    $("#" + elemento.id).val("-1");
                    //$('#' + elemento.id).material_select('destroy');
                    //$('#' + elemento.id).material_select();
                } else {
                    $("#" + elemento.id).val("");
                }
            }
        }
        /*Si esta pintado como invalido se le quita*/
        //$("#" + elemento.id).removeClass("invalid");
        $(elemento).parent().closest('div').removeClass("has-error");
    });

    /*Etiquetas limpiables, la cuales suelen ser etiquetas de texto*/
    var collection = $(".limpiable");
    collection.each(function () {
        var elemento = this;
        $("#" + elemento.id).html("");
    });

}




/**
 * A partir de los menus de la base de datos, los genera y los pinta en pantalla
 * @param {Array} data JSON con la informacion de la base de datos
 * @returns {void}
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function BuildMenu(data) {

    data = eval(data);
    var padres = new Array();
    /*Se sacan los codigos de los padres*/
    for (var x in data) {
        if (data[x].codpadre === "-1") {
            padres.push({id: data[x].id, nombre: data[x].nombre, prioridad: data[x].prioridad, hijos: ""});
        }
    }

    /*Por cada padre se sacan sus hijos*/
    for (var x in padres) {
        var temp = new Array();
        for (var y in data) {
            if (padres[x].id === data[y].codpadre) {
                temp.push([{id: data[y].id, nombre: data[y].nombre, prioridad: data[y].prioridad, codigo: data[y].codigo}]);
            }
        }
        padres[x].hijos = temp;
    }

    var menu = "";
    /*Se pinta el menu*/
    for (var x in padres) {

        //SI TIENE HIJOS PINTA EL PADRE Y SUS HIJOS
        if (padres[x].hijos.length > 0) {
            //INICIA EL PADRE
            menu += '<li class="no-padding"><ul class="collapsible collapsible-accordion"><li>';
            menu += '<a class="collapsible-header">' + padres[x].nombre + '<i class="mdi-navigation-arrow-drop-down"></i></a>';
            menu += '<div class="collapsible-body"><ul>';
            for (var y in padres[x].hijos) {
                //SE AÑADE CADA HIJO POR CADA PADRE
                menu += '<li><a href="index.php?page=estudiantes">' + padres[x].hijos[y].nombre + '</a></li>';
                //SE CIERRA EL HIJO
            }
            menu += '</ul></div></li></ul></li>';
            //SE CIERRA EL PADRE
        }
    }

    //CERRAR SESION
    menu += '<li class="left"><a href="#" id="btnDesconectar" class="right" onclick="LogOut();">Cerrar sesion<i class="small mdi-action-account-circle"></i></a></li>';
    $("#slide-out").html(menu);
}


/**
 * Cierra el modal que se especique
 * @param {String} idModal id del modal a cerrar
 * @returns {void}
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function closeWindow(idModal) {
    idModal = DefaultModal(idModal);
    $('#' + idModal).modal('hide');
    cleanForm(idModal);
}


/**
 * Navega entre modales
 * @param {String} close id del modal a cerrar
 * @param {String} open id del modal a abrir
 * @returns {void}
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function goNavigation(close, open) {
    $('#' + close).modal('hide');
    setTimeout(function () {
        $('#' + open).modal({
            backdrop: 'static',
            keyboard: false
        });
    }, 400);

}


/**
 * Abre el modal que se especifique
 * @param {String} idModal id del modal a cerrar
 * @returns {void}
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function openWindow(idModal) {
    idModal = DefaultModal(idModal);
    $('#' + idModal).modal('show');
}

/**
 * Retorna el id del modal por defecto si no se le especifica uno 
 * @param {int} idModal : Id del modal
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function DefaultModal(idModal) {
    return (idModal === undefined || idModal === "") ? 'ModalNew' : idModal;
}



/**
 * Retorna el id del paginador por defecto si no se le especifica uno 
 * @param {int} idTable : Id del contenedor
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function DefaultTableList(idTable) {
    return (idTable === undefined || idTable === "") ? 'TblList' : idTable;
}


/**
 * Oculta o muestra las acciones de un formulario segun se necesiten
 * @param {boolean} status : Indica si se muestra las acciones de guardar o de 
 * editar y eliminar
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function showButton(status) {
    if (status) {
        $(".newActionButton").show();
        $(".updateActionButton").hide();
    } else {
        $(".newActionButton").hide();
        $(".updateActionButton").show();
    }
}


/**
 * Redirecciona a otro formulario del sistema
 * @param {string} url : Ruta archivo a abrir
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function refreshPage(url) {
    window.location.href = "Helper/Content/Content.php?page=" + url;
}



/**
 * Valida si se ha realizado una busqueda previa, validando si el campo por defecto
 * se encuentra bien, o si se especifica por parametro el campo que se desea validar,
 * lo valida
 * @param {string} id : id del campo a validar si se desea uno diferente al que se valida
 * por defecto
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function validateSearch(id) {

    id = (id === undefined || id === "") ? 'txtId' : id;

    if ($("#" + id).val() !== "") {
        return true;
    } else {
        showToast("No se ha realizado una busqueda previa");
        return false;
    }
}




/**
 * Muestra en un modal el detalle de un conjunto de registros
 * @param {string - JSON} info : Informacion en formato JSON que se desea mostrar
 * @param {string} idList : Id de la tabla contenedora
 * @param {string} idModal : Id del modal que se abrira para mostrar el detalle
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
function showDetail(info, idList, idModal) {

    idList = (idList === undefined || idList === "") ? 'TblListDetail' : idList;
    idModal = (idModal === undefined || idModal === "") ? 'ModalDetail' : idModal;

    buildPaginator(info, idList);
    openWindow(idModal);

    showButton(false);
}
