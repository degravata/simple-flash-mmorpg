package com.SS.Net.Behavior 
{
	import com.SS.Net.IBehavior.IBPing;
	import com.SS.Net.MessagePackage;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class BDPing extends EventDispatcher implements IBPing 
	{
		private var evPong:Event;
		private var _pongValue:int;
		private var _pingValue:int;
		public var _during:int;
		
		public function BDPing():void {
			evPong = new Event("pong");
			_pongValue = 0;
			_pingValue = 0;
		}
		
		public function SendPing(i_soket:Socket, i_byteArr:ByteArray):void
		{
			if (i_soket.connected) {
				_pingValue = getTimer();
				
				var mp:MessagePackage = new MessagePackage();
				//默认ping action为1
				mp.SetPackageAction(1);
				
				if(null!=i_byteArr){
					mp.AddMsgDataByte(0, i_byteArr);
				}
				
				i_soket.writeBytes(mp.Package());
				//trace(mp.Package()[0],mp.Package()[1],mp.Package()[2],mp.Package()[3],mp.Package()[4],mp.Package()[5]);
				i_soket.flush();
			}
		}

		public function RecPong(i_arrMsgPackages:Array):void {
			for (var i:int = 0; i < i_arrMsgPackages.length; i++) {
				var mp:MessagePackage = new MessagePackage(i_arrMsgPackages[i]);
				var a:int = mp.GetPackageAction();
				switch(a) {
					//默认pong action 为2
					case 2:
						OnEventPong();
					break;
					default:
					break;
				}
			}
		}
		
		public function GetPingValue():int {
			return _during;
		}
		
		private function OnEventPong():void {
			_pongValue = getTimer();
			_during = this._pongValue-this._pingValue;
			dispatchEvent(evPong);
			//trace("during:", _during);
		}
	}
}