<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>

        <title>EXAUDI</title>


        <!-- DATAPICKER-->

        <!-- bootstrap datepicker -->
        <link rel="stylesheet" href="Resource/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">

        <script src="Resource/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        

        <!-- DataTables -->
        <link rel="stylesheet" href="Resource/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">

        <!-- AdminLTE Skins. Choose a skin from the css/skins
             folder instead of downloading all of them to reduce the load. -->                                              
        <link rel="stylesheet" href="Resource/dist/css/skins/_all-skins.min.css">
        <!-- iCheck for checkboxes and radio inputs -->
        <link rel="stylesheet" href="Resource/plugins/iCheck/all.css">


        <!-- DataTables -->
        <script src="Resource/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="Resource/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
        <!-- Slimscroll -->
        <script src="Resource/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <!-- FastClick -->
        <script src="Resource/bower_components/fastclick/lib/fastclick.js"></script>
        <!-- AdminLTE App -->
        <script src="Resource/dist/js/adminlte.min.js"></script>

    </head>
    <body class="hold-transition skin-blue sidebar-mini">


        <header class="main-header">
            <?php
            include("View/MasterPage/Banner.php");
            ?>
        </header>


        <aside class="main-sidebar">
            <?php
            include("View/MasterPage/Menu.php");
            ?>
        </aside>


        <div class="content-wrapper">

            <?php
            if (isset($_SESSION['Page'])) {
                include($_SESSION['Page'] . ".php");
            } else {
                include("View/Home/Home.php");
            }
            ?>      
        </div>

        <footer class="main-footer">
            <?php
            include("View/MasterPage/Footer.php");
            ?>
        </footer>


    </body>
</html>
