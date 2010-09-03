package com.fangtong.DesignPatterns.MVC.View 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author fangtong
	 */
	public interface IView 
	{
		/**
		 * 设置显示目标
		 * @param	val
		 */
		function SetViewTarget(val:DisplayObject):void;
		/**
		 * 获得显示目标
		 * @return
		 */
		function GetViewTarget():DisplayObject;
		/**
		 * 初始化完成
		 */
		function InitComplete():void;
		/**
		 * 析构函数
		 */
		function Destructor():void;
		/**
		 * 增加到管理类 
		 * @return
		 */
		function InsertToManage(type:Object,key:Object,value:Object):Boolean;
		
		/**
		 * 从管理类中删除
		 * @return
		 */
		function DestroyToManage(type:Object,key:Object):Boolean;
	}
	
}