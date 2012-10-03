package com.vedovelli.controller
{
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
	}
}