package events
{
	import com.vedovelli.vo.UsuarioVO;
	
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const LOGADO:String = "LoginEvent_LOGADO";
		
		public var usuario:UsuarioVO;
		
		public function LoginEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}