package com.gamefarmework.core.Managment
{
	public interface IHeartbeat 
	{

		public function StartHeartbeat():void;

		public function StopHeartbeat():void;

		public function UpHeartbeatHandle(time:int):void;

		public function RegisterTimeHandle(time:int, handle:Function):void;

		public function RemoveTimeHandle(time:int, handle:Function):void;
	}
}