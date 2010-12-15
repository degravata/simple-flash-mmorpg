package com.gamefarmework.core.Managment
{
	public interface IKeyboards 
	{

		public function StartKeyboard():void;

		public function StopKeyboard():void;

		public function UpKeyboardHandle(keycode:int, keydown:Boolean, keyup:Boolean, ctrl:Boolean, alt:Boolean, shift:Boolean):void;

		public function RegisterKeyboardHandle(keycode:int, keydown:Boolean, keyup:Boolean, ctrl:Boolean, alt:Boolean, shift:Boolean):void;

		public function RemoveKeyboardHandle(keycode:int, keydown:Boolean, keyup:Boolean, ctrl:Boolean, alt:Boolean, shift:Boolean):void;
	}
}