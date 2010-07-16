package com.SS.Net.Behavior 
{
	import com.SS.Net.IBehavior.IBRec;
	import com.SS.Net.MsgPackageManage;
	//import com.SS.Net.IBehavior.IBTran;
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