﻿package com.fangtong.Net.SocketSever.IBehavior 
{
	import flash.net.Socket;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Eric Wang
	 */
	public interface IBConn 
	{
		function Conn(i_soket:Socket):void;
	}
}