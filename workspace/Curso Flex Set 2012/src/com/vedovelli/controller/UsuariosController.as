package com.vedovelli.controller
{
	import com.vedovelli.event.NotificacaoEvent;
	import com.vedovelli.event.UsuariosEvent;
	import com.vedovelli.vo.NotificacaoVO;
	import com.vedovelli.vo.UsuarioVO;

	import flash.events.IEventDispatcher;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.rpc.events.ResultEvent;

	[Bindable]
	public class UsuariosController extends BaseController
	{

		/* Variaveis publicas para serem injetadas nas views */
		public var lista:ArrayCollection;
		public var usuario:UsuarioVO;
		public var usuarioId:int;
		public var removido:Boolean;
		public var limpar:Boolean;

		/* LISTAR USUARIOS ************************************************/
		[EventHandler(event="UsuariosEvent.LISTAR")]
		public function listar(event:UsuariosEvent):void{
			ro.source = 'UsuarioController';
			sh.executeServiceCall( ro.listar(), listarResult);
		}

		private function listarResult(event:ResultEvent):void
		{
			lista = new ArrayCollection(event.result as Array);
		}

		/* CRIAR USUARIO ************************************************/
		[EventHandler(event="UsuariosEvent.CRIAR", properties="usuario")]
		public function criar(usu:UsuarioVO):void{
			ro.source = 'UsuarioController';
			sh.executeServiceCall( ro.criar(usu), criarResult);
		}

		private function criarResult(event:ResultEvent):void
		{
			usuario = event.result as UsuarioVO;
			lista.addItem(usuario);
			limpar = !limpar;
			notificar('USUÁRIO', 'Usuário criado com sucesso!');
		}

		/* ATUALIZAR USUARIO ************************************************/
		[EventHandler(event="UsuariosEvent.ATUALIZAR", properties="usuario")]
		public function atualizar(usu:UsuarioVO):void{
			ro.source = 'UsuarioController';
			sh.executeServiceCall( ro.atualizar(usu), atualizarResult);
		}

		private function atualizarResult(event:ResultEvent):void
		{
			usuario = event.result as UsuarioVO;
			limpar = !limpar;
			notificar('USUÁRIO', 'Usuário atualizado com sucesso!');
		}

		/* REMOVER USUARIO ************************************************/
		[EventHandler(event="UsuariosEvent.REMOVER", properties="usuario")]
		public function remover(usu:UsuarioVO):void{
			usuarioId = usu.id;
			Alert.show(
				'Tem certeza que deseja excluir '+ usu.usuario + '?', 
				'ATENÇÃO', 
				Alert.YES|Alert.NO, 
				null, 
				fazer_remocao 
				);
		}

		private function fazer_remocao(event:CloseEvent):void
		{
			if(event.detail == Alert.YES){
				ro.source = 'UsuarioController';
				sh.executeServiceCall(ro.remover(usuarioId), fazerRemocaoResult);
			}
		}

		private function fazerRemocaoResult(event:ResultEvent):void
		{
			if(event.result){
				removido = !removido;
				notificar('USUÁRIO', 'Usuário removido com sucesso!');
			}
		}

		private function notificar(header:String, body:String):void
		{
			var notif:NotificacaoVO;
			var ev:NotificacaoEvent;

			notif = new NotificacaoVO();
			notif.body = body;
			notif.header = header;

			ev = new NotificacaoEvent(NotificacaoEvent.MOSTRAR);
			ev.notificacao = notif;

			dispatcher.dispatchEvent(ev);	
		}

	}
}

