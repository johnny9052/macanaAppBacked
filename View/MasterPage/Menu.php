<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>        
        <script type="text/javascript" src="Resource/Script/Menu/Menu.js"></script>
        <script type="text/javascript" src="Resource/Script/Security/LogOut.js"></script>
    </head>
    <body>


        <!-- ***************MENU**************** -->


        <section class="sidebar">
            <!-- Sidebar user panel -->
            <div class="user-panel">
                <div class="pull-left image">                    
                    <img src="Resource/Multimedia/Images/Logo.png" class="img-circle"/>
                </div>
                <div class="pull-left info">                   
                    <p><?php
                        if (isset($_SESSION["UserName"])) {
                            echo $_SESSION["UserName"];
                        }
                        ?>    </p>
                    <a href="#"><i class="fa fa-circle text-success"></i>
                        <?php
                        if (isset($_SESSION["TypeUserName"])) {
                            echo $_SESSION["TypeUserName"];
                        }
                        ?>
                    </a>
                </div>
            </div>


            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu" data-widget="tree">

                <li class="header">MENU</li>


                <?php
                include 'Helper/Menu/MenuHelper.php';
                ?>        


            </ul>
        </section>                

        <!-- *************** END MENU**************** -->

    </body>
</html>
