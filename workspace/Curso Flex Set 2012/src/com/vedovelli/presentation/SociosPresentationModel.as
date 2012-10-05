package com.vedovelli.presentation
{
	import com.vedovelli.view.socios.SociosUI;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;

	import spark.components.DataGrid;
	import spark.components.DropDownList;
	import spark.components.gridClasses.GridColumn;

	[Bindable]
	public class SociosPresentationModel extends BasePresentationModel
	{
		import com.vedovelli.event.SocioEvent;
		import com.vedovelli.vo.SocioVO;

		import mx.collections.ArrayCollection;
		import mx.events.FlexEvent;

		private var _socioId:int;
		private var _lista:ArrayCollection;
		private var _socio:SocioVO;
		private var _remover_registro:Boolean;
		private var _limpar:Boolean;
		private var _datagrid:DataGrid;

		public function get datagrid():DataGrid
		{
			return _datagrid;
		}

		public function set datagrid(value:DataGrid):void
		{
			_datagrid = value;
		}

		public function get remover_registro():Boolean
		{
			return _remover_registro;
		}

		[Inject(source="socioController.remover_registro", bind="true")]
		public function set remover_registro(value:Boolean):void
		{
			_remover_registro = value;
			if(datagrid != null){
				lista.removeItemAt(datagrid.selectedIndex);
				resetar();
			}
		}

		public function get limpar():Boolean
		{
			return _limpar;
		}

		[Inject(source="socioController.limpar", bind="true")]
		public function set limpar(value:Boolean):void
		{
			_limpar = value;
			resetar();
		}

		public function get socio():SocioVO
		{
			return _socio;
		}

		[Inject(source="socioController.socio", bind="true")]
		public function set socio(value:SocioVO):void
		{
			_socio = value;
		}

		public function get lista():ArrayCollection
		{
			return _lista;
		}

		[Inject(source="socioController.lista", bind="true")]
		public function set lista(value:ArrayCollection):void
		{
			_lista = value;
		}

		public function get socioId():int
		{
			return _socioId;
		}

		public function set socioId(value:int):void
		{
			_socioId = value;
		}

		public function init():void
		{
			dispatcher.dispatchEvent(new SocioEvent(SocioEvent.LISTAR));
		}

		public function listaSocios_valueCommitHandler(event:FlexEvent):void
		{
			datagrid= DataGrid(event.currentTarget);
			socio = datagrid.selectedItem as SocioVO;
		}

		public function btnSalvar_clickHandler(event:MouseEvent):void
		{
			var ev:SocioEvent;
			if(_socio.id && _socio.id > 0){
				ev = new SocioEvent(SocioEvent.ATUALIZAR);
			} else {
				ev = new SocioEvent(SocioEvent.CRIAR);
			}
			ev.socio = socio;
			dispatcher.dispatchEvent(ev);
		}

		public function resetar():void
		{
			if(datagrid != null){
				datagrid.selectedIndex = -1;
			}
			socio = new SocioVO();
		}

		public function closeHandler(event:CloseEvent):void
		{
			PopUpManager.removePopUp(event.currentTarget as SociosUI);
		}
	}
}


