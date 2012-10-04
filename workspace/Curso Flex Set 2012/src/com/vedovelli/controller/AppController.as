package com.vedovelli.controller
{
	import com.vedovelli.vo.NotificacaoVO;

	[Bindable]
	public class AppController extends BaseController
	{
		public var notificacao:NotificacaoVO;
		public var currentState:String;

		[EventHandler(event="NotificacaoEvent.RESET", properties="notificacao")]
		[EventHandler(event="NotificacaoEvent.MOSTRAR", properties="notificacao")]
		public function gerenciar_notificacao(notif:NotificacaoVO):void
		{
			notificacao = notif;
		}

	}
}

