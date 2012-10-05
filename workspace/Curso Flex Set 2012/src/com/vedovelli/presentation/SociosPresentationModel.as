package com.vedovelli.presentation
{
	import com.vedovelli.view.socios.SociosUI;

	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;

	public class SociosPresentationModel extends BasePresentationModel
	{
		public function closeHandler(event:CloseEvent):void
		{
			PopUpManager.removePopUp(event.currentTarget as SociosUI);	
		}
	}
}

