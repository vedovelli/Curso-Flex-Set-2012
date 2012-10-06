package com.vedovelli.controller
{
	import mx.controls.Alert;

	public class UsuariosController extends BaseController
	{
		[EventHandler(event="UsuariosEvent.LISTAR")]
		public function listar():void{
			Alert.show('Evento capturado');
		}
	}
}

