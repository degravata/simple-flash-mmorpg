package com.gamefarmework.core.parttens.Observer
{
	public interface IObserver 
	{
		/**
		 *  注册通知对应的处理
		 * @param notification
		 * @param handle
		 * 
		 */
		function RigisterNotificationHandle(notification:Object,handle:Function):void;
		/**
		 * 移除通知对应的处理
		 * @param notification
		 * @param handle
		 * 
		 */
		function RemoveNotificationHandle(notification:Object,handle:Function):void;
		/**
		 * 更新通知事件 
		 * @param notification
		 * @param value
		 * 
		 */
		function UpDataObserver(notification:Object, value:Object):void;
	}
}