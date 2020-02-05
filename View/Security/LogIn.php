<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title>Identificacion usuarios</title>

        <!-- iCheck -->
        <link rel="stylesheet" href="Resource/plugins/iCheck/square/blue.css">


        <script type="text/javascript" src="Resource/Script/Security/LogIn.js"></script>
    </head>
    <body class="hold-transition login-page">


        <div class="login-box">
            <div class="login-logo">
                <label>EXAUDI</label>
            </div>
            <!-- /.login-logo -->
            <div class="login-box-body">
                <p class="login-box-msg">Identificacion de usuarios</p>

                <form  id="FormContainer">
                    <div class="form-group has-feedback">
                        <input type="text" id="txtUser" name="user" class="form-control" placeholder="Nombre de usuario" required onkeypress="return activarViaEnter(event);">
                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                    </div>
                    <div id="ryry" class="form-group has-feedback">
                        <input type="password" id="txtPassword"  name="password"   class=" form-control" placeholder="Password" required onkeypress="return activarViaEnter(event);">
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>
                    <div class="row">                        
                        <!-- /.col -->
                        <div class="col-md-12">
                            <button type="button" class="btn btn-primary btn-block btn-flat verdeExaudi" id="btnLoguin" onclick="LogIn();">Ingresar</button>
                        </div>

                        <div class="col-md-12">
                            <div class="progress progress-sm active">
                                <div class="progress-bar progress-bar-primary progress-bar-striped" role="progressbar" aria-valuenow="100" aria-valuemin="100" aria-valuemax="100" style="width: 100%">
                                    <span class="sr-only">100% Complete</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>


            </div>
            <!-- /.login-box-body -->
        </div>
        <!-- /.login-box -->




        <script>
            $(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%' // optional
                });
            });
        </script>
    </body>
</html>
