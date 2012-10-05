package com.vedovelli.event
{
	import com.vedovelli.vo.EmpresaVO;
	
	import flash.events.Event;

	public class EmpresaEvent extends Event
	{
		public static const LISTAR:String = "EmpresaEvent_LISTAR";
		public static const CRIAR:String = "EmpresaEvent_CRIAR";
		public static const ATUALIZAR:String = "EmpresaEvent_ATUALIZAR";
		public static const REMOVER:String = "EmpresaEvent_REMOVER";

		public var empresa:EmpresaVO;
		public var id:int;

		public function EmpresaEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

