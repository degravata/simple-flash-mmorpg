package com.fangtong.Game.Map 
{
	import com.bourre.collection.HashMap;
	import com.bourre.events.DimensionEvent;
	import com.bourre.model.AbstractModel;
	import com.bourre.plugin.Plugin;
	import com.bourre.structures.Dimension;
	import com.bourre.structures.Grid;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author fangtong
	 */
	public class CMapModel extends AbstractModel
	{
		public static const MAP_MODEL_MARK:String = "mapmodel";
		
		private var _iMapId:int;
		
		private var _dMap:Dimension;
		private var _dStage:Dimension;
		private var _dGrid:Dimension
		private var _hashGridObj:HashMap;
		private var _hashGridBmd:HashMap;
		
		private var _iMapRow:int;
		private var _iMapCol:int;
		
		private var _iStageRow:int;
		private var _iStageCol:int;
		
		private var _iMaxMapLength:int;
		private var _iMaxStageLength:int;
		
		
		public function CMapModel() 
		{
			super( null, MAP_MODEL_MARK );
			
			//初始化
			_iMapId 		= 	0;
			_dMap 			= 	null;
			_dStage 		= 	null;
			_hashGridObj 	= 	null;
			_hashGridBmd 	= 	null;
			
			_iMapRow = 0;
			_iMapCol = 0;
			
			_iStageRow = 0;
			_iStageCol = 0;
			
			_iMaxMapLength = 0;
			_iMaxStageLength = 0;
		}
		
		public function Init(
			i_iMapId:int, i_dMap:Dimension, 
			i_dStage:Dimension, i_dGrid:Dimension,
			i_bmdlist:HashMap, i_objlist:HashMap):void
		{
			_iMapId = i_iMapId;
			_dMap 	= i_dMap;
			_dStage = i_dStage;
			_dGrid	= i_dGrid;
			
			_iMapRow = _dMap.width / _dGrid.width;
			_iMapCol = _dMap.height / _dGrid.height;
			
			_iStageRow = _dStage.width / _dGrid.width;
			_iStageCol = _dStage.height / _dGrid.height;
			
			_iMaxMapLength = _iMapRow * _iMapCol;
			_iMaxStageLength = _iStageRow * _iStageCol;
			
			for (var index:int = 0; index < _iMaxMapLength; index ++ )
			{
				var bmdarr:Array = i_bmdlist.containsKey(index) ? i_bmdlist.get(index):null;;
				_hashGridBmd.put(index,new Grid(_dGrid, bmdarr, null, BitmapData));
				
				var objarr:Array = i_objlist.containsKey(index) ? i_objlist.get(index):null;
				_hashGridObj.put(index,new Grid(_dGrid, objarr, null, Object));
			}
			onInitModel();
		}
		
		override public function release():void
		{
			var grid:Grid = null;
			for each( grid in _hashGridObj)
			{
				grid.clear();
			}
			this._hashGridObj.clear();
			
			for each( grid in _hashGridBmd)
			{
				grid.clear();
			}
			this._hashGridBmd.clear();
			
			this._iStageRow = 0;
			this._iStageCol = 0;
			
			this._iMapRow = 0;
			this._iMapCol = 0;
			
			this._iMaxMapLength = 0;
			this._iMaxStageLength = 0;
			
			this._dGrid = null;
			this._dMap = null;
			this._dStage = null;
			
			super.release();
		}
		
		public function InsertObjInMapGrid(i_obj:Object,i_index:int):Boolean
		{
			if (i_index > _iMaxMapLength 
			&& i_index < 0)
			{
				return false;
			}
			
			var grid:Grid = _hashGridObj.get(i_index);
			return grid.add(i_obj);
		}
		
		public function RemoveObjFromMapGrid(i_obj:Object,i_index:int):Boolean
		{
			if (i_index > _iMaxMapLength 
			&& i_index < 0)
			{
				return false;
			}
			
			var grid:Grid = _hashGridObj.get(i_index);
			return grid.remove(i_obj);
		}
		
		public function GetDimensionIndexByMapPoint(
			i_x:int, i_y:int):int
		{
			
			return (i_x % _dGrid.width
				+ (i_y % _dGrid.height) * _iMapRow);
		}

		///////////////////////////////////////////////////////////////////
		
		public function get iMapId():int
		{
			return _iMapId;
		}

		/**
		 * 地图尺寸
		 */
		public function get dMap():Dimension
		{
			return _dMap;
		}

		/**
		 * 舞台尺寸
		 */
		public function get dStage():Dimension
		{
			return _dStage;
		}

		/**
		 * 格子尺寸
		 */
		public function get dGrid():Dimension
		{
			return _dGrid;
		}

		/**
		 * 格子列表-对象
		 */
		public function get hashGridObj():HashMap
		{
			return _hashGridObj;
		}

		/**
		 * 格子列表-图源
		 */
		public function get hashGridBmd():HashMap
		{
			return _hashGridBmd;
		}

		public function get iMapRow():int
		{
			return _iMapRow;
		}

		public function get iMapCol():int
		{
			return _iMapCol;
		}

		public function get iStageRow():int
		{
			return _iStageRow;
		}

		public function get iStageCol():int
		{
			return _iStageCol;
		}

		public function get iMaxMapLength():int
		{
			return _iMaxMapLength;
		}

		public function get iMaxStageLength():int
		{
			return _iMaxStageLength;
		}

		public function onMapMoveTo(e:Event):void
		{
			trace("onMapMoveTo")
		}
	}

}