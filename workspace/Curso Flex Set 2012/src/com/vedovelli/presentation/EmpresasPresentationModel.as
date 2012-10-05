package com.vedovelli.presentation
{
	import com.vedovelli.view.socios.SociosUI;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;

	import spark.components.DataGrid;
	import spark.components.DropDownList;
	import spark.components.gridClasses.GridColumn;

	[Bindable]
	public class EmpresasPresentationModel extends BasePresentationModel
	{
		import com.vedovelli.event.EmpresaEvent;
		import com.vedovelli.vo.EmpresaVO;

		import mx.collections.ArrayCollection;
		import mx.events.FlexEvent;

		private var _empresaId:int;
		private var _lista:ArrayCollection;
		private var _empresa:EmpresaVO;
		private var _remover_registro:Boolean;
		private var _limpar:Boolean;
		private var _datagrid:DataGrid;
		private var _cbNiveis:DropDownList;
		private var _janelaSocios:SociosUI;

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

		[Inject(source="empresaController.remover_registro", bind="true")]
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

		[Inject(source="empresaController.limpar", bind="true")]
		public function set limpar(value:Boolean):void
		{
			_limpar = value;
			resetar();
		}

		public function get empresa():EmpresaVO
		{
			return _empresa;
		}

		[Inject(source="empresaController.empresa", bind="true")]
		public function set empresa(value:EmpresaVO):void
		{
			_empresa = value;
		}

		public function get lista():ArrayCollection
		{
			return _lista;
		}

		[Inject(source="empresaController.lista", bind="true")]
		public function set lista(value:ArrayCollection):void
		{
			_lista = value;
		}

		public function get empresaId():int
		{
			return _empresaId;
		}

		public function set empresaId(value:int):void
		{
			_empresaId = value;
		}

		public function init():void
		{
			dispatcher.dispatchEvent(new EmpresaEvent(EmpresaEvent.LISTAR));
		}

		public function listaEmpresas_valueCommitHandler(event:FlexEvent):void
		{
			datagrid= DataGrid(event.currentTarget);
			empresa = datagrid.selectedItem as EmpresaVO;
			var ev:EmpresaEvent = new EmpresaEvent(EmpresaEvent.EMPRESA_SELECIONADA);
			ev.empresa = empresa;
			dispatcher.dispatchEvent(ev);
		}

		public function btnSalvar_clickHandler(event:MouseEvent):void
		{
			var ev:EmpresaEvent;
			if(_empresa.id && _empresa.id > 0){
				ev = new EmpresaEvent(EmpresaEvent.ATUALIZAR);
			} else {
				ev = new EmpresaEvent(EmpresaEvent.CRIAR);
			}
			ev.empresa = empresa;
			dispatcher.dispatchEvent(ev);
		}

		public function resetar():void
		{
			if(datagrid != null){
				datagrid.selectedIndex = -1;
			}
			empresa = new EmpresaVO();
		}

		public function quantidadeSocios(data:Object, col:GridColumn):String
		{
			return data.socios.length.toString();
		}

		public function abrirGerenciamentoSocios():void
		{
			_janelaSocios = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject, SociosUI, true) as SociosUI;
			_janelaSocios.width = 800;
			_janelaSocios.height = 400;
			PopUpManager.centerPopUp(_janelaSocios);
		}
	}
}


