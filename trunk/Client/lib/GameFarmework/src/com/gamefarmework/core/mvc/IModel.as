package com.gamefarmework.core.mvc
{
	import com.gamefarmework.core.parttens.Observer.IObservedObject;

	public interface IModel extends IObservedObject 
	{

		public function Destroy():void;

		public function GetProxy():IProxy;

		public function SetProxy(proxy:IProxy):void;
	}
}