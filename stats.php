<?php
include_once("classapp.php");

    $app = new Application();
    $app->requirePassword=false;

    $app->initialize();
    echo $app->smallserverstats2();
    
?>
