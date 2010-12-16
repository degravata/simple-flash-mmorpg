package com.gamefarmework.core.mvc
{

	public interface IProxy  
	{
		/**
		 * 设置代理处理方式 
		 * @param name		代理名
		 * @param handle	处理
		 * 
		 */
		function SetProperty(name:Object, handle:Function):void
		/**
		 * 处理代理 
		 * @param name	代理名
		 * @param value	传入值
		 * 
		 */
		function CallProperty(name:Object,value:Object):void

		/**
		 * 删除代理 
		 * @param name 代理名
		 * @return 
		 * 
		 */
		function DeleteProperty(name:Object):Boolean

		/**
		 * 获取代理对应处理 
		 * @param name
		 * @return 
		 * 
		 */
		function GetProperty(name:Object):Function
		/**
		 * 查看是否含有对应代理 
		 * @param name
		 * @return 
		 * 
		 */
		function HasProperty(name:Object):Boolean

	}
}