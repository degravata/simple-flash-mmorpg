package com.gamefarmework.core.mvc
{
	
	public interface IModel 
	{

		/**
		 * 销毁对象 
		 * 
		 */
		function Destroy():void;

		/**
		 * 获取代理 
		 * @return 
		 * 
		 */
		function GetProxy():IProxy;

		/**
		 * 设置代理 
		 * @param proxy
		 * 
		 */
		function SetProxy(proxy:IProxy):void;
	}
}