package com.gamefarmework.core.parttens.Observer
{
	import flash.utils.Dictionary;

	public class ObservedObject implements IObservedObject
	{
		private var _dic:Dictionary;
		
		public function ObservedObject()
		{
			_dic = new Dictionary();
		}
		
		public function RegisterObserver(notification:Object, observer:IObserver):void
		{
			if(_dic[notification] == null)
			{
				_dic[notification] = new Vector.<IObserver>();
			}
			
			var vct:Vector.<IObservedObject> = _dic[notification];
			for each(var obs:IObservedObject in vct)
			{
				if(obs == observer) return;
			}
			
			vct.push(observer);
		}
		
		public function RemoveObserver(notification:Object, observer:IObserver):void
		{
			var vct:Vector.<IObserver> = _dic[notification];
			//判断是否有此通知列表
			if(vct == null)
			{
				return;
			}
			//遍历此通知所拥有的观察者 并移除之
			var i:int = 0;
			for each(var obs:IObserver in vct)
			{
				if(obs == observer) 
				{
					vct.splice(i,1);
					break;
				};
				i++;
			}
			//此通知拥有观察者为0时 移除此通知列表
			if(vct.length == 0)
			{
				_dic[notification] = null;
				delete _dic[notification];
			}
		}
		
		public function RemoveAllObserver():void
		{
			for(var key:Object in _dic)
			{
				if(_dic[key] != null)
				{
					_dic[key].splice(0,_dic[key].length)
					_dic[key] = null;
				}
				delete _dic[key];
			}
		}
		
		public function RemoveObserverByObserver(observer:IObserver):void
		{
			for(var key:Object in _dic)
			{
				RemoveObserver(key,observer);
			}
		}
		
		public function RemoveObserverByNotification(natification:Object):void
		{
			for(var key:Object in _dic)
			{
				if(key == natification)
				{
					_dic[key].splice(0,_dic[key].length)
					_dic[key] = null;
				}
				delete _dic[key];
				break;
			}
		}
		
		public function NotifyObserver(notification:Object, value:Object):void
		{
			var vct:Vector.<IObservedObject> = _dic[notification];
			//判断是否有此通知列表
			if(vct == null)
			{
				return;
			}
			for each(var obs:IObserver in vct)
			{
				obs.UpDataObserver(notification,value);
			}
		}
	}
}