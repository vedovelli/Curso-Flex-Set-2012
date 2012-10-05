package com.vedovelli.presentation
{
	import flash.events.MouseEvent;
	
	import spark.components.DataGrid;
	import spark.components.DropDownList;

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

		[Inject(source="empresasController.remover_registro", bind="true")]
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

		[Inject(source="empresasController.limpar", bind="true")]
		public function set limpar(value:Boolean):void
		{
			_limpar = value;
			resetar();
		}

		public function get empresa():EmpresaVO
		{
			return _empresa;
		}

		[Inject(source="empresasController.empresa", bind="true")]
		public function set empresa(value:EmpresaVO):void
		{
			_empresa = value;
		}

		public function get lista():ArrayCollection
		{
			return _lista;
		}

		[Inject(source="empresasController.lista", bind="true")]
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
	}
}
