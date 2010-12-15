package com.gamefarmework.core.mvc
{
	
	public interface IModel 
	{

		function Destroy():void;

		function GetProxy():IProxy;

		function SetProxy(proxy:IProxy):void;
	}
}