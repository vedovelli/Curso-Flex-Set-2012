package com.vedovelli.controller
{
	import com.vedovelli.vo.EmpresaVO;

	[Bindable]
	public class SociosController extends BaseController
	{
		public var empresa:EmpresaVO;
		public var remover:Boolean;

		[EventHandler(event="EmpresaEvent.EMPRESA_SELECIONADA", properties="empresa")]
		public function empresaSelecionada(emp:EmpresaVO):void
		{
			empresa = emp;
		}

		[EventHandler(event="SocioEvent.REMOVER")]
		public function fazerRemocao():void
		{
			remover != remover;
		}

	}
}

