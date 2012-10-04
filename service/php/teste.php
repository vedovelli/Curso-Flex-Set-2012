<?php 

require_once 'config.php';

$hasher = new PasswordHash(8, false);

# Transforma a senha recebida em String em Hash
$senha = $hasher->HashPassword('123');

echo $senha;

// $controller = new UsuarioController();

// $usuario = new UsuarioVO();
// $usuario->usuario = 'carlos';
// $usuario->senha = '123';
// $usuario->nivel = 'administrador';

// print_r($controller->criar($usuario));