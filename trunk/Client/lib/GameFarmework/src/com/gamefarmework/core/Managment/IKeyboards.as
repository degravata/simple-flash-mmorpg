package com.gamefarmework.core.Managment
{
	public interface IKeyboards 
	{

		function StartKeyboard():void;

		function StopKeyboard():void;

		function UpKeyboardHandle(keycode:int, keydown:Boolean, keyup:Boolean, ctrl:Boolean, alt:Boolean, shift:Boolean):void;

		function RegisterKeyboardHandle(keycode:int, keydown:Boolean, keyup:Boolean, ctrl:Boolean, alt:Boolean, shift:Boolean):void;

		function RemoveKeyboardHandle(keycode:int, keydown:Boolean, keyup:Boolean, ctrl:Boolean, alt:Boolean, shift:Boolean):void;
	}
}