package com.SS.Net.IBehavior 
{
	import flash.events.IEventDispatcher;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Eric Wang
	 */
	public interface IBTran
	{
		function Tran(i_soket:Socket, i_arr:Array):Boolean;
	}
}