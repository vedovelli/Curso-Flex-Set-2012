package com.vedovelli.controller
{
	import com.vedovelli.event.NotificacaoEvent;
	import com.vedovelli.vo.NotificacaoVO;

	import flash.events.IEventDispatcher;

	import mx.rpc.remoting.mxml.RemoteObject;

	import org.swizframework.utils.services.ServiceHelper;

	[Bindable]
	public class BaseController
	{
		[Inject]
		public var ro:RemoteObject;

		[Inject]
		public var sh:ServiceHelper;

		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		public function notificar(h:String, b:String):void
		{
			var notificacao:NotificacaoVO = new NotificacaoVO();
			notificacao.body = b;
			notificacao.header = h;

			var ev:NotificacaoEvent = new NotificacaoEvent(NotificacaoEvent.MOSTRAR);
			ev.notificacao = notificacao;

			dispatcher.dispatchEvent(ev);
		}
	}
}

