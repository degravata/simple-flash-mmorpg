package com.gamefarmework.core.parttens.Observer
{
	public interface IObservedObject 
	{

		/**
		 * 注册通知对应观察者 
		 * @param notification
		 * @param observer
		 * 
		 */
		function RegisterObserver(notification:Object, observer:IObserver):void;

		/**
		 * 移除通知对应观察者 
		 * @param notification
		 * @param observer
		 * 
		 */
		function RemoveObserver(notification:Object, observer:IObserver):void;

		/**
		 * 移除所有观察者 
		 * 
		 */
		function RemoveAllObserver():void;

		/**
		 * 移除观察者 
		 * @param observer
		 * 
		 */
		function RemoveObserverByObserver(observer:IObserver):void;

		/**
		 *  移除通知
		 * @param natification
		 * 
		 */
		function RemoveObserverByNotification(natification:Object):void;

		/**
		 * 通知观察者
		 * @param notification
		 * @param value
		 * 
		 */
		function NotifyObserver(notification:Object, value:Object = null):void;
	}
}