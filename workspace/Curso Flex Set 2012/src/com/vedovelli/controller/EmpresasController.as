package com.vedovelli.controller
{
	import com.vedovelli.vo.EmpresaVO;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.rpc.events.ResultEvent;

	[Bindable]
	public class EmpresasController extends BaseController
	{
		public var lista:ArrayCollection;
		public var empresa:EmpresaVO;
		public var remover_registro:Boolean;
		public var limpar:Boolean;

		private var _empresaId:int;

		[EventHandler(event="EmpresasEvent.LISTAR")]
		public function listar():void
		{
			ro.source = 'EmpresaController';
			sh.executeServiceCall(ro.listar(), listarResult);
		}

		private function listarResult(event:ResultEvent):void
		{
			lista = new ArrayCollection(event.result as Array);
		}

		[EventHandler(event="EmpresasEvent.CRIAR", properties="empresa")]
		public function criar(emp:EmpresaVO):void
		{
			ro.source = 'EmpresaController';
			sh.executeServiceCall(ro.criar(emp), criarResult);
		}

		private function criarResult(event:ResultEvent):void
		{
			lista.addItemAt(event.result, 0);
			notificar('Empresa', 'Empresa criado com sucesso!');
			limpar = !limpar;
		}

		[EventHandler(event="EmpresasEvent.ATUALIZAR", properties="empresa")]
		public function atualizar(emp:EmpresaVO):void
		{
			ro.source = 'EmpresaController';
			sh.executeServiceCall(ro.atualizar(emp), atualizarResult);
		}

		private function atualizarResult(event:ResultEvent):void
		{
			if(event.result is EmpresaVO){
				notificar('Empresa', 'Empresa atualizado com sucesso!');
				limpar = !limpar;
			}
		}

		[EventHandler(event="EmpresasEvent.REMOVER", properties="id")]
		public function remover(id:int):void
		{
			_empresaId = id;
			Alert.show(
				'Tem certeza que deseja excluir '+ empresa.empresa + '?', 
				'ATENÇÃO', 
				Alert.YES|Alert.NO, 
				null, 
				fazer_remocao 
				);
		}

		private function fazer_remocao(event:CloseEvent):void
		{
			ro.source = 'EmpresaController';
			sh.executeServiceCall(ro.remover(_empresaId), removerResult);
		}

		private function removerResult(event:ResultEvent):void
		{
			if(event.result){
				notificar('Empresa', 'Empresa removido com sucesso!');
				remover_registro = !remover_registro;
			}
		}

		function EmpresasController():void{
			empresa = new EmpresaVO();
		}

	}
}

