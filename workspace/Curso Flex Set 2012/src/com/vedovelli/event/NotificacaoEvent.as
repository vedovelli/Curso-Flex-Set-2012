package com.vedovelli.event
{
	import com.vedovelli.vo.NotificacaoVO;

	import flash.events.Event;

	public class NotificacaoEvent extends Event
	{
		public static const RESET:String = "NotificacaoEvent_RESET";
		public static const MOSTRAR:String = "NotificacaoEvent_MOSTRAR";

		public var notificacao:NotificacaoVO;

		public function NotificacaoEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

