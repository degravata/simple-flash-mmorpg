package com.fangtong.Net.SocketSever.IBehavior 
{
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Eric Wang
	 */
	public interface IBPing
	{
		function SendPing(i_soket:Socket, i_byteArr:ByteArray):void;
		function RecPong(i_arrMsgPackages:Array):void;
		
		function GetPingValue():int;
	}
	
}