<?php 

class AcessoController{

	public function login(UsuarioVO $data){

		try {

			$retorno = array();
			$hasher = new PasswordHash(8, false);
			$condicao = array("conditions" => "usuario = '".$data->usuario."'");
			$usuario = Usuario::find($condicao);
			
			if( count($usuario) === 0 ){
				$retorno['retorno']='Usuário não encontrado';
			} else {
				if( $hasher->CheckPassword($data->senha, $usuario->senha) ){
					$retorno['retorno'] = 'ok';
				} else {
					$retorno['retorno']='Senha incorreta';
				}
			}

			return $retorno;
			
		} catch (Exception $e) {
			return $e;
		}		
	}

}