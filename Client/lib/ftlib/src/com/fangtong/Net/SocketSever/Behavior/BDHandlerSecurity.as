package com.fangtong.Net.SocketSever.Behavior 
{
	import flash.net.Socket;
	import com.fangtong.Net.SocketSever.IBehavior.IBHandlerSecurity;
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class BDHandlerSecurity implements IBHandlerSecurity
	{
		
		public function BDHandlerSecurity() 
		{
			
		}
		
		public function HandlerSecurity(i_soket:Socket):void {
			//var bytes:ByteArray = new ByteArray;
			//i_soket.readBytes(bytes);
			//var mpm:MsgPackageManage = new MsgPackageManage(bytes);
			//var arrMsgPackages:Array = mpm.GetMsgPackages();
			//return arrMsgPackages;
			
			trace("SecurityErrorHandler");
		}
		
	}

}