/* Extended from Abdul Qabiz original QueryString class
 * _rooturl and _isLocal added
 * you can find the original one by following http://www.abdulqabiz.com/blog/archives/2006/03/06/how-to-get-url-query-string-variables-within-flex-application/
 */

package com.vedovelli.util 
{
	import flash.external.*;
	import flash.utils.*;

	public class URLUtil 
	{

		private var _queryString:String;
		private var _all:String;
		private var _isLocal:Boolean = false;
		private var _rooturl:String;
		private var _params:Object;

		public function get queryString():String
		{
			return _queryString;
		}
		public function get rooturl():String
		{
			return _rooturl;
		}
		public function get url():String
		{
			return _all;
		}
		public function get isLocal():Boolean
		{
			return _isLocal;
		}
		public function get parameters():Object
		{
			return _params;
		}		


		public function URLUtil()
		{
			readQueryString();
		}

		private function readQueryString():void
		{
			_params = {};
			try 
			{
				_all =  ExternalInterface.call("window.location.href.toString");
				_queryString = ExternalInterface.call("window.location.search.substring", 1);
				_rooturl =  ExternalInterface.call("window.location.protocol.toString") + '//' + ExternalInterface.call("window.location.host.toString") + "/";
				if(ExternalInterface.call("window.location.host.toString") == "cf.local"){
					_isLocal = true;
				}

				if(_queryString)
				{

					var params:Array = _queryString.split('&');
					var length:uint = params.length;

					for (var i:uint=0,index:int=-1; i<length; i++) 
					{
						var kvPair:String = params[i];
						if((index = kvPair.indexOf("=")) > 0)
						{
							var key:String = kvPair.substring(0,index);
							var value:String = kvPair.substring(index+1);
							_params[key] = value;
						}
					}
				}
			}catch(e:Error) { trace("Some error occured. ExternalInterface doesn't work in Standalone player."); }
		}

		private static var _instance:URLUtil;
		public static function getInstance():URLUtil{
			if(_instance == null){
				_instance = new URLUtil();
			}
			return _instance;
		}

	}

}


