package com.vedovelli.controller
{
	import com.vedovelli.vo.UsuarioVO;

	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	[Bindable]
	public class UsuariosController extends BaseController
	{
		public var lista:ArrayCollection;
		public var usuario:UsuarioVO;

		[EventHandler(event="UsuariosEvent.LISTAR")]
		public function listar():void
		{
			ro.destination = 'UsuarioController';
			sh.executeServiceCall(ro.listar(), listarResult);
		}

		private function listarResult(event:ResultEvent):void
		{
			lista = new ArrayCollection(event.result as Array);
		}

		[EventHandler(event="UsuariosEvent.CRIAR", properties="usuario")]
		public function criar(usu:UsuarioVO):void
		{
			ro.destination = 'UsuarioController';
			sh.executeServiceCall(ro.criar(usu), criarResult);
		}

		private function criarResult(event:ResultEvent):void
		{
			lista.addItemAt(event.result, 0);
			notificar('Usuário', 'Usuário criado com sucesso!');
		}

		[EventHandler(event="UsuariosEvent.ATUALIZAR", properties="usuario")]
		public function atualizar(usu:UsuarioVO):void
		{
			ro.destination = 'UsuarioController';
			sh.executeServiceCall(ro.atualizar(usu), atualizarResult);
		}

		private function atualizarResult(event:ResultEvent):void
		{
			if(event.result is UsuarioVO){
				notificar('Usuário', 'Usuário atualizado com sucesso!');
			}
		}

		[EventHandler(event="UsuariosEvent.REMOVER", properties="id")]
		public function remover(id:int):void
		{
			ro.destination = 'UsuarioController';
			sh.executeServiceCall(ro.remover(id), removerResult);
		}

		private function removerResult(event:ResultEvent):void
		{
			if(event.result){
				notificar('Usuário', 'Usuário removido com sucesso!');
			}
		}

	}
}

