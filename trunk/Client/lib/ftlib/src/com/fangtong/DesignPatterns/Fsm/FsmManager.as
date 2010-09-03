package com.fangtong.DesignPatterns.Fsm
{
	import flash.utils.Dictionary;

	public class FsmManager
	{
		private var _hashlist:Dictionary;
		
		public function FsmManager()
		{
			_hashlist = new Dictionary(true);
		}
		
		/**
		 * 添加状态机 
		 * @param i_fsm
		 * 
		 */
		public function AddFsm(i_fsm:AbsFsm):void
		{
		
			_hashlist[i_fsm.GetState()] = i_fsm;
		}
		
		/**
		 * 移除状态机 
		 * @param i_state_obj
		 * 
		 */
		public function RemoveFsm(i_state_obj:Object):void
		{
			_hashlist[i_state_obj] = null;
			delete _hashlist[i_state_obj];
		}
		
		/**
		 * 获取状态机
		 * @param i_state_obj
		 * @return 
		 * 
		 */
		public function FindFsm(i_state_obj:Object):AbsFsm
		{
			if(i_state_obj == null)
				return null;
			return _hashlist[i_state_obj];
		}
		
		public function Transaction(i_Entity:FsmEntity,i_state_obj:Object):void
		{
			var fsm:AbsFsm = FindFsm(i_state_obj);
			if(fsm != null)
				i_Entity.ChangeState(fsm);
		}
	}
}