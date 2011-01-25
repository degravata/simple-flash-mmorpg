package com.gamefarmework.core.Display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	

	public class BmdAnimation extends Bitmap implements IAnimation
	{
		private var _curFrame:int;
		private var _totFrame:int;
		private var _isPlay:Boolean;
		
		private var _frameList:Vector.<BitmapData>;
		private var _oldFrame:int;
		
		public function BmdAnimation()
		{
			_curFrame = 0;
			_totFrame = 0;
			_isPlay = false;
			_frameList = new Vector.<BitmapData>;
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE,DestroyEvent);
		}
		
		private function DestroyEvent(e:Event):void
		{
			StopAnimation();
		}
		
		private function set isPlay(value:Boolean):void
		{
			if(_isPlay != value)
			{
				_isPlay = value;
				if(_isPlay)
				{
					this.addEventListener(Event.ENTER_FRAME,onRender);
				}else{
					this.removeEventListener(Event.ENTER_FRAME,onRender);
				}
			}
		}
		
		private function onRender(e:Event):void
		{
			var oldFrame:int = _curFrame;
			var endFrame:int = _totFrame - 1;
			if(oldFrame >= endFrame)
			{
				_curFrame = 0;
			}else{
				_curFrame++;
			}
			//render
			bitmapData = _frameList[_curFrame];
		}
		
		//////////////////////////////////////////////////////////////////////////
		//设置动画帧及位图
		public function SetFrameBmd(frame:int,bmd:BitmapData):void
		{
			if(_frameList.length < frame) 
			{
				_frameList.length = frame;
			}
			_frameList[frame] = bmd;
			_totFrame = _frameList.length;
		}
		
		public function SetFrameBmdList(bmds:Vector.<BitmapData>):void
		{
			_frameList = bmds;
			_totFrame = _frameList?_frameList.length:0;
		}
		public function GetFrameBmdList():Vector.<BitmapData>
		{
			return _frameList;
		}
		
		public function DelFrameBmd(frame:int):void
		{
			if(frame<_frameList.length)
			{
				_frameList.splice(frame,1);
				_totFrame = _frameList.length;
			}
		}
		
		//////////////////////////////////////////////////////////////////////////
		//Animation实现
		public function StartAnimation():void
		{
			isPlay = true;
		}
		
		public function StopAnimation():void
		{
			isPlay = false;
			ResetAnimation();
		}
		
		public function PauseAnimation():void
		{
			isPlay = false;
		}
		
		public function ResetAnimation():void
		{
			_curFrame = 0;
		}
		
		public function isAnimation():Boolean
		{
			return _isPlay;
		}

		///////////////////////////////////////////////////////////////////////////
	}
}