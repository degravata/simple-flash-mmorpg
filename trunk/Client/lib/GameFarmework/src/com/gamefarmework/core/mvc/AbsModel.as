package com.gamefarmework.core.mvc
{
	import com.gamefarmework.core.parttens.Observer.IObservedObject;
	import com.gamefarmework.core.parttens.Observer.ObservedObject;

	public class AbsModel implements IModel
	{
		public static const NOTIFICATION_DESTROY_MODEL:int		= -1;
		
		protected var _observedObject:IObservedObject
		protected var _proxy:IProxy;
		
		public function AbsModel()
		{
			_observedObject = new ObservedObject();
		}
		
		public function Destroy():void
		{
			
			_observedObject.NotifyObserver(
				NOTIFICATION_DESTROY_MODEL);
				
			_observedObject = null;
			_proxy = null;
		}
		
		public function GetProxy():IProxy
		{
			return _proxy;
		}
		
		public function SetProxy(proxy:IProxy):void
		{
			_proxy = proxy;
		}
		
		public function get observedObject():IObservedObject
		{
			return _observedObject;
		}
	}
}