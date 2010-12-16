package com.gamefarmework.core.Managment
{
	import com.gamefarmework.util.time.IntervalTime;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class Heartbeat implements IHeartbeat
	{
		/**
		 * this:[key:<v>time int</v>,value:<v>dic dictionary</v>]
		 * <br>
		 * dic: [key:<v>handle function</v>,value:<v>interval IntervalTime</v>] 
		 */
		private var _heratbeatDic:Dictionary;
		private var _time:Timer;
		private var _clstime:int = 0;
		private static var _instance:Heartbeat;
		
		public static function GetInstance():IHeartbeat
		{
			if(_instance == null) _instance = new Heartbeat();
			return _instance;
		}
		
		public function Heartbeat()
		{
			_heratbeatDic = new Dictionary();
			_time = new Timer(1);
			_time.addEventListener(TimerEvent.TIMER,onTimerHandle);
		}
		
		public function StartHeartbeat():void
		{
			_clstime = getTimer();
			_time.start();
		}
		
		public function StopHeartbeat():void
		{
			_time.stop();
		}
		
		private function onTimerHandle(e:TimerEvent):void
		{
			var diff:int = getTimer() - _clstime;
			_clstime = getTimer();
			UpHeartbeatHandle(diff);
		}
		
		public function UpHeartbeatHandle(time:int):void
		{
			var interval:IntervalTime = null;
			for each(var dic:Dictionary in _heratbeatDic)
			{
				for(var handle:Object in dic)
				{
					interval = dic[handle];
					interval.Update(time);
					while(interval.Passed())
					{
						handle();
						interval.Reset();
					}
				}
			}
		}
		
		public function RegisterTimeHandle(time:int, handle:Function):void
		{
			if(_heratbeatDic[time] == null)
			{
				_heratbeatDic[time] = new Dictionary();
			}
			var dic:Dictionary = _heratbeatDic[time]
			var interval:IntervalTime =  new IntervalTime();
			interval.SetCurrent(0);
			interval.SetInterval(time);
			dic[handle] = interval;
		}
		
		public function RemoveTimeHandle(time:int, handle:Function):void
		{
			if(_heratbeatDic[time] == null)
			{
				return;
			}
			
			var dic:Dictionary = _heratbeatDic[time];
			if(dic[handle] != null)
			{
				dic[handle] = null;
				delete dic[handle];
			}
		}
	}
}