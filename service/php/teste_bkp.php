<?php 

require_once 'config.php';

$controller = new EmpresaController();

$e = new EmpresaVO();

$e->id = 18;
$e->razao_social = 'Arithmo';
$e->nome_fantasia = 'Arithmos';
$e->cnpj = '02.513.937/0001-96';
$e->endereco = 'Rua Ulhoa Cintra, BH';
$e->socios = array();

$s = new SocioVO();
$s->id = 27;
$s->nome = 'Felipe Drummond';
$s->cpf = '097.153.468-39';
$s->endereco = 'Rua Ulhoa Cintra, BH';
$s->telefones = '(31) 9876-6543';

$e->socios[] = $s;

$s = new SocioVO();
$s->nome = 'Fabio Augusto da Silva Vedovelli';
$s->cpf = '097.153.468-39';
$s->endereco = 'Alameda dos Flamboyants, 222, BH';
$s->telefones = '(31) 96320-2501';

$e->socios[] = $s;

print_r($controller->atualizar($e));
// print_r($controller->criar($e));