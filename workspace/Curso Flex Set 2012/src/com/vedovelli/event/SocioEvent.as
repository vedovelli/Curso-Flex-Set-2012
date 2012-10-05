package com.vedovelli.event
{
	import com.vedovelli.vo.SocioVO;
	
	import flash.events.Event;

	public class SocioEvent extends Event
	{
		public static const LISTAR:String = "SocioEvent_LISTAR";
		public static const CRIAR:String = "SocioEvent_CRIAR";
		public static const ATUALIZAR:String = "SocioEvent_ATUALIZAR";
		public static const REMOVER:String = "SocioEvent_REMOVER";

		public var socio:SocioVO;
		public var id:int;

		public function SocioEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

