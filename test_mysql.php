<?php

include_once("config/dbutil.php"); # this should be removed later...
#include_once("config/adodb/adodb.inc.php"); # adodb database abstraction layer.. hope database abstracted...
include_once("classapp.php"); # real application class


degiskenal(array("op"));
global $commandline;
$commandline=false;
$user = $_SERVER['HTTP_USER_AGENT'];
if($argv and $argc and (is_array($argv))and (!$user)) {
        $commandline=true;
        $op=$argv[1];
        print_r($argv);
        echo "Commandline active, argc: $argc \n op:$op:\n argv:".print_r($argv);

} else {
        session_start();
}
//echo "argc: $argc <br>\n";

$app = new Application();
$app->cerceve="standartcerceve";
$app->usertable="domainusers";
$app->userfields=array("id","domainname","username","email","quota");
$app->connectTodb();

$app->query("select now()");


?>