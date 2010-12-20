package com.gamefarmework.core.Display
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class BmdAnimation extends Bitmap implements IAnimation
	{
		private var _curentFrame:int;
		private var _totalFrames:int;
		
		public function BmdAnimation(
			bitmapData:BitmapData=null,
			pixelSnapping:String="auto",
			smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		}
		
		public function get curentFrame():int
		{
			return 0;
		}
		
		public function get totalFrames():int
		{
			return 0;
		}
		
		public function gotoAndPlay(frame:int):void
		{
		}
		
		public function gotoAndStop(frame:int):void
		{
		}
		
		public function nextFrame():void
		{
		}
		
		public function prevFrame():void
		{
		}
		
		public function play():void
		{
		}
		
		public function stop():void
		{
		}
	}
}