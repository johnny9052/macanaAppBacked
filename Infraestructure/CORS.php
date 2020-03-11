<?php
//
// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS");
// header("Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token,X-Requested-With");
// header("Content-Type: application/json");


header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Auth-Token, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE, OPTIONS");
header("Allow: GET, POST, OPTIONS, PUT, DELETE");
header('Access-Control-Allow-Credentials: true');
// header("Content-Type: application/json");

$method = $_SERVER['REQUEST_METHOD'];

if ($method == "OPTIONS") {
    die();
}
