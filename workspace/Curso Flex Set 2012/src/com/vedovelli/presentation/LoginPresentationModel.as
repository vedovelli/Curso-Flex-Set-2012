package com.vedovelli.presentation
{
	import com.vedovelli.event.LoginEvent;
	import com.vedovelli.vo.UsuarioVO;

	import flash.events.MouseEvent;

	[Bindable]
	public class LoginPresentationModel extends BasePresentationModel
	{
		private var _usuario:UsuarioVO;
		private var _currentState:String;
		private var _feedbackVisible:Boolean;
		private var _feedbackText:String;

		public function get feedbackText():String
		{
			return _feedbackText;
		}

		[Inject(source="loginController.feedbackText", bind="true")]
		public function set feedbackText(value:String):void
		{
			_feedbackText = value;
		}

		public function get feedbackVisible():Boolean
		{
			return _feedbackVisible;
		}

		[Inject(source="loginController.feedbackVisible", bind="true")]
		public function set feedbackVisible(value:Boolean):void
		{
			_feedbackVisible = value;
		}

		public function get currentState():String
		{
			return _currentState;
		}

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
		}

		public function recuperar_senha(event:MouseEvent):void
		{
			currentState = 'recuperar_senha';
		}

		public function voltar(event:MouseEvent):void
		{
			currentState = 'login';
		}

		public function fazer_login(event:MouseEvent):void
		{
			var ev:LoginEvent = new LoginEvent(LoginEvent.LOGIN);
			ev.usuario = usuario;
			dispatcher.dispatchEvent(ev);
		}

		public function init():void
		{
			_usuario.usuario = 'vedovelli';
			_usuario.senha = '123';
		}

	}
}

