package com.vedovelli.controller
{
	import com.vedovelli.vo.NotificacaoVO;

	[Bindable]
	public class NotificacaoController extends BaseController
	{
		public var notificacao:NotificacaoVO;

		[EventHandler(event="NotificacaoEvent.MOSTRAR", properties="notificacao")]
		public function mostrar(notif:NotificacaoVO):void
		{
			notificacao = notif;
		}

	}
}

