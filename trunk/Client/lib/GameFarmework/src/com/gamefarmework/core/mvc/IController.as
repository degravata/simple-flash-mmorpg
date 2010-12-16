package com.gamefarmework.core.mvc
{

	public interface IController 
	{

		/**
		 * 注册通知及处理方式 
		 * 
		 */
		function RegisterObservedNotification():void;

		/**
		 * 移除通知及处理方式 
		 * 
		 */
		function ReomveObservedNotification():void;
	}
}