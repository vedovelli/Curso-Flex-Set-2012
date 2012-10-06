package com.vedovelli.event
{
	import com.vedovelli.vo.UsuarioVO;

	import flash.events.Event;

	public class UsuariosEvent extends Event
	{
		public static const LISTAR:String = "UsuariosEvent_LISTAR";
		public static const CRIAR:String = "UsuariosEvent_CRIAR";
		public static const ATUALIZAR:String = "UsuariosEvent_ATUALIZAR";
		public static const REMOVER:String = "UsuariosEvent_REMOVER";

		public var usuario:UsuarioVO;

		public function UsuariosEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

