package com.gamefarmework.core.mvc
{
	import com.gamefarmework.core.parttens.Observer.IObservedObject;

	public interface IView extends IObservedObject 
	{

		public function SetView(view:Object):void;

		public function GetView():void;

		public function onInsertViewEvent(e:Object):void;

		public function onRemoveViewEvent(e:Object):void;

		public function Destroy():void;
	}
}