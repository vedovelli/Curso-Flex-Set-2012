package com.vedovelli.controller
{
	import com.vedovelli.event.LoginEvent;
	import com.vedovelli.vo.UsuarioVO;

	import mx.rpc.events.ResultEvent;

	[Bindable]
	public class LoginController extends BaseController
	{
		public var usuario:UsuarioVO;
		public var feedbackVisible:Boolean;
		public var feedbackText:String;

		[EventHandler(event="LoginEvent.LOGIN", properties="usuario")]
		public function fazerLogin(usuario:UsuarioVO):void
		{
			ro.source = 'AcessoController';
			sh.executeServiceCall(ro.login(usuario), loginResult);
		}

		private function loginResult(event:ResultEvent):void
		{
			if( event.result.retorno is UsuarioVO ){
				usuario = event.result.retorno as UsuarioVO;
			} else {
				feedbackVisible = true;
				feedbackText = event.result.retorno;
			}
		}

		function LoginController(){
//			usuario = new UsuarioVO();
		}
	}
}

