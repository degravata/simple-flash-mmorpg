package com.fangtong.DesignPatterns.Fsm
{
	public class FsmEntity
	{
		private var _target:Object;
		private var _fsm:AbsFsm;
		
		public function FsmEntity(i_target:Object)
		{
			_target = i_target;
		}
		
		public function ChangeState(i_fsm:AbsFsm):void
		{
			if(_fsm == i_fsm)
			{
				KeepState();
			}else{
				//离开原有状态
				if(_fsm != null)
					_fsm.Exit(this);
				
				//设定新状态
				_fsm = i_fsm;
				
				//进入状态
				_fsm.Enter(this);
			}
			
		}
		
		public function KeepState():void
		{
			if(_fsm != null)
				_fsm.Execute(this);
		}
		
		
		///////////////////////////////////////////////
		/**
		 * 获得当前状态 
		 * @return 
		 * 
		 */
		public function GetCurFsm():AbsFsm
		{
			return _fsm;
		}
		
		/**
		 * 获得实体 
		 * @return 
		 * 
		 */
		private function GetTarget():Object
		{
			return _target;
		}
	}
}