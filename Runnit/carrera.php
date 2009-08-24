<?php

require 'libs/Smarty.class.php';
require 'services/RunnitServices.php';

$smarty = new Smarty;
$services = new RunnitServices;

$smarty->assign('section', 'carrera');

$smarty->assign('data',$services->getRunDetails($_REQUEST['id']));
$smarty->assign('runners',$services->getLastUsersInscribedToRuns($_REQUEST['id']));


$smarty->display('carrera.tpl');

?>