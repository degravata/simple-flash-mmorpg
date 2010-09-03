package com.fangtong.Game.Map
{
	import com.fangtong.DesignPatterns.MVC.Model.AbsModel;
	import com.fangtong.Game.Define;
	
	public class CMapModel extends AbsModel
	{
		private var _tilelist:Vector.<Object>;
		private var _objlist:Vector.<Object>;
		
		
		public function CMapModel(i_key:Object)
		{
			
			super(Define.GAME_TYPE_MAP, i_key);
		}
		
		
	}
}