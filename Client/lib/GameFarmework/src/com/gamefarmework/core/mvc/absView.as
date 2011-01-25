package com.gamefarmework.core.mvc
{
	import com.gamefarmework.core.parttens.Observer.IObservedObject;
	import com.gamefarmework.core.parttens.Observer.ObservedObject;
	
	import flash.display.DisplayObject;
	import flash.events.Event;

	public class AbsView implements IView
	{
		public static const NOTIFICATION_CHANAGE_DISPLAY:int	= -1;
		public static const NOTIFICATION_DESTROY_VIEW:int		= -2;	
		
		protected var _observedObject:IObservedObject;
		protected var _display:DisplayObject;
		
		public function AbsView()
		{
			_observedObject = new ObservedObject;
			_display = null;
		}
		
		public function SetDisplay(view:DisplayObject):void
		{
			//若有显示 先移除监听及显示
			if(_display != null)
			{
				onRemoveDisplayEvent(null);
				_display.parent.removeChild(
					_display);
				_display = null
			}
			//设置显示
			_display = view;
			
			//设置显示若为空 则返回
			if(_display == null) return;
			
			//若有stage 初始化监听
			if(_display.stage) onInsertDisplayEvent(null);
			
			//放入stage监听
			_display.addEventListener(
				Event.ADDED_TO_STAGE,
				onInsertDisplayEvent,
				false,0,true);
			_display.addEventListener(
				Event.REMOVED_FROM_STAGE,
				onRemoveDisplayEvent,
				false,0,true);
			
			//发送改变显示通知
			_observedObject.NotifyObserver(
				NOTIFICATION_CHANAGE_DISPLAY);
		}
		
		public function GetDisplay():DisplayObject
		{
			return _display;
		}
		
		public function onInsertDisplayEvent(e:Object):void
		{
		}
		
		public function onRemoveDisplayEvent(e:Object):void
		{
		}
		
		public function Destroy():void
		{
			//发送销毁通知
			_observedObject.NotifyObserver(
				NOTIFICATION_DESTROY_VIEW);
			//销毁显示及观察对象
			SetDisplay(null);
			_observedObject = null;
		}
	}
}