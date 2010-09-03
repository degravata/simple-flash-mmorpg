package com.fangtong.DesignPatterns.MVC.View
{
	import flash.utils.Dictionary;

	public class ViewManage
	{
		/**
		 *对象管理实例 
		 */
		private static var __instance:ViewManage;
		
		private var _DateProxys:Dictionary;
		
		
		public function ViewManage(pvt:PrivateClass)
		{
			
		}
		
		public static function _instance():ViewManage
		{
			if(ViewManage.__instance == null)
			{
				ViewManage.__instance = new ViewManage(new PrivateClass());
				ViewManage.__instance.Initialize();
			}
			return ViewManage.__instance;
		}
		
		/**
		 *	初始化 
		 */
		public function Initialize():void
		{
			_DateProxys = new Dictionary();	
		}
		
		public function AddType(type:Object):Boolean
		{
			for (var key:Object in _DateProxys)
			{
				if(type == key)
				{
					return false;
				}
			}
			_DateProxys[type] = new Dictionary();
			return true;
		}
		
		public function DelType(type:Object):Boolean
		{
			for (var key:Object in _DateProxys)
			{
				if(type == key)
				{
					DelDictonary(_DateProxys[key]);
					_DateProxys[key] = null;
					delete _DateProxys[key]
					return true;
				}
			}
			return false;
			
		}
		
		private function DelDictonary(obj:Dictionary):void
		{
			for (var inkey:Object in obj)
			{
				if(obj[inkey] is Dictionary)
				{
					DelDictonary(obj[inkey]);
				}
				obj[inkey] = null;
				delete obj[inkey];
			}
		}
		
		public function FindTypeDictionary(type:Object):Dictionary
		{
			return _DateProxys[type];
		}
		
		public function AddObjectByTypeKey(type:Object,key:Object,value:Object):Boolean
		{
			var list:Dictionary = FindTypeDictionary(type);
			if(null == list)
			{
				AddType(type);
				list = FindTypeDictionary(type);
			}
			if(list[key] != null
				&& list[key] != value)
			{
				return false;	
			}
			list[key] = value;
			return true;
		}
		
		public function DelObjectByTypeKey(type:Object,key:Object):Boolean
		{
			var list:Dictionary = FindTypeDictionary(type);
			if(null == list)
			{
				return false;
			}
			if(null == list[key])
			{
				return false;
			}
			list[key] = null;
			delete list[key];
			return true;
		}
		
		public function FindObjectByTypeKey(type:Object,key:Object):Object
		{
			var list:Dictionary = FindTypeDictionary(type);
			if(null == list)
			{
				return null;
			}
			return list[key];
		}
	}
}


class PrivateClass
{
	public function PrivateClass()
	{
		
	}
}