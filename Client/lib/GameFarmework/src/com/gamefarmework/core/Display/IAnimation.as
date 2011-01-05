package com.gamefarmework.core.Display
{
	
	/**
	 * ...
	 * @author FangTong
	 */
	public interface IAnimation 
	{
		
		/**
		 * 播放动画
		 */
		function StartAnimation():void;
		
		/**
		 * 停止播放动画
		 */
		function StopAnimation():void;
		
		/**
		 * 暂停播放动画
		 */
		function PauseAnimation():void;
		
		/**
		 * 动画复位
		 */
		function ResetAnimation():void;
		/**
		 * 是否正在播放 
		 * @return 
		 * 
		 */
		function isAnimation():Boolean
	}
	
}