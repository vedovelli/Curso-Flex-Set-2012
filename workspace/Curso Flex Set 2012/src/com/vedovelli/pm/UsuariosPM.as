package com.vedovelli.pm
{
	import com.vedovelli.event.UsuariosEvent;
	import com.vedovelli.vo.UsuarioVO;

	import flash.events.MouseEvent;

	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;

	import spark.components.DataGrid;
	import spark.components.DropDownList;

	public class UsuariosPM extends BasePM
	{

		[Bindable]
		public var cbNiveis:DropDownList;

		[Bindable]
		public var listaUsuarios:DataGrid;

		[Bindable]
		public var usuarioId:int;

		[Bindable]
		public var listaNiveis:ArrayCollection;

		[Bindable]
		[Inject(source="usuariosController.usuario", bind="true")]
		public var usuario:UsuarioVO;

		[Bindable]
		[Inject(source="usuariosController.lista", bind="true")]
		public var lista:ArrayCollection;

		[Inject(source="usuariosController.removido", bind="true")]
		public function set removido(value:Boolean):void
		{
			if(lista != null && listaUsuarios != null){
				lista.removeItemAt(listaUsuarios.selectedIndex);
				limpar();
			}
		}

		[Inject(source="usuariosController.limpar", bind="true")]
		public function set setLimpar(value:Boolean):void
		{
			limpar();
		}

		public function init(event:FlexEvent):void
		{
			this.dispatcher.dispatchEvent( new UsuariosEvent(UsuariosEvent.LISTAR) );
		}

		public function selecionarDDList():void
		{
			if( cbNiveis != null ){
				var i:int = 0;
				var length:int = listaNiveis.length;

				for (i; i < length; i++) 
				{
					if(usuario != null){
						if( listaNiveis.getItemAt(i).data == usuario.nivel ){
							cbNiveis.selectedIndex = i;
							break;
						}
					}
				}
			}
		}

		public function listaUsuarios_valueCommitHandler(event:FlexEvent):void
		{
			listaUsuarios = event.currentTarget as DataGrid;
			usuario = listaUsuarios.selectedItem as UsuarioVO;
			selecionarDDList();
		}

		public function btnSalvar_clickHandler(event:MouseEvent):void
		{
			var ev:UsuariosEvent;
			if(usuario.id && usuario.id > 0){
				ev = new UsuariosEvent(UsuariosEvent.ATUALIZAR);
			} else {
				ev = new UsuariosEvent(UsuariosEvent.CRIAR);
			}
			ev.usuario = usuario;
			dispatcher.dispatchEvent(ev);
		}

		public function limpar():void
		{
			usuario = new UsuarioVO();

			if(listaUsuarios!=null){
				listaUsuarios.selectedIndex = -1;
			}
			if(cbNiveis != null){
				cbNiveis.selectedIndex = 0;
				usuario.nivel = cbNiveis.selectedItem.data;
			}
		}

		public function listaNiveis_valueCommitHandler(event:FlexEvent):void
		{
			if(usuario != null){
				usuario.nivel = cbNiveis.selectedItem.data;
			}
		}

		public function listaNiveis_creationCompleteHandler(event:FlexEvent):void
		{
			cbNiveis = event.currentTarget as DropDownList;
			cbNiveis.selectedIndex= 0;

			listaNiveis = new ArrayCollection([
				{data: 'administrador', label: 'Administrador'},
				{data: 'usuario', label: 'Usuário'}
				]);

			usuario = new UsuarioVO();			
			usuario.nivel = listaNiveis.getItemAt(0).data;
		}

	}
}

