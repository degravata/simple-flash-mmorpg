package com.fangtong.DesignPatterns.MVC.Model
{
	import com.fangtong.DesignPatterns.Event.ImplEventDespatcher;
	import com.fangtong.DesignPatterns.MVC.Model.IModel;
	
	public class AbsModel extends ImplEventDespatcher implements IModel
	{
		public static const DateDestructor:int		= -1;
		public static const DateInitComplete:int	= -2;
		
		private var _isInitComplete:Boolean;
		
		private var _type:Object;
		private var _key:Object;
		
		public function AbsModel(i_type:Object,i_key:Object)
		{
			_type =i_type;
			_key = i_key;
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
			this.DespatcherEvent(DateInitComplete,this);
		}
		
		public function Destructor():void
		{
			this.DespatcherEvent(DateDestructor,this);
			DestroyToManage(_type,_key);
		}
		
		public function InsertToManage(i_type:Object,i_key:Object,i_value:Object):Boolean
		{
			return ModelManage._instance().AddObjectByTypeKey(
				i_type,i_key,i_value);
		}
		
		public function DestroyToManage(i_type:Object,i_key:Object):Boolean
		{
			return ModelManage._instance().DelObjectByTypeKey(
				i_type,i_key);
		}

		///////////////////////////////////////////////////////////////
		public function get type():Object
		{
			return _type;
		}

		public function get key():Object
		{
			return _key;
		}


	}
}