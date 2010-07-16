package com.SS.Net 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class MsgPackageManage
	{
		private var _arrMessagePackages:Array;
		private var _baPackaged:ByteArray;
		
		public function MsgPackageManage(i_ba:ByteArray = null ):void
		{	
			_arrMessagePackages = new Array();
			
			if (null != i_ba) {
				_baPackaged = i_ba;
				ExeMsgPackage(_baPackaged);
			}
			else {
				_baPackaged = new ByteArray();
			}
		}
		
		private function ExeMsgPackage(i_baPackaged:ByteArray):void {
			if (i_baPackaged.length>0 ){
				//var baForRead:ByteArray = new ByteArray();
				//i_baPackaged.position = 0;
				//i_baPackaged.readBytes(baForRead, 0, MessagePackage.ConstInt_Length_Of_PackageContentLength);
				
				//baForRead.writeBytes(i_baPackaged, 0, MessagePackage.ConstInt_Length_Of_PackageContentLength);

				//var uintPackageTotalLength:uint = MessagePackage.BytesToUShort(baForRead);
				i_baPackaged.position = 0;
				var uintPackageTotalLength:uint = MessagePackage.BytesToUShort(i_baPackaged);
				var length:int = i_baPackaged.length;
				if (uintPackageTotalLength <= length) {
					var ba:ByteArray = new ByteArray();
					i_baPackaged.position = 0;
					i_baPackaged.readBytes(ba, 0, uintPackageTotalLength);
					
					//baForRead.position = 0;
					//baForRead.writeBytes(ba);
					if (ba.length > 0) {
						_arrMessagePackages.push(ba);
					}

					if (uintPackageTotalLength < length) {
						i_baPackaged.position = 0;
						//i_baPackaged.readBytes(baForRead, uintPackageTotalLength, i_baPackaged.length);
						var b2:ByteArray = new ByteArray;
						b2.writeBytes(i_baPackaged, uintPackageTotalLength, i_baPackaged.length - uintPackageTotalLength);
						ExeMsgPackage(b2);
					}
				}
			}
		}
		
		//public function GetMsgPackagesNum():uint {
			//return _arrMessagePackages.length;
		//}
		
		public function GetMsgPackages():Array {
			return _arrMessagePackages;
		}
		
		public function toString():String
		{
			var len:int = _baPackaged.length ;
			var list:Array = [];
			for (var i:int = 0; i < len; i++)
			{
				list.push(_baPackaged[i]);
			}
			return list.join(",");
		}
		//public function AddMsgPackage(i_mp:MessagePackage):void {
			//_arrMessagePackages.push(i_mp);
		//}
		
		//public function SetMsgData(i_uintIdx:uint, i_mp:MessagePackage):void {
			//_arrMessagePackages[i_uintIdx] = i_mp;
		//}
	}

}