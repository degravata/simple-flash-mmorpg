package Up.Game.Sever
{
	import com.SS.Net.IBehavior.IBConn;
	import com.SS.Net.MessagePackage;
	
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class SocketBeConnect implements IBConn
	{
		private var _connect_fun:Function = null;
		
		public function SocketBeConnect(i_connect_fun:Function = null)
		{
			_connect_fun = i_connect_fun;	
		}
		
		public function Conn(i_soket:Socket):void
		{
			trace("connect ok!");
//			var byte:ByteArray = WriteItemHandle.WritePlayerLandHandle();
//			i_soket.writeBytes(byte);
//			i_soket.flush();
			if(_connect_fun != null)
				_connect_fun();
		}
	}
}