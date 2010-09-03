package com.fangtong.Net.SocketSever.Behavior 
{
	import com.fangtong.Net.SocketSever.IBehavior.IBRec;
	import com.fangtong.Net.PackageMsg.MsgPackageManage;
	//import com.fangtong.Net.SocketSever.IBehavior.IBTran;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class BDRec implements IBRec
	{
		//默认的接收函数，负责把iocp的连续包解成数组。
		public function Rec(i_soket:Socket):Array {
			var bytes:ByteArray = new ByteArray;
			i_soket.readBytes(bytes);
			var mpm:MsgPackageManage = new MsgPackageManage(bytes);
			var arrMsgPackages:Array = mpm.GetMsgPackages();
			return arrMsgPackages;
		}
	}
}