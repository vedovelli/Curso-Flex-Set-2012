<?php 

require_once 'config.php';

$server = new Zend_Amf_Server();

$server 	->setClass('AcessoController')
			->setClass('UsuarioController')
			->setClass('EmpresaController')
			->setClass('SocioController')
			->setClassMap('UsuarioVO', 'UsuarioVO')
			->setClassMap('EmpresaVO', 'EmpresaVO')
			->setClassMap('SocioVO', 'SocioVO');

echo $server->handle();

?>