package com.gamefarmework.core.mvc
{
	import com.gamefarmework.core.parttens.Observer.IObservedObject;
	import com.gamefarmework.core.parttens.Observer.IObserver;
	import com.gamefarmework.core.parttens.Observer.ObservedObject;
	import com.gamefarmework.core.parttens.Observer.Observer;
	
	import flash.utils.Dictionary;
	
	public class AbsProxy implements IProxy
	{
		private var _observer:IObserver;
		private var _observedObject:IObservedObject;
		private var _propertyDic:Dictionary;
		
		public function AbsProxy()
		{
			_observer = new Observer()
			_observedObject = new ObservedObject();
			_propertyDic = new Dictionary();
		}
		
		public function SetProperty(name:Object, handle:Function):void
		{
			_propertyDic[name] = handle;
		}
		
		public function CallProperty(name:Object, value:Object):void
		{
			if(_propertyDic[name] == null) return;
			_propertyDic[name](value);
		}
		
		public function DeleteProperty(name:Object):Boolean
		{
			if(_propertyDic[name] != null)
			{
				_propertyDic[name] = null;
				delete _propertyDic[name];
				return true;
			}
			return false;
		}
		
		public function GetProperty(name:Object):Function
		{
			return _propertyDic[name];
		}
		
		public function HasProperty(name:Object):Boolean
		{
			return _propertyDic[name] != null;
		}
		
		
		/**
		 * 获取本对象 - 观察者 
		 * @return 
		 * 
		 */
		public function get observer():IObserver
		{
			return _observer;
		}
		
		/**
		 * 获取本对象 - 观察对象 
		 * @return 
		 * 
		 */
		public function get observedObject():IObservedObject
		{
			return _observedObject;
		}
	}
}