package com.vedovelli.event
{
	import com.vedovelli.vo.UsuarioVO;
	
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const LOGADO:String = "LoginEvent_LOGADO";
		public static const LOGIN:String = "LoginEvent_LOGIN";
		public static const LOGOUT:String = "LoginEvent_LOGOUT";
		
		public var usuario:UsuarioVO;
		
		public function LoginEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}