package com.fangtong.DesignPatterns.Event
{
	public interface IEventDespatcher
	{
		/**
		 * 增加时间监听
		 * @param	i_objEvent
		 * @param	i_callbackFunc
		 */
		function AddEventListener(i_objEvent:Object, i_callbackFunc:Function):void;
		/**
		 * 移除事件监听
		 * @param	i_objEvent
		 * @param	i_func
		 */
		function RemoveEventListener(i_objEvent:Object, i_func:Function = null):void;
		/**
		 * 移除对象所有监听
		 */
		function RemoveAllEventListener():void;
		/**
		 * 派发事件
		 * @param	i_objEvent
		 * @param	i_o
		 */
		function DespatcherEvent(i_objEvent:Object,i_o:Object = null):void;
	}
}