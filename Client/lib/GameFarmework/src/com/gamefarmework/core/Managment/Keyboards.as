package com.gamefarmework.core.Managment
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	public class Keyboards implements IKeyboards
	{
		private static var _instance:
		
		private var _stage:Stage;
		/**
		 *  
		 */
		private var _dic:Dictionary;
		
		public function Keyboards()
		{
			_dic = new Dictionary();
		}
		
		public function StartKeyboard(stage:Stage):void
		{
			if(stage == null) return;
			_stage = stage;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
		}
		
		public function StopKeyboard():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			_stage = null;
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			UpKeyboardHandle(
				e.keyCode,true,false,
				e.ctrlKey,e.altKey,e.shiftKey);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			UpKeyboardHandle(
				e.keyCode,false,true,
				e.ctrlKey,e.altKey,e.shiftKey);
		}
		
		public function UpKeyboardHandle(
			keycode:int,
			keydown:Boolean,
			keyup:Boolean,
			ctrl:Boolean,
			alt:Boolean,
			shift:Boolean):void
		{
			
		}
		
		public function RegisterKeyboardHandle(
			handle:Function,
			keycode:int,
			keydown:Boolean,
			keyup:Boolean, 
			ctrl:Boolean,
			alt:Boolean,
			shift:Boolean
		):void
		{
			var key:String = GetKeyboardKey(
				keycode, keydown, keyup,
				ctrl, alt, shift);
			if(_dic[key] == null)
			{
			
			};
			
		}
		
		public function RemoveKeyboardHandle(
			handle:Function,
			keycode:int,
			keydown:Boolean,
			keyup:Boolean,
			ctrl:Boolean,
			alt:Boolean,
			shift:Boolean):void
		{
			var key:String = GetKeyboardKey(
				keycode, keydown, keyup,
				ctrl, alt, shift);
			if(_dic[key] == null) return;
		}
		
		private function GetKeyboardKey(
			keycode:int,
			keydown:Boolean,
			keyup:Boolean,
			ctrl:Boolean,
			alt:Boolean,
			shift:Boolean):String
		{
			var str:String = "key_";
			str += keycode.toString() + "_" 
			str	+= keydown.toString() + "_"
			str	+= keyup.toString() + "_";
			str	+= ctrl.toString() + "_"
			str	+= shift.toString() + "_";
			str += alt.toString();
			return str;
		}
	}
}