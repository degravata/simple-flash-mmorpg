package com.SS.Net.Behavior 
{
	import com.SS.Net.IBehavior.IBConn;
	import com.SS.Net.MessagePackage;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class BDConn implements IBConn
	{
		private var _ba:MessagePackage;
		
		public function BDConn() {
			
		}
		
		public function Conn(i_soket:Socket):void {
			_ba = new MessagePackage();
			_ba.SetPackageAction(1);
			//_ba.AddMsgData(2, new ByteArray());
			//_ba.AddMsgDataByte(2, new ByteArray());
			i_soket.writeBytes(_ba.Package());
			i_soket.flush();
		}
	}
}