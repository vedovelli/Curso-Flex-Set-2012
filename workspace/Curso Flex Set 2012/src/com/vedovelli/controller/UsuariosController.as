package com.vedovelli.controller
{
	import com.vedovelli.vo.UsuarioVO;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.rpc.events.ResultEvent;

	[Bindable]
	public class UsuariosController extends BaseController
	{
		public var lista:ArrayCollection;
		public var usuario:UsuarioVO;
		public var remover_registro:Boolean;
		public var limpar:Boolean;

		private var _usuarioId:int;

		[EventHandler(event="UsuariosEvent.LISTAR")]
		public function listar():void
		{
			ro.source = 'UsuarioController';
			sh.executeServiceCall(ro.listar(), listarResult);
		}

		private function listarResult(event:ResultEvent):void
		{
			lista = new ArrayCollection(event.result as Array);
		}

		[EventHandler(event="UsuariosEvent.CRIAR", properties="usuario")]
		public function criar(usu:UsuarioVO):void
		{
			ro.source = 'UsuarioController';
			sh.executeServiceCall(ro.criar(usu), criarResult);
		}

		private function criarResult(event:ResultEvent):void
		{
			lista.addItemAt(event.result, 0);
			notificar('Usuário', 'Usuário criado com sucesso!');
			limpar = !limpar;
		}

		[EventHandler(event="UsuariosEvent.ATUALIZAR", properties="usuario")]
		public function atualizar(usu:UsuarioVO):void
		{
			ro.source = 'UsuarioController';
			sh.executeServiceCall(ro.atualizar(usu), atualizarResult);
		}

		private function atualizarResult(event:ResultEvent):void
		{
			if(event.result is UsuarioVO){
				notificar('Usuário', 'Usuário atualizado com sucesso!');
				limpar = !limpar;
			}
		}

		[EventHandler(event="UsuariosEvent.REMOVER", properties="id")]
		public function remover(id:int):void
		{
			_usuarioId = id;
			Alert.show(
				'Tem certeza que deseja excluir '+ usuario.usuario + '?', 
				'ATENÇÃO', 
				Alert.YES|Alert.NO, 
				null, 
				fazer_remocao 
				);
		}

		private function fazer_remocao(event:CloseEvent):void
		{
			ro.source = 'UsuarioController';
			sh.executeServiceCall(ro.remover(_usuarioId), removerResult);
		}

		private function removerResult(event:ResultEvent):void
		{
			if(event.result){
				notificar('Usuário', 'Usuário removido com sucesso!');
				remover_registro = !remover_registro;
			}
		}

		function UsuariosController():void{
			usuario = new UsuarioVO();
		}

	}
}

