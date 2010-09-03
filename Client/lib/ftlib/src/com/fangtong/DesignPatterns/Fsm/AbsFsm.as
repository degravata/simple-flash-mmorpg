package com.fangtong.DesignPatterns.Fsm
{
	public class AbsFsm
	{
		private var _state:Object;
		
		public function AbsFsm(i_state:Object)
		{
			_state = i_state;
		}
		
		////////////////////////////////////////////////////
		
		/**
		 * 进入状态
		 * @param i_entity
		 * 
		 */
		public function Enter(i_entity:FsmEntity):void
		{
			
		}
		
		/**
		 * 执行状态
		 * @param i_entity
		 * 
		 */
		public function Execute(i_entity:FsmEntity):void
		{
			
		}
		
		/**
		 * 离开状态
		 * @param i_entity
		 * 
		 */
		public function Exit(i_entity:FsmEntity):void
		{
			
		}
		//////////////////////////////////////////////////
		
		public function GetState():Object
		{
			return _state;
		}
	}
}