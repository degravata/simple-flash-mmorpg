package com.gamefarmework.core.parttens.Observer
{
	public interface IObservedObject 
	{

		function RegisterObserver(notification:Object, observer:IObserver):void;

		function RemoveObserver(notification:Object, observer:IObserver):void;

		function RemoveAllObserver():void;

		function RemoveObserverByObserver(observer:IObserver):void;

		function RemoveObserverByNotification(natification:Object):void;

		function NotifyObserver(notification:Object, value:Object):void;
	}
}