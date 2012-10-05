package com.vedovelli.presentation
{
	import com.vedovelli.event.EmpresaEvent;
	import com.vedovelli.event.SocioEvent;
	import com.vedovelli.view.socios.SociosUI;
	import com.vedovelli.vo.EmpresaVO;
	import com.vedovelli.vo.SocioVO;

	import flash.events.Event;

	import mx.collections.ArrayCollection;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;

	import spark.components.DataGrid;

	[Bindable]
	public class SociosPresentationModel extends BasePresentationModel
	{

		private var _empresa:EmpresaVO;
		private var _lista:ArrayCollection;
		private var _socio:SocioVO;
		private var _datagrid:DataGrid;
		private var _remover:Boolean;

		public function get remover():Boolean
		{
			return _remover;
		}

		[Inject(source="socioController.remover", bind="true")]
		public function set remover(value:Boolean):void
		{
			_remover = value;
			if(datagrid!=null){
				lista.removeItemAt(datagrid.selectedIndex);
			}
			if(dispatcher!= null){
				dispatcher.dispatchEvent(new SocioEvent(SocioEvent.REMOVIDO));
			}
			resetar();
		}

		public function get datagrid():DataGrid
		{
			return _datagrid;
		}

		public function set datagrid(value:DataGrid):void
		{
			_datagrid = value;
		}

		public function get socio():SocioVO
		{
			return _socio;
		}

		public function set socio(value:SocioVO):void
		{
			_socio = value;
		}

		public function get lista():ArrayCollection
		{
			return _lista;
		}

		public function set lista(value:ArrayCollection):void
		{
			_lista = value;
		}

		public function get empresa():EmpresaVO
		{
			return _empresa;
		}

		[Inject(source="socioController.empresa", bind="true")]
		public function set empresa(value:EmpresaVO):void
		{
			if(value != null){
				_empresa = value;
				lista = new ArrayCollection(empresa.socios);
				socio = new SocioVO();
			}
		}

		public function closeHandler(event:CloseEvent):void
		{
			var ev:EmpresaEvent = new EmpresaEvent(EmpresaEvent.ATUALIZAR);
			ev.empresa = empresa;
			dispatcher.dispatchEvent(ev);
			PopUpManager.removePopUp(event.currentTarget as SociosUI);
		}

		public function listaSocios_valueCommitHandler(event:Event):void
		{
			datagrid = event.currentTarget as DataGrid;
			socio = datagrid.selectedItem as SocioVO;
		}

		public function btnSalvar_clickHandler(event:Event):void
		{
			if(socio.id > 0){
				lista.setItemAt(socio, datagrid.selectedIndex);
			} else {
				lista.addItemAt(socio, 0);
				dispatcher.dispatchEvent(new SocioEvent(SocioEvent.ADICIONADO));
			}
			resetar();
		}

		public function resetar():void
		{
			if(datagrid != null){
				datagrid.selectedIndex = -1;
			}
			socio = new SocioVO();
		}
	}
}


