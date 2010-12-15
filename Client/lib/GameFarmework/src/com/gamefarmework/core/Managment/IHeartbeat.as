package com.gamefarmework.core.Managment
{
	public interface IHeartbeat 
	{

		function StartHeartbeat():void;

		function StopHeartbeat():void;

		function UpHeartbeatHandle(time:int):void;

		function RegisterTimeHandle(time:int, handle:Function):void;

		function RemoveTimeHandle(time:int, handle:Function):void;
	}
}