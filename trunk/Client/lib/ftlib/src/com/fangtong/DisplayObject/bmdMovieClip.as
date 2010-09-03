package com.fangtong.DisplayObject 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author fangtong
	 */
	public class bmdMovieClip extends Sprite
	{
		
		public function bmdMovieClip() 
		{

		}
		
	}

}
import flash.display.BitmapData;

class BmdAndFramList
{
	public var bmd:BitmapData;
	public var framlist:Array;
	
	/**
	 * 图源和帧列表
	 * @param	i_bmd	图源
	 * @param	i_framlist 帧列表 vector.<int>
	 */
	public function BmdAndFramList(
		i_bmd:BitmapData, i_framlist:Array)
	{
		bmd = i_bmd;
		framlist = i_framlist;
	}
}