package com.gamefarmework.core.mvc
{
	import flash.display.DisplayObject;

	public interface IView
	{

		/**
		 * 设置显示 
		 * @param view
		 * 
		 */
		function SetDisplay(view:DisplayObject):void;

		/**
		 * 获取显示 
		 * 
		 */
		function GetDisplay():DisplayObject;

		/**
		 * 增加 显示对象事件
		 * @param e
		 * 
		 */
		function onInsertDisplayEvent(e:Object):void;

		/**
		 * 移除 显示对象事件 
		 * @param e
		 * 
		 */
		function onRemoveDisplayEvent(e:Object):void;

		/**
		 * 销毁对象 
		 * 
		 */
		function Destroy():void;
	}
}