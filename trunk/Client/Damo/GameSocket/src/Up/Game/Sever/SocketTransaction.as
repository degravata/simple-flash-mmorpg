package Up.Game.Sever
{
	import com.SS.Net.IBehavior.IBSend;
	import com.SS.Net.IBehavior.IBTran;
	import com.SS.Net.MessagePackage;
	
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class SocketTransaction implements IBTran,IBSend
	{
		
		public function SocketTransaction()
		{
			
		}
		
		public function Tran(i_soket:Socket, i_arrMsgPackages:Array):Boolean {
			
			//var ii:int = 0;
			for each(var arr:ByteArray in i_arrMsgPackages)
			{
				/*
				var str:String = "";
				for(var i:int = 0;i<arr.length; i++)
				{
					str +=arr[i]+" / "	
				}
				trace("ByteArray:"+ii+" str:" + str);
				*/
				var pack:MessagePackage = new MessagePackage(arr);
				var action:int = pack.GetPackageAction();
				//trace(action)
				ReadHandleProxy.ProxyHandle[action](pack);
				//ii++;
			}
			return true;
		}
		
		public function Send(i_soket:Socket, i_byteArr:ByteArray):void {
			if (i_soket.connected){
				i_soket.writeBytes(i_byteArr);
				i_soket.flush();
			}
		}
		
	}
}