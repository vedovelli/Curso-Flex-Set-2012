<?php 

class UsuarioController{

	public function listar(){
		
		try{
			# Busca todos os usuários
			$usuarios = Usuario::all();
			
			# Cria um array vazio para server de retorno
			$lista = array();
			
			# Faz um loop nos usuários retornados para criar um array de VOs
			foreach ($usuarios as $value) {
				$vo = new UsuarioVO();
				$vo->id = $value->id;
				$vo->usuario = $value->usuario;
				$vo->nivel = $value->nivel;
				$lista[] = $vo;
			}

			#retorna a lista
			return $lista;
		} catch (Exception $e) {
			return $e;
		}
	}

	public function criar(UsuarioVO $usuario){
		
		try{
			# Objeto que criará o hash do password
			$hasher = new PasswordHash(8, false);

			# Transforma a senha recebida em String em Hash
			$usuario->senha = $hasher->HashPassword($usuario->senha);
			
			# Cria nova instancia do Model
			$model = new Usuario();
			
			# Preenche o model com os dados recebidos
			$model->usuario = $usuario->usuario;
			$model->senha = $usuario->senha;
			$model->nivel = $usuario->nivel;
			
			# Salva o model, que receberá na propriedade ID o que foi criado pelo DB
			$model->save();
			
			# Associa o ID gerado pelo DB ao objeto usuario
			$usuario->id = $model->id;
			
			# Remove a senha, pois não é necessário retorna-la à interface
			$usuario->senha = '';
			
			#retorna o usuario
			return $usuario;
		} catch (Exception $e) {
			return $e;
		}
	}

	public function atualizar(UsuarioVO $usuario){
		
		try{
			# Busca o usuário num model utilizando o ID passado
			$model = Usuario::find($usuario->id);
			
			# Preenche o model com os dados recebidos
			$model->usuario = $usuario->usuario;
			$model->nivel = $usuario->nivel;
			
			# Atualizar a senha
			if($usuario->senha && $usuario->senha != ''){
				# Objeto que criará o hash do password
				$hasher = new PasswordHash(8, false);

				# Transforma a senha recebida em String em Hash
				$usuario->senha = $hasher->HashPassword($usuario->senha);
				
				$model->senha = $usuario->senha;
			}

			# Salva o model, que receberá na propriedade ID o que foi criado pelo DB
			$model->save();
			
			# Remove a senha, pois não é necessário retorna-la à interface
			$usuario->senha = '';
			
			#retorna o usuario
			return $usuario;
		} catch (Exception $e) {
			return $e;
		}
	}

	public function remover($id){
		try{
			# Busca o usuário num model utilizando o ID passado
			$model = Usuario::find($id);

			# Retorna true ou false, conforme a situação
			return $model->delete();
		} catch (Exception $e) {
			return $e;
		}
	}

}
