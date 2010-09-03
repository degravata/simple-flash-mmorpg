package com.fangtong.DesignPatterns.MVC.View 
{
	import com.fangtong.DesignPatterns.Event.ImplEventDespatcher;
	
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author fangtong
	 */
	public class AbsView extends ImplEventDespatcher implements IView
	{
		public static const DisplayDestructor:int		= -1;
		public static const DisplayInitComplete:int		= -2;
		
		private var _isInitComplete:Boolean;
		private var _type:Object;
		private var _key:Object;
		private var _view:DisplayObject;
		
		public function AbsView(type:Object,key:Object) 
		{
			_type = type;
			_key = key;
			InsertToManage(_type,_key,this);
		}
		
		public function get isInitComplete():Boolean
		{
			return _isInitComplete;
		}
		
		public function set isInitComplete(value:Boolean):void
		{
			_isInitComplete = value;
			InitComplete();
		}
		
		public function InitComplete():void
		{
			this.DespatcherEvent(DisplayInitComplete,this);
		}
		
		public function Destructor():void
		{
			this.DespatcherEvent(DisplayDestructor,this);
			DestroyToManage(_type,_key);
		}
		
		public function InsertToManage(type:Object,key:Object,value:Object):Boolean
		{	
			return ViewManage._instance().AddObjectByTypeKey(
				type, key, value);
		}
		
		public function DestroyToManage(type:Object,key:Object):Boolean
		{
			return ViewManage._instance().DelObjectByTypeKey(
				type, key);
		}
		
		public function SetViewTarget(val:DisplayObject):void
		{
			_view = val;
		}
		
		public function GetViewTarget():DisplayObject
		{
			return _view;
		}
	}

}