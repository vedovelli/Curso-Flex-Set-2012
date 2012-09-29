package com.vedovelli.vo
{
	[Bindable]
	[RemoteClass(alias="UsuarioVO")]
	public class UsuarioVO
	{
		public var id:int;
		public var usuario:String;
		public var senha:String;
		public var nivel:String;
	}
}