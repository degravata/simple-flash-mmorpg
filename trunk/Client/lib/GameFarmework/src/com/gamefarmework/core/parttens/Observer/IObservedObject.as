package com.gamefarmework.core.parttens.Observer
{
	public interface IObservedObject 
	{

		public function RegisterObserver(notification:Object, observer:IObserver):void;

		public function RemoveObserver(notification:Object, observer:IObserver):void;

		public function RemoveAllObserver():void;

		public function RemoveObserverByObserver(observer:IOserver):void;

		public function RemoveObserverByNotification(natification:Object):void;

		public function NotifyObserver(notification:Object, value:Object):void;
	}
}