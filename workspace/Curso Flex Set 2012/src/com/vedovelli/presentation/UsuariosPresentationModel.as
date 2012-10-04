package com.vedovelli.presentation
{
	import flash.events.MouseEvent;

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

		public function get remover_registro():Boolean
		{
			return _remover_registro;
		}

		[Inject(source="usuariosController.remover_registro", bind="true")]
		public function set remover_registro(value:Boolean):void
		{
			_remover_registro = value;
//			if(listaUsuarios != null && lista != null){
//				lista.removeItemAt(listaUsuarios.selectedIndex);
//				resetar();
//			}
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

		public function init(event:FlexEvent):void
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
//						cbNiveis.selectedIndex = i;
						break;
					}
				}
			}
		}

		public function listaUsuarios_valueCommitHandler(event:FlexEvent):void
		{
			usuario = event.currentTarget.selectedItem as UsuarioVO;
			selecionarDDList();
		}

		public function btnSalvar_clickHandler(event:MouseEvent):void
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
//			if(listaUsuarios!=null && cbNiveis != null){
//				listaUsuarios.selectedIndex = -1;
//				cbNiveis.selectedIndex = 0;
//				usuario = new UsuarioVO();
//				usuario.nivel = cbNiveis.selectedItem.data;
//			}
		}


		public function listaNiveis_valueCommitHandler(event:FlexEvent):void
		{
//			_usuario.nivel = cbNiveis.selectedItem.data;
		}

		public function listaNiveis_creationCompleteHandler(event:FlexEvent):void
		{
			listaNiveis = new ArrayCollection([
				{data: 'administrador', label: 'Administrador'},
				{data: 'usuario', label: 'Usuário'}
				]);
//			cbNiveis.selectedIndex= 0;
//			_usuario.nivel = cbNiveis.selectedItem.data;
		}

		function UsuariosPresentationModel():void{
			dispatcher.dispatchEvent(new UsuariosEvent(UsuariosEvent.LISTAR));
		}
	}
}

