/*Referencia al app a utilizar, que es el ng-app*/
var app = angular.module("appMaster", []);



/**
 * Directiva utilizada para compilar en tiempo de ejecucion la tabla estructurada en el servidor 
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
app.directive('dynamic', function ($compile) {
    return {
        restrict: 'A',
        replace: true,
        link: function (scope, ele, attrs) {
            scope.$watch(attrs.dynamic, function (html) {
                ele.html(html);
                $compile(ele.contents())(scope);
            });
        }
    };
});

/**
 * Directiva utilizada para compilar en tiempo de ejecucion el buscador
 *  estructurada en el servidor 
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
app.directive('dynamicSearch', function ($compile) {
    return {
        restrict: 'A',
        replace: true,
        link: function (scope, ele, attrs) {
            scope.$watch(attrs.dynamic, function (htmlSearch) {
                ele.htmlSearch(htmlSearch);
                $compile(ele.contents())(scope);
            });
        }
    };
});

/**
 * Controlador ANGULAR con las funciones genericas
 * @author Johnny Alexander Salazar
 * @version 0.1
 */
app.controller('listController', function ($scope) {
    /*Objeto generico para listar la informacion*/
    $scope.objGeneral;

    /**
     * Inserta una tabla ANGULAR-HTML en la directiva dinamica para compilarla
     * en tiempo de ejucion
     * @param {String} tableHTML codigo con la tabla
     * @returns {void} 
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    $scope.cargarTabla = function (tableHTML) {
        $scope.html = tableHTML;
    };


    /**
     * Inserta un buscador ANGULAR-HTML en la directiva dinamica para compilarla
     * en tiempo de ejucion
     * @param {String} HTML codigo con el buscador
     * @returns {void} 
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    $scope.cargarBuscador = function (searchHTML) {
        $scope.htmlSearch = searchHTML;
    };

    /**
     * Funcion que ordena los elementos ascendente o descendentemente en la tabla 
     * ANGULAR - HTML
     * @param {String} order Atrubito que ordena los elementos
     * @returns {void} 
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    $scope.ordenarPor = function (order) {
        $scope.ordenSeleccionado = order;
    };


    /**
     * Ejecuta la funcion search para cargar la informacion asociada al id de 
     * entrada y lo muestra en un modal
     * @param {String} id Identificador del elemento seleccionado
     * @returns {void} 
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    $scope.searchAngular = function (id) {
        search(id);
    };

    /**
     * Ejecuta la funcion detail para cargar la informacion asociada al id de 
     * entrada y lo muestra en un modal
     * @param {String} id Identificador del elemento seleccionado
     * @returns {void} 
     * @author Johnny Alexander Salazar
     * @version 0.1
     */
    $scope.detailAngular = function (id) {
        detail(id);
    };

});




