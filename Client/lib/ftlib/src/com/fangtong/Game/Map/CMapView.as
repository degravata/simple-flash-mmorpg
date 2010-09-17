package com.fangtong.Game.Map 
{
	import com.bourre.events.BasicEvent;
	import com.bourre.events.StringEvent;
	import com.bourre.plugin.Plugin;
	import com.bourre.structures.Dimension;
	import com.bourre.view.AbstractView;
	import com.fangtong.DesignPatterns.MVC.Model.AbsModel;
	import com.fangtong.Game.Data.GridBmp;
	import flash.events.Event;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author fangtong
	 */
	public class CMapView extends AbstractView
	{
		public static const MAP_VIEW_MARK:String = "mapview";
		
		public static const MAP_VIEW_EVENT_MOVETO:String = "onMapMoveTo";
		
		private var _vMapGridBmps:Vector.<GridBmp>;
		
		private var _offx:int;
		private var _offy:int;
		
		private var _px:int;
		private var _py:int;
		
		private var _langle:int;
		
		public function CMapView() 
		{
			super(null, MAP_VIEW_MARK, new Sprite);
			
			_offx = 0;
			_offy = 0;
			
			_px = 0;
			_px = 0;
			
			_langle = 1;
			
			_vMapGridBmps = new Vector.<GridBmp>;
		}
		
		public function Reduction():void
		{
			for each(var dis:DisplayObject in view)
			{
				if (dis.parent != null)
				{
					dis.parent.removeChild(dis);
				}
			}
			
			_vMapGridBmps.splice(
				0, _vMapGridBmps.length);
			
			_offx = 0;
			_offy = 0;
			
			_px = 0;
			_px = 0;
		}

		override public function onInitModel( e : StringEvent ) : void
		{
			var model:CMapModel = e.getTarget() as CMapModel;
			
			var stagerow:int = model["iStageRow"];
			var stagecol:int = model["iStageCol"];
			
			var width:int = model["dGrid"].width;
			var height:int = model["dGrid"].height;
			
			var i:int = 0,j:int = 0;
			
			for( i = -_langle; i < stagecol + _langle; i++)
			{
				for ( j = -_langle; j < stagerow + _langle; j++)
				{
					var gridbmp:GridBmp = new GridBmp();
					gridbmp.offx = _offx + j;
					gridbmp.offy = _offy + i;
					gridbmp.px = _px;
					gridbmp.py = _py;
					gridbmp.x = j * width;
					gridbmp.y = i * height;
					Sprite(view).addChild(gridbmp);
				}
			}
		
		}
		
		override public function onReleaseModel( e : StringEvent ) : void
		{
			Reduction();
			super.onReleaseModel(e);
		}
		
		public function Move(i_dx:int, i_dy:int):void
		{
			
		}
		
		public function MoveTo(i_offx:int, i_offy:int):void
		{
			_offx = i_offx;
			_offy = i_offy;
			notifyChanged(new BasicEvent(MAP_VIEW_EVENT_MOVETO,this));
		}
		
		
	}

}
