package com.vedovelli.vo
{
	[Bindable]
	[RemoteClass(alias="SocioVO")]
	public class SocioVO
	{
		public var id:int;
		public var empresa_id:int;
		public var usuario_id:int;
		public var nome:String;
		public var cpf:String;
		public var endereco:String;
		public var telefones:String;
	}
}

