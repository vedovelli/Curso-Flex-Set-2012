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


			$this->gerenciar_socios($empresa->id, $empresa->socios);

			$empresa->socios = $socios_controller->listar($model->id);
			
			#retorna a empresa
			return $empresa;
		} catch (Exception $e) {
			return $e;
		}
	}

	private function gerenciar_socios($empresa_id, $da_interface){
		
		// $socios_controller = new SocioController();
		// $do_bancodados =  $socios_controller->listar($empresa_id);

		// file_put_contents('_1.txt', print_r($da_interface, true));
		// file_put_contents('_2.txt', print_r($do_bancodados, true));

		// if( count($do_bancodados) > count($da_interface) ){
		// 	$a_remover = array_diff($do_bancodados['id'], $da_interface['id']);
		// } else {
		// 	$a_remover = array_diff($da_interface['id'], $do_bancodados['id']);
		// }
		// file_put_contents('_.txt', print_r($a_remover, true));
		// foreach ($a_remover as $key => $value) {
			
		// }

	}

	public function remover($id){
		try{
			# Busca o usuário num model utilizando o ID passado
			$model = Empresa::find($id);
			
			$socios_controller = new SocioController();
			$socios = $socios_controller->listar($model->id);
			foreach ($socios as $key => $value) {
				$socio = Socio::find($value->id);
				$socio->delete();
			}

			# Retorna true ou false, conforme a situação
			return $model->delete();
		} catch (Exception $e) {
			return $e;
		}
	}

}
