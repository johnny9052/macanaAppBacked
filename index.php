<?php
/* Toca colocarlo aqui porque si no el servidor esta mostrando error */
session_start();
?>

<html>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">        
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">


        <link rel="shortcut icon" type="image/png" href="Resource/Images/Public/favicon.ico"/>
        <link href="Resource/Style/General.css" rel="stylesheet" type="text/css"/>
        <!-- Bootstrap 3.3.7 -->
        <link rel="stylesheet" href="Resource/bower_components/bootstrap/dist/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="Resource/bower_components/font-awesome/css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="Resource/bower_components/Ionicons/css/ionicons.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="Resource/dist/css/AdminLTE.min.css">

        <!-- Google Font -->        
        <link href="Resource/Style/googleFonts.css" rel="stylesheet" type="text/css"/>

        <!-- jQuery 3 -->
        <script src="Resource/bower_components/jquery/dist/jquery.min.js"></script>
        <!-- jQuery UI 1.11.4 -->
        <script src="Resource/bower_components/jquery-ui/jquery-ui.min.js"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
        <script>
            $.widget.bridge('uibutton', $.ui.button);
        </script>
        <!-- Bootstrap 3.3.7 -->
        <script src="Resource/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>        
        <!-- iCheck -->
        <script src="Resource/plugins/iCheck/icheck.min.js"></script>

        <!-- GENERAL JS -->
        <script defer type="text/javascript" src="Resource/Script/General/General.js"></script>
    </head>
    <body>
        <div class="wrapper">
            <?php
            if (isset($_SESSION["User"])) {
                include("View/MasterPage.php");
            } else {
                include("View/Security/LogIn.php");
            }
            ?>

            <label>
                <?php
                if (isset($_GET['MessageLogIn'])) {
                    echo $_GET['MessageLogIn'];
                }
                ?>
            </label>
        </div>     



        <!--MODAL GENERICO PARA MOSTRAR MENSAJES -->
        <div class="modal fade" id="modal-default">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">                        
                        <h4 class="modal-title" id="lblTituloMensajeModal">Mensaje</h4>
                    </div>
                    <div class="modal-body">
                        <p id="lblMessageModal"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cerrar</button>                        
                    </div>
                </div>                
            </div>            
        </div>
        <!--END MODAL GENERICO PARA MOSTRAR MENSAJES -->



    </body>
</html>
