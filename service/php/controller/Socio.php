<?php 

class SocioController{

	public function listar($empresa_id){
		
		try{
			# Busca todos os sócios
			$conditions = array('conditions' => 'empresa_id = '.$empresa_id);
			$socios = Socio::all($conditions);
			
			# Cria um array vazio para server de retorno
			$lista = array();
			
			# Faz um loop nos sócios retornados para criar um array de VOs
			foreach ($socios as $value) {
				$vo = new SocioVO();
				$vo->id = $value->id;
				$vo->empresa_id = $value->empresa_id;
				$vo->usuario_id = $value->usuario_id;
				$vo->nome = $value->nome;
				$vo->cpf = $value->cpf;
				$vo->endereco = $value->endereco;
				$vo->telefones = $value->telefones;
				$lista[] = $vo;
			}
			#retorna a lista
			return $lista;
		} catch (Exception $e) {
			return $e;
		}
	}

	public function criar(SocioVO $socio){
		
		try{
			# Cria nova instancia do Model
			$model = new Socio();

			# Preenche o model com os dados recebidos
			$model->empresa_id = $socio->empresa_id;
			$model->usuario_id = $socio->usuario_id;
			$model->nome = $socio->nome;
			$model->cpf = $socio->cpf;
			$model->endereco = $socio->endereco;
			$model->telefones = $socio->telefones;
			
			# Salva o model, que receberá na propriedade ID o que foi criado pelo DB
			$model->save();
			
			# Associa o ID gerado pelo DB ao objeto socio
			$socio->id = $model->id;
			
			#retorna o socio
			return $socio;
		} catch (Exception $e) {
			return $e;
		}
	}

	public function atualizar(SocioVO $socio){
		
		try{
			# Busca o usuário num model utilizando o ID passado
			$model = Socio::find($socio->id);
			
			# Preenche o model com os dados recebidos
			$model->empresa_id = $socio->empresa_id;
			$model->usuario_id = $socio->usuario_id;
			$model->nome = $socio->nome;
			$model->cpf = $socio->cpf;
			$model->endereco = $socio->endereco;
			$model->telefones = $socio->telefones;
			
			# Salva o model, que receberá na propriedade ID o que foi criado pelo DB
			$model->save();
			
			#retorna o sócio
			return $socio;
		} catch (Exception $e) {
			return $e;
		}
	}

	public function remover($id){
		try{
			# Busca o usuário num model utilizando o ID passado
			$model = Socio::find($id);
			# Retorna true ou false, conforme a situação
			return $model->delete();
		} catch (Exception $e) {
			return $e;
		}
	}

}
