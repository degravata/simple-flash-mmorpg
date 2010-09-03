package com.fangtong.Net.SocketSever.IBehavior
{
	import flash.net.Socket;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Eric Wang
	 */
	public interface IBSend 
	{
		//function Send(i_byteArr:ByteArray):MyByteArray;
		
		function Send(i_soket:Socket,i_byteArr:ByteArray):void;
		
		//function SendByByteArr(i_Byte:ByteArray):ByteArray;
		//function SendByMyByteArr(i_Byte:MyByteArray):ByteArray;
	}
}