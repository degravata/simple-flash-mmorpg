package com.fangtong.DesignPatterns.MVC.Model 
{
	
	/**
	 * ...
	 * @author fangtong
	 */
	public interface IModel 
	{
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
		 * 
		 */
		function InsertToManage(type:Object,key:Object,value:Object):Boolean;
		
		/**
		 * 从管理类中删除
		 * 
		 */
		function DestroyToManage(type:Object,key:Object):Boolean;
	}
	
}