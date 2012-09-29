<?php 

require_once 'config.php';

$controller = new UsuarioController();

$usuario = new UsuarioVO();
$usuario->usuario = 'vedovelli';
$usuario->senha = '123';
$usuario->nivel = 'administrador';

print_r($controller->criar($usuario));