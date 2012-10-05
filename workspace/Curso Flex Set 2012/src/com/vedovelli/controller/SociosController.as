package com.vedovelli.controller
{
	import com.vedovelli.vo.SocioVO;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.rpc.events.ResultEvent;

	[Bindable]
	public class SociosController extends BaseController
	{
		public var lista:ArrayCollection;
		public var socio:SocioVO;
		public var remover_registro:Boolean;
		public var limpar:Boolean;

		private var _socioId:int;

		[EventHandler(event="SocioEvent.LISTAR")]
		public function listar():void
		{
//			ro.source = 'SocioController';
//			sh.executeServiceCall(ro.listar(), listarResult);
		}

		private function listarResult(event:ResultEvent):void
		{
			lista = new ArrayCollection(event.result as Array);
		}

		[EventHandler(event="SocioEvent.CRIAR", properties="socio")]
		public function criar(emp:SocioVO):void
		{
//			ro.source = 'SocioController';
//			sh.executeServiceCall(ro.criar(emp), criarResult);
		}

		private function criarResult(event:ResultEvent):void
		{
			lista.addItemAt(event.result, 0);
			notificar('Socio', 'Socio criado com sucesso!');
			limpar = !limpar;
		}

		[EventHandler(event="SocioEvent.ATUALIZAR", properties="socio")]
		public function atualizar(emp:SocioVO):void
		{
//			ro.source = 'SocioController';
//			sh.executeServiceCall(ro.atualizar(emp), atualizarResult);
		}

		private function atualizarResult(event:ResultEvent):void
		{
			if(event.result is SocioVO){
				notificar('Socio', 'Socio atualizado com sucesso!');
				limpar = !limpar;
			}
		}

		[EventHandler(event="SocioEvent.REMOVER", properties="id")]
		public function remover(id:int):void
		{
			_socioId = id;
			Alert.show(
				'Tem certeza que deseja excluir '+ socio.nome + '?', 
				'ATENÇÃO', 
				Alert.YES|Alert.NO, 
				null, 
				fazer_remocao 
				);
		}

		private function fazer_remocao(event:CloseEvent):void
		{
//			ro.source = 'SocioController';
//			sh.executeServiceCall(ro.remover(_socioId), removerResult);
		}

		private function removerResult(event:ResultEvent):void
		{
			if(event.result){
				notificar('Socio', 'Socio removido com sucesso!');
				remover_registro = !remover_registro;
			}
		}

		function SociosController():void{
			socio = new SocioVO();
		}

	}
}

