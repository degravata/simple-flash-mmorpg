package com.fangtong.Net.SocketSever
{
	import com.fangtong.Net.SocketSever.Behavior.BDConn;
	import com.fangtong.Net.SocketSever.Behavior.BDHandlerClose;
	import com.fangtong.Net.SocketSever.Behavior.BDHandlerError;
	import com.fangtong.Net.SocketSever.Behavior.BDHandlerSecurity;
	import com.fangtong.Net.SocketSever.Behavior.BDPing;
	import com.fangtong.Net.SocketSever.Behavior.BDRec;
	import com.fangtong.Net.SocketSever.Behavior.BDSend;
	import com.fangtong.Net.SocketSever.Behavior.BDTran;
	import com.fangtong.Net.SocketSever.IBehavior.IBHandlerClose;
	import com.fangtong.Net.SocketSever.IBehavior.IBConn;
	import com.fangtong.Net.SocketSever.IBehavior.IBHandlerError;
	import com.fangtong.Net.SocketSever.IBehavior.IBHandlerSecurity;
	import com.fangtong.Net.SocketSever.IBehavior.IBPing;
	import com.fangtong.Net.SocketSever.IBehavior.IBSend;
	import com.fangtong.Net.SocketSever.IBehavior.IBRec;
	import com.fangtong.Net.SocketSever.IBehavior.IBTran;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import flash.errors.*;
	import flash.events.*;
	import flash.net.Socket;
	import flash.events.ProgressEvent;
	
	/**
	 * @author ao
	 */
	public class ClientSoket extends EventDispatcher{

		private var _socket:Socket
		private var _strIPAddr:String;
		private var _intPort:int;
		
		//var _numPingValue:Number=0;
		//var _numPingStart:Number=0;
		private var _intPingValue:Number=0;
		
		//var _IBConnectSend:IBSend;
		private var _IBPing:IBPing;
		private var _IBSend:IBSend;
		private var _IBRec:IBRec;
		private var _IBTran:IBTran;
		private var _IBConn:IBConn;
		
		private var _IBHandlerClose:IBHandlerClose;
		private var _IBHandlerError:IBHandlerError;
		private var _IBHandlerSecurity:IBHandlerSecurity
		
		private var _funPong:Function;
		private var _evPong:Event;
		
		public static const EVENT_GETPING:String = "EVENT_GETPING";
		private var _dispatchEventPong:Event;
		
		/**
		 * socket通讯
		 * @param	i_strIPAdd
		 * @param	i_intPort
		 */
		public function ClientSoket(i_strIPAdd:String,i_intPort:int) {
			_socket = new Socket();
			_strIPAddr = i_strIPAdd;
			_intPort = i_intPort;
			
			_funPong = this.DefaultPong;
			_evPong = new Event("evPong");
			_dispatchEventPong = new Event(EVENT_GETPING);
			
			
			_socket.addEventListener(Event.CONNECT, ConnectHandler,false,0,true);
			_socket.addEventListener(Event.CLOSE, CloseHandler,false,0,true);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, IoErrorHandler,false,0,true);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, SecurityErrorHandler,false,0,true);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, SocketDataHandler, false, 0, true);

			this.addEventListener("evPong", _funPong, false, 0, true);
		
			//_IBConnectSend = new BDSend();
			_IBPing = new BDPing();
			(_IBPing as BDPing).addEventListener("pong", OnEventPong, false, 0, true);
			
			_IBSend = new BDSend();
			_IBRec = new BDRec();
			_IBTran = new BDTran();
			_IBConn = new BDConn();
			
			_IBHandlerClose = new BDHandlerClose();
			_IBHandlerError = new BDHandlerError();
			_IBHandlerSecurity = new BDHandlerSecurity();
		}
		
		public function Ping():void {
			if (this.IsConnect) {
				//trace("ClientSocket Ping");
				this._IBPing.SendPing(this._socket, null);
			}
		}
		
		private function SetPing(i_IBPing:IBPing):void {
			this._IBPing = i_IBPing;
		}
		
		private function GetPing():IBPing {
			return this._IBPing;
		}
		
		//public function SetPongFunction(i_fun:Function):void {
			//trace("SetPongFunction", i_fun);
			//_funPong = i_fun;
		//}
		
		private function DefaultPong(e:Event):void {
			//trace("ping value:", e.currentTarget.GetPingValue());
			dispatchEvent(_dispatchEventPong);
		}

		/**
		 * 
		 * @param	event
		 */
		private function ConnectHandler(event:Event):void {
			//var byte = _IBConn.Conn(_socket);
			_IBConn.Conn(_socket);
		}

		private function SocketDataHandler(event:ProgressEvent):void {
			trace("socket size:"+_socket.bytesAvailable)
			//调用rec，把连续包拆开。
			var arrMsgPackages:Array = _IBRec.Rec(_socket);
			//解析包
			if(!_IBTran.Tran(_socket, arrMsgPackages)){
				//处理ping信息
				_IBPing.RecPong(arrMsgPackages);
			}
		}
		
		private function OnEventPong(e:Event):void {
			var o:IBPing = e.currentTarget as IBPing;
			this._intPingValue = o.GetPingValue();
			dispatchEvent(_evPong);
			//trace("OnEventPong",o.GetPingValue());
		}
		
		public function GetPingValue():int {
			return _intPingValue;
		}
		
		public function get IsConnect():Boolean {
			return this._socket.connected;
		}
		
		public function Close():void {
			if (this._socket.connected) {
				this._socket.close();
			}
		}
		
		public function Connect():void {
			if (!_socket.connected) {
				_socket.connect(this._strIPAddr, this._intPort);
			}
		}
		
		public function Rec():void {
			if (this._socket.connected){
				this._IBRec.Rec(this._socket);
			}
		}
		
		public function Tran(i_arr:Array):void {
			if (this._socket.connected){
				this._IBTran.Tran(this._socket, i_arr);
			}
		}
		
		public function Send(byteArr:ByteArray):void {
			if (this._socket.connected) {
				this._IBSend.Send(this._socket, byteArr);
			}
		}
		
		public function SetSend(i_IBSend:IBSend):void {
			this._IBSend = i_IBSend;
		}
		
		public function SetRec(i_IBRec:IBRec):void {
			this._IBRec = i_IBRec;
		}
		
		public function SetTran(i_IBTran:IBTran):void {
			this._IBTran = i_IBTran;
		}
		public function GetTran():IBTran {
			return this._IBTran;
		}
		
		public function SetConnect(i_IBConn:IBConn):void {
			this._IBConn = i_IBConn;
		}
		public function GetConnect():IBConn {
			return this._IBConn;
		}
		
		public function SetHandlerClose(i_IBHandlerClose:IBHandlerClose):void {
			this._IBHandlerClose = i_IBHandlerClose;
		}
		public function GetHandlerClose():IBHandlerClose {
			return this._IBHandlerClose;
		}
		private function CloseHandler(event:Event):void {
			this._IBHandlerClose.HandlerClose(_socket);
		}
		
		public function SetHandlerError(i_IBHandlerError:IBHandlerError):void {
			this._IBHandlerError = i_IBHandlerError;
		}
		public function GetHandlerError():IBHandlerError {
			return this._IBHandlerError;
		}
		private function IoErrorHandler(event:IOErrorEvent):void {
			this._IBHandlerError.HandlerError(_socket);
		}
		
		public function SetHandlerSecurity(i_IBHandlerSecurity:IBHandlerSecurity):void {
			this._IBHandlerSecurity = i_IBHandlerSecurity;
		}
		public function GetHandlerSecurity():IBHandlerSecurity {
			return this._IBHandlerSecurity;
		}
		private function SecurityErrorHandler(event:SecurityErrorEvent):void {
			this._IBHandlerSecurity.HandlerSecurity(_socket);
		}
	}
}