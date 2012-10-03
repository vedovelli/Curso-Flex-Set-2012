package com.vedovelli.presentation
{
	import flash.events.IEventDispatcher;

	public class BasePresentationModel
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
	}
}