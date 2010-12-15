package com.gamefarmework.core.parttens.Observer
{
	import flash.utils.Dictionary;

	public class Observer implements IObserver
	{
		private var _dic:Dictionary
		
		public function Observer()
		{
			_dic = new Dictionary();
		}
		
		public function RigisterNotificationHandle(
			notification:Object,
			handle:Function):void
		{
			if(_dic[notification] != null)
			{
				_dic[notification] = new Vector.<Function>;
			}
			
			var vct:Vector.<Function> = _dic[notification];
			for each(var fun:Function in vct)
			{
				if(fun == handle) return;
			}
			
			vct.push(handle);
		}
		
		public function RemoveNotificationHandle(
			notification:Object,
			handle:Function):void
		{
			if(_dic[notification] != null)
			{
				return;
			}
			var vct:Vector.<Function> = _dic[notification];
			var i:int = 0;
			for each(var fun:Function in vct)
			{
				if(fun == handle)
				{
					vct.splice(i,1);
					break;
				};
				i++
			}
			
			if(vct.length == 0)
			{
				_dic[notification] = null;
				delete _dic[notification];
			}
		}
		
		public function UpDataObserver(notification:Object, value:Object):void
		{
			var vct:Vector.<Function> = _dic[notification];
			if(vct == null) return;
			
			for each(var fun:Function in vct)
			{
				fun(value);
			}
		}
	}
}