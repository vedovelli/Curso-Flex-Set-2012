package com.vedovelli.vo
{
	[Bindable]
	[RemoteClass(alias="EmpresaVO")]
	public class EmpresaVO
	{
		public var id:int;
		public var razao_social:String;
		public var nome_fantasia:String;
		public var cnpj:String;
		public var endereco:String;
		public var socios:Array = new Array();
	}
}

