<?php 

ini_set('show_errors', 1);
error_reporting(E_ALL);

# Adiciona a pasta /library no include path do PHP
set_include_path( implode(PATH_SEPARATOR, array( realpath(dirname(__FILE__) . '/library'), 	get_include_path() ) ) );

# AMF server
require_once 'Zend/Amf/Server.php'; 

# Active Record permite trabalhar com banco de dados sem escrever queries, apenas com objetos
require_once 'php-activerecord/ActiveRecord.php';

# Para criptografar os passwords antes de salvar no banco
require_once 'phpass/PasswordHash.php';

# Classes do projeto
require_once 'controller/Acesso.php';
require_once 'controller/Usuario.php';
require_once 'controller/Empresa.php';
require_once 'controller/Socio.php';
require_once 'model/Empresa.php';
require_once 'model/Socio.php';
require_once 'model/Usuario.php';
require_once 'vo/UsuarioVO.php';
require_once 'vo/EmpresaVO.php';
require_once 'vo/SocioVO.php';

# Configuracao para acesso ao banco de dados
$cfg = ActiveRecord\Config::instance ();
$cfg->set_model_directory ( 'model' );
$cfg->set_connections ( array ('development' => 'mysql://root@127.0.0.1/curso_flex' ) );

?>