﻿package com.SS.Net.Behavior 
{
	import com.SS.Net.IBehavior.IBSend;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class BDSend implements IBSend
	{
		public function Send(i_soket:Socket, i_byteArr:ByteArray):void {
			i_soket.writeBytes(i_byteArr);
			i_soket.flush();
		}
	}

}