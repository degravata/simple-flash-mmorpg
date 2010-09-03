package com.fangtong.DesignPatterns.MVC.Controller 
{
	import com.fangtong.DesignPatterns.MVC.Model.AbsModel;
	import com.fangtong.DesignPatterns.MVC.View.AbsView;
	/**
	 * ...
	 * @author fangtong
	 */
	public class AbsController implements IController
	{
		private var _model:AbsModel;
		private var _view:AbsView;
		
		public function AbsController(i_model:AbsModel,i_view:AbsView) 
		{
			_model = i_model;
			_view = i_view;
			
			InitialBind();
		}
		
		public function InitialBind():void
		{
			if (_model)
			{
				BindModel();
			}
			
			if (_view)
			{
				BindView();
			}
		}
		
		public function DestroyBind(obj:Object = null):void
		{
			if (_model)
			{
				UnBindModel();
			}
			
			if (_view)
			{
				UnBindView();
			}
			
			_model = null;
			_view = null;
		}
		
		//////////////////////////////////////////////////
		//绑定
		public function BindModel():void
		{
			
		}
		
		public function BindView():void
		{
			
		}
		//解绑
		public function UnBindModel():void
		{
			
		}
		
		public function UnBindView():void
		{
			
		}
		
	}

}