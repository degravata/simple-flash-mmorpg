package com.fangtong.DesignPatterns.MVC.Controller
{
	public interface IController
	{
		/**
		 * 初始化绑定
		 */
		function InitialBind():void;
		/**
		 * 卸载绑定
		 * @param	obj
		 */
		function DestroyBind(obj:Object = null):void;
	}
}