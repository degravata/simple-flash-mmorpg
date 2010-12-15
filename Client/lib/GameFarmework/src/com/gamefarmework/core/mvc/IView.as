package com.gamefarmework.core.mvc
{

	public interface IView
	{

		function SetView(view:Object):void;

		function GetView():void;

		function onInsertViewEvent(e:Object):void;

		function onRemoveViewEvent(e:Object):void;

		function Destroy():void;
	}
}