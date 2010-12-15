package com.gamefarmework.core.parttens.Observer
{
	public interface IObserver 
	{
		function RigisterNotificationHandle(notification:Object,handle:Function):void;
		function UpDataObserver(notification:Object, value:Object):void;
	}
}