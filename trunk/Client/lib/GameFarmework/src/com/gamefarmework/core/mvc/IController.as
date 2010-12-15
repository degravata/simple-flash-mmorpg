package com.gamefarmework.core.mvc
{
	import com.gamefarmework.core.parttens.Observer.IObserver;

	public interface IController extends IObserver 
	{

		public function RegisterObservedNotification():void;

		public function ReomveObservedNotification():void;
	}
}