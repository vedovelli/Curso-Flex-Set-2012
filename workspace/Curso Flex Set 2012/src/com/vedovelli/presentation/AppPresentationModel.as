package com.vedovelli.presentation
{
	import com.vedovelli.vo.NotificacaoVO;

	[Bindable]
	public class AppPresentationModel extends BasePresentationModel
	{
		import com.vedovelli.event.NotificacaoEvent;
		import com.vedovelli.vo.UsuarioVO;

		private var _usuario:UsuarioVO;
		private var _currentState:String;
		private var _notificacao:NotificacaoVO;

		public function get notificacao():NotificacaoVO
		{
			return _notificacao;
		}

		[Inject(source="appController.notificacao", bind="true")]
		public function set notificacao(value:NotificacaoVO):void
		{
			_notificacao = value;
		}

		public function get currentState():String
		{
			return _currentState;
		}

		[Inject(source="appController.currentState", bind="true")]
		public function set currentState(value:String):void
		{
			_currentState = value;
		}

		public function get usuario():UsuarioVO
		{
			return _usuario;
		}

		[Inject(source="loginController.usuario", bind="true")]
		public function set usuario(value:UsuarioVO):void
		{
			_usuario = value;
			currentState = 'logged';
		}

		public function doLogout():void
		{
			currentState = 'not_logged';

			var ev:NotificacaoEvent = new NotificacaoEvent(NotificacaoEvent.RESET);
			ev.notificacao = new NotificacaoVO();
			dispatcher.dispatchEvent(ev);

		}
	}
}

