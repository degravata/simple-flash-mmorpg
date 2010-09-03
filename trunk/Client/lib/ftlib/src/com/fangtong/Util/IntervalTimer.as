package com.fangtong.Util
{
	public class IntervalTimer
	{
		/**
		 * 间隔时间 
		 */
		private var _interval:int;
		
		/**
		 * 目标时间 
		 */
		private var _current:int;
		
		public function IntervalTimer()
		{
			_interval = 0;
			_current = 0;
		}
		
		public function get current():int
		{
			return _current;
		}

		public function set current(value:int):void
		{
			_current = value;
		}

		public function get interval():int
		{
			return _interval;
		}

		
		public function set interval(value:int):void
		{
			_interval = value;
		}

		/**
		 * 更新 
		 * @param diff
		 * 
		 */
		public function Update(diff:int):void 
		{ 
			_current += diff; 
			if(_current < 0)
			{
				_current=0;
			}	
		}
		
		/**
		 * 是否通过时间 
		 * @return 
		 * 
		 */
		public function Passed():Boolean
		{ 
			return _current >= _interval; 
		}
		
		/**
		 * 复位 
		 * 
		 */
		public function Reset():void 
		{ 
			if(_current >= _interval) 
			{
				_current -= _interval;	
			}  
		}
	}
}