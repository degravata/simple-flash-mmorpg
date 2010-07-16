package com.SS.Net.Behavior 
{
	import flash.net.Socket;
	import com.SS.Net.IBehavior.IBHandlerClose;
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class BDHandlerClose implements IBHandlerClose
	{
		
		public function BDHandlerClose() 
		{
			
		}
		
		public function HandlerClose(i_soket:Socket):void {
			//_ba = new MessagePackage();
			//_ba.SetPackageAction(1);
			//_ba.AddMsgData(2, new ByteArray());
			//_ba.AddMsgDataByte(2, new ByteArray());
			//i_soket.writeBytes(_ba.Package());
			//i_soket.flush();
			
			trace("CloseHandler");
		}
		
	}

}