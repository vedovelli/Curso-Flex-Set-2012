<?php 

class EmpresaController{

	public function listar(){
		
		try{
			# Busca todos as empresas
			$empresas = Empresa::all();
			
			# Cria um array vazio para server de retorno
			$lista = array();

			# Controller de socios para buscar a lista
			$socios_controller = new SocioController();
			
			# Faz um loop nas empresas retornadas para criar um array de VOs
			foreach ($empresas as $value) {
				$vo = new EmpresaVO();
				$vo->id = $value->id;
				$vo->razao_social = $value->razao_social;
				$vo->nome_fantasia = $value->nome_fantasia;
				$vo->cnpj = $value->cnpj;
				$vo->endereco = $value->endereco;
				$vo->socios = $socios_controller->listar($value->id);
				$lista[] = $vo;
			}
			#retorna a lista
			return $lista;
		} catch (Exception $e) {
			return $e;
		}
	}

	public function criar(EmpresaVO $empresa){
		
		try{
			# Cria nova instancia do Model
			$model = new Empresa();
			
			# Preenche o model com os dados recebidos
			$model->razao_social = $empresa->razao_social;
			$model->nome_fantasia = $empresa->nome_fantasia;
			$model->cnpj = $empresa->cnpj;
			$model->endereco = $empresa->endereco;

			# Salva o model, que receberá na propriedade ID o que foi criado pelo DB
			$model->save();
			
			# Associa o ID gerado pelo DB ao objeto empresa
			$empresa->id = $model->id;
			
			# Criacao dos socios
			$socios_controller = new SocioController();
			if(count($empresa->socios)>0){
				# Controller de socios para salvar os socios recebidos
				foreach ($empresa->socios as $socio) {
					$socio->empresa_id = $empresa->id;
					$socios_controller->criar($socio);
				}
			}
			$empresa->socios = $socios_controller->listar($model->id);

			#retorna a empresa
			return $empresa;
		} catch (Exception $e) {
			return $e;
		}
	}

	public function atualizar(EmpresaVO $empresa){
		
		try{
			# Busca o usuário num model utilizando o ID passado
			$model = Empresa::find($empresa->id);
			
			# Preenche o model com os dados recebidos
			$model->razao_social = $empresa->razao_social;
			$model->nome_fantasia = $empresa->nome_fantasia;
			$model->cnpj = $empresa->cnpj;
			$model->endereco = $empresa->endereco;
			
			# Salva o model, que receberá na propriedade ID o que foi criado pelo DB
			$model->save();

			# Controller de socios para salvar os socios recebidos
			$socios_controller = new SocioController();

			# Criacao dos socios
			if(count($empresa->socios)>0){

				foreach ($empresa->socios as $socio) {
					$socio->empresa_id = $empresa->id;
					if($socio->id>0){
						$socios_controller->atualizar($socio);
					} else {
						$socios_controller->criar($socio);
					}
				}
			}

			$empresa->socios = $socios_controller->listar($model->id);
			
			#retorna a empresa
			return $empresa;
		} catch (Exception $e) {
			return $e;
		}
	}

	public function remover($id){
		try{
			# Busca o usuário num model utilizando o ID passado
			$model = Empresa::find($id);
			# Retorna true ou false, conforme a situação
			return $model->delete();
		} catch (Exception $e) {
			return $e;
		}
	}

}
