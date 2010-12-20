package com.gamefarmework.core.Display
{
	
	/**
	 * ...
	 * @author FangTong
	 */
	public interface IAnimation 
	{
		/**
		 * [只读 (read-only)] 所处的帧。 
		 */
		function get curentFrame():int;
		/**
		 * [只读 (read-only)] 帧的总数。
		 */
		function get totalFrames():int;
		
		/**
		 * 从指定帧开始播放
		 * @param	frame 帧
		 */
		function gotoAndPlay(frame:int):void
		/**
		 * 移到指定帧并停在那里。 
		 * @param	frame 帧
		 */
		function gotoAndStop(frame:int):void
		
		/**
		 * 转到下一帧并停止。 
		 */
		function nextFrame():void;
		/**
		 * 转到前一帧并停止。 
		 */
		function prevFrame():void;
		
		/**
		 * 从当前帧开始播放
		 */
		function play():void;
		/**
		 * 停在当前帧
		 */
		function stop():void;
	}
	
}