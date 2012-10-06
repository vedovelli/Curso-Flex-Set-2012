package com.vedovelli.presentation
{
	import flash.events.MouseEvent;

	import spark.components.DataGrid;
	import spark.components.DropDownList;

	[Bindable]
	public class UsuariosPresentationModel extends BasePresentationModel
	{
		import com.vedovelli.event.UsuariosEvent;
		import com.vedovelli.vo.UsuarioVO;

		import mx.collections.ArrayCollection;
		import mx.events.FlexEvent;

		private var _usuarioId:int;
		private var _lista:ArrayCollection;
		private var _listaNiveis:ArrayCollection;
		private var _usuario:UsuarioVO;
		private var _remover_registro:Boolean;
		private var _limpar:Boolean;
		private var _datagrid:DataGrid;
		private var _cbNiveis:DropDownList;


		public function get cbNiveis():DropDownList
		{
			return _cbNiveis;
		}

		public function set cbNiveis(value:DropDownList):void
		{
			_cbNiveis = value;
		}

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

		[Inject(source="usuariosController.remover_registro", bind="true")]
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

		[Inject(source="usuariosController.limpar", bind="true")]
		public function set limpar(value:Boolean):void
		{
			_limpar = value;
			resetar();
		}

		public function get usuario():UsuarioVO
		{
			return _usuario;
		}

		[Inject(source="usuariosController.usuario", bind="true")]
		public function set usuario(value:UsuarioVO):void
		{
			_usuario = value;
		}

		public function get listaNiveis():ArrayCollection
		{
			return _listaNiveis;
		}

		public function set listaNiveis(value:ArrayCollection):void
		{
			_listaNiveis = value;
		}


		public function get lista():ArrayCollection
		{
			return _lista;
		}

		[Inject(source="usuariosController.lista", bind="true")]
		public function set lista(value:ArrayCollection):void
		{
			_lista = value;
		}

		public function get usuarioId():int
		{
			return _usuarioId;
		}

		public function set usuarioId(value:int):void
		{
			_usuarioId = value;
		}

		public function init():void
		{
			dispatcher.dispatchEvent(new UsuariosEvent(UsuariosEvent.LISTAR));
		}

		public function selecionarDDList():void
		{
			var i:int = 0;
			var length:int = _listaNiveis.length;

			for (i; i < length; i++) 
			{
				if(_usuario != null){
					if( _listaNiveis.getItemAt(i).data == _usuario.nivel ){
						cbNiveis.selectedIndex = i;
						break;
					}
				}
			}
		}

		public function listaUsuarios_valueCommitHandler(event:FlexEvent):void
		{
			datagrid= DataGrid(event.currentTarget);
			usuario = datagrid.selectedItem as UsuarioVO;
			selecionarDDList();
		}

		public function btnSalvar_clickHandler():void
		{
			var ev:UsuariosEvent;
			if(_usuario.id && _usuario.id > 0){
				ev = new UsuariosEvent(UsuariosEvent.ATUALIZAR);
			} else {
				ev = new UsuariosEvent(UsuariosEvent.CRIAR);
			}
			ev.usuario = usuario;
			dispatcher.dispatchEvent(ev);
		}

		public function resetar():void
		{
			if(datagrid != null){
				datagrid.selectedIndex = -1;
			}
			if(cbNiveis != null){
				cbNiveis.selectedIndex = 0;
			}
			usuario = new UsuarioVO();
			usuario.nivel = cbNiveis.selectedItem.data;
		}


		public function listaNiveis_valueCommitHandler(event:FlexEvent):void
		{
			usuario.nivel = cbNiveis.selectedItem.data;
		}

		public function listaNiveis_creationCompleteHandler(event:FlexEvent):void
		{
			listaNiveis = new ArrayCollection([
				{data: 'administrador', label: 'Administrador'},
				{data: 'usuario', label: 'Usuário'}
				]);

			cbNiveis = event.currentTarget as DropDownList;
			cbNiveis.selectedIndex= 0;
			usuario.nivel = cbNiveis.selectedItem.data;
		}
	}
}

