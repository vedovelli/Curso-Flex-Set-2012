package com.vedovelli.event
{
	import com.vedovelli.vo.SocioVO;

	import flash.events.Event;

	public class SocioEvent extends Event
	{
		public static const ADICIONADO:String = "SocioEvent_ADICIONADO";
		public static const REMOVIDO:String = "SocioEvent_REMOVIDO";
		public static const JANELA:String = "SocioEvent_JANELA";
		public static const REMOVER:String = "SocioEvent_REMOVER";

		public var socio:SocioVO;
		public var id:int;

		public function SocioEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

