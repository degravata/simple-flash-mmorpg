package com.SS.Net 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class MsgData
	{
		public var length:uint;
		public var action:uint;
		private var content:ByteArray
		
		public function MsgData()
		{
		}
		
		public function get Content():ByteArray {
			content.position = 0;
			return content;
		}
		
		public function set Content(i_ba:ByteArray):void {
			if (null!=i_ba){
				i_ba.position = 0;
			}
			content = i_ba;
		}
		
		public function GetByteArray():ByteArray {
			if (null!=content){
				content.position = 0;
				return content;
			}
			else {
				return null;
			}
		}
		
		public function GetString(i_strCodeName:String):String {
			if (null!=content){
				content.position = 0;
				return content.readMultiByte(content.length,i_strCodeName);
			}
			else {
				return null;
			}
		}
		
		public function GetData():int {
			var intLength:uint = length - MessagePackage.ConstInt_Length_Of_MsgDataHead;
			if (intLength == 1) {
				return GetByte();
			}
			else if (intLength == 2) {
				return GetShort();
			}
			else if (intLength == 4) {
				return GetInt();
			}
			//else {
				//return GetString("utf-8");
			//}
			
			return 0;
		}
		
		public function GetDataU():uint {
			var intLength:uint = length - MessagePackage.ConstInt_Length_Of_MsgDataHead;
			if (intLength == 1) {
				return GetByteU();
			}
			else if (intLength == 2) {
				return GetShortU();
			}
			else if (intLength == 4) {
				return GetIntU();
			}
			return 0;
		}
		
		private function GetByte():int {
			if (null != content) {
				content.position = 0;
				return content.readByte();
			}
			else {
				return NaN;
			}
		}
		
		private function GetByteU():uint {
			if (null!=content){
				content.position = 0;
				return content.readUnsignedByte();
			}
			else {
				return NaN;
			}
		}
		
		private function GetShort():int {
			if (null!=content){
				content.position = 0;
				return content.readShort();
			}
			else {
				return NaN;
			}
		}
		
		private function GetShortU():uint {
			if (null!=content){
				content.position = 0;
				return content.readUnsignedShort();
			}
			else {
				return null;
			}
		}
		
		private function GetInt():int {
			if (null!=content){
				content.position = 0;
				return content.readInt();
			}
			else {
				return NaN;
			}
		}
		
		private function GetIntU():uint {
			if (null!=content){
				content.position = 0;
				return content.readUnsignedInt();
			}
			else {
				return NaN;
			}
		}
	}
}