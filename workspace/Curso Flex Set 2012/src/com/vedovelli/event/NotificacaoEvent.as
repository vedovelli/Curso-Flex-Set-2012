package com.vedovelli.event
{
	import flash.events.Event;
	
	public class NotificacaoEvent extends Event
	{
		public static const MOSTRAR:String = "NotificacaoEvent_MOSTRAR";
		
		public var headerText:String;
		public var bodyText:String;
		
		public function NotificacaoEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}