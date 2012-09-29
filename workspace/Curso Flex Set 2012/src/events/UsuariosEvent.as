package events
{
	import com.vedovelli.vo.UsuarioVO;
	
	import flash.events.Event;
	
	public class UsuariosEvent extends Event
	{
		public static const REMOVER:String = "UsuariosEvent_REMOVER";
		
		public var usuario:UsuarioVO;
		
		public function UsuariosEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}