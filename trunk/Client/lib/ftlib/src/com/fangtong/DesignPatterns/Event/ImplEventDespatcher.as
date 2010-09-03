package com.fangtong.DesignPatterns.Event
{
	import flash.utils.Dictionary;

	public class ImplEventDespatcher implements IEventDespatcher
	{
		public function ImplEventDespatcher()
		{
			//TODO: implement function
		}
		
		public function HasEventListener(i_objEvent:Object, i_callbackFunc:Function):Boolean
		{
			if (!_dCallbackFuns.hasOwnProperty(i_objEvent)){
				return false;
			}
			var arrFunc:Vector.<Function> = _dCallbackFuns[i_objEvent];
			for each(var fun:Function in arrFunc)
			{
				if(fun == i_callbackFunc)
				{
					return true;
				}
			}
			return false;
		}
		
		public function AddEventListener(i_objEvent:Object, i_callbackFunc:Function):void
		{
			//TODO: implement function
			if (!_dCallbackFuns.hasOwnProperty(i_objEvent)){
				_dCallbackFuns[i_objEvent]=new Vector.<Function>;
			}
			
			var arrFunc:Vector.<Function> = _dCallbackFuns[i_objEvent];
			for each(var fun:Function in arrFunc)
			{
				if(fun == i_callbackFunc)
				{
					return;
				}
			}
			arrFunc.push(i_callbackFunc);
		}
		
		public function RemoveEventListener(i_objEvent:Object,i_func:Function=null):void
		{
			if (this._dCallbackFuns[i_objEvent]==null){
				return;
			}
			
			var arrFunc:Vector.<Function> =_dCallbackFuns[i_objEvent];
			
			if (null==i_func){
				arrFunc.splice(0,arrFunc.length-1);
				_dCallbackFuns[i_objEvent]=null;
				delete _dCallbackFuns[i_objEvent];
			}
			else{
				var i:int=0;
				for each(var func:Function in arrFunc){
					if (i_func==func){
						arrFunc.splice(i,1);
						break;
					}
					i++;
				}
			}
		}
		
		public function RemoveAllEventListener():void{
			for (var key:Object in _dCallbackFuns){
				RemoveEventListener(key);
			}
		}
		
		public function DespatcherEvent(i_objEvent:Object, i_o:Object = null):void
		{
			//TODO: implement function
			if (null!=i_objEvent && this._dCallbackFuns[i_objEvent]!=null){
				var arrFunc:Vector.<Function> =_dCallbackFuns[i_objEvent];
//				for each(var func:Function in arrFunc){
//					func(i_o);
//				}
				var i:int = arrFunc.length - 1;
				while(i >= 0)
				{
					arrFunc[i](i_o);
					i--
				}
			}
		}
		
		private var _dCallbackFuns:Dictionary =new Dictionary();
	}
}