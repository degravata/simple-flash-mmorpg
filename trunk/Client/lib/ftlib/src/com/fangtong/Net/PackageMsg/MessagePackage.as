package com.fangtong.Net.PackageMsg
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class MessagePackage
	{
		public static const ConstInt_Length_Of_PackageHead:int = 3;
		public static const ConstInt_Length_Of_PackageContentLength:int = 2;
		public static const ConstInt_Length_Of_PackageActionLength:int = 1;

		public static const ConstInt_Length_Of_MsgDataHead:int = 2;
		public static const ConstInt_Length_Of_MsgDataContentLength:int = 1;
		public static const ConstInt_Length_Of_MsgDataActionLength:int = 1;
		public static const ConstUs_Joint_MsgDataAction:uint = 255;

		private var _usPackageTotalLength:uint;
		private var _usHeadAction:uint;
		private var _baMsgData:ByteArray;
		
		private var _boolPackage:Boolean;
		private var _arrMsgDatas:Array;
		
		private var _baPackaged:ByteArray;
		
		public function MessagePackage(i_ba:ByteArray=null):void
		{
			_usPackageTotalLength = 0;
			_arrMsgDatas = [];
			_boolPackage = false;
			_baPackaged = new ByteArray();
			_baMsgData = new ByteArray();
			
			if (null!=i_ba){
				Init(i_ba);
			}
		}
		
		public function Init(i_ba:ByteArray):void
		{
			_baPackaged = i_ba;
			Unpackage();
		}
		
		/**
		 * 设置包头，Action参数
		 * @param	i_Action
		 */
		public function SetPackageAction(i_usPackageAction:uint):void {
			_usPackageTotalLength=ConstInt_Length_Of_PackageHead;
			_usHeadAction=i_usPackageAction;
		}
		
		//public function SetMsgDataById(i_intIndex:uint, i_Action, i_byteArrContent:ByteArray):void {
			//if (i_intIndex < _arrMsgDatas.length) {
				//var md:MsgData = new MsgData();
				//md.length = i_byteArrContent.length;
				//md.action = i_Action;
				//md.content = i_byteArrContent;
				//_arrMsgDatas[i_intIndex] = md;
			//}
		//}
		
		//public function AddIntData(i_Action, i_intContent:uint):Boolean {
			//var ba:ByteArray = new ByteArray();
			//ba.writeUnsignedInt(i_intContent);
			//AddMsgData(i_Action, ba);
			//return true;
		//}
		
		/**
		 * 添加数据
		 * @param	i_usAction
		 * @param	i_intData
		 */
		public function AddMsgDataNumber(i_usAction:uint, i_intData:Object):void {
			if (i_intData>=-128 && i_intData<=127){	//-128~127之间
				AddMsgDataChar(i_usAction,int(i_intData));
			}
			else if(i_intData>=128 && i_intData<=255){	//128~255之间
				AddMsgDataUChar(i_usAction,uint(i_intData));
			}
			else if(i_intData>=-32768 && i_intData<=32767){	//–32768~32767
				AddMsgDataShort(i_usAction,int(i_intData));
			}
			else if(i_intData>=32768 && i_intData<=65535){	//32768~65535
				AddMsgDataUShort(i_usAction,uint(i_intData));
			}
			else if(i_intData>=-2147483648 && i_intData<=2147483647){	//–2147483648~2147483647
				AddMsgDataInt(i_usAction,int(i_intData));
			}
			else if(i_intData>int.MAX_VALUE && i_intData<=uint.MAX_VALUE){
				AddMsgDataUInt(i_usAction,uint(i_intData));
			}
			else {
				AddMsgDataInt(i_usAction,int(i_intData));
			}
		}
		
		public function AddMsgDataUInt(i_usAction:uint, i_uintData:uint):void {
			var ba:ByteArray = new ByteArray();
			ba.writeUnsignedInt(i_uintData);
			ba.position = 0;
			AddMsgDataByte(i_usAction, ba);
		}
		public function AddMsgDataInt(i_usAction:uint, i_intData:int):void {
			var ba:ByteArray = new ByteArray();
			ba.writeInt(i_intData);
			ba.position = 0;
			AddMsgDataByte(i_usAction, ba);
		}
		public function AddMsgDataUShort(i_usAction:uint, i_ushortData:uint):void {
			var ba:ByteArray = new ByteArray();
			ba.writeBytes(UShortToBytes(i_ushortData));
			ba.position = 0;
			AddMsgDataByte(i_usAction, ba);
		}
		public function AddMsgDataShort(i_usAction:uint, i_shortData:int):void {
			var ba:ByteArray = new ByteArray();
			ba.writeBytes(ShortToBytes(i_shortData));
			ba.position = 0;
			AddMsgDataByte(i_usAction, ba);
		}
		public function AddMsgDataUChar(i_usAction:uint, i_ubyteData:uint):void {
			var ba:ByteArray = new ByteArray();
			ba.writeByte(NubmerToUByte(i_ubyteData));
			ba.position = 0;
			AddMsgDataByte(i_usAction, ba);
		}
		public function AddMsgDataChar(i_usAction:uint, i_byteData:int):void {
			var ba:ByteArray = new ByteArray();
			ba.writeByte(NubmerToByte(i_byteData));
			ba.position = 0;
			AddMsgDataByte(i_usAction, ba);
		}
		
		public function AddMsgDataByte(i_Action:uint, i_byteArrContent:ByteArray):Boolean {
			if (i_byteArrContent.length<=0){
				return true;
			}
			
			//if (i_Action == 255) {
				//return false;
			//}
			
			var md:MsgData = new MsgData();
			md.length = i_byteArrContent.length + ConstInt_Length_Of_MsgDataHead;
			md.action = i_Action;
			
			//trace("i_byteArrContent.length",i_byteArrContent.length );
			
			if (md.length > 255) {
				md.length = 255
				
				var uiSpliteContentLength:uint = 255 - ConstInt_Length_Of_MsgDataHead;
				var baT:ByteArray = new ByteArray();
				baT.writeBytes(i_byteArrContent, 0, uiSpliteContentLength);
				//md.content = baT
				md.Content = baT;
				
				//trace("---------超长----------------");
				//trace("md.length", md.length,"md.action", md.action,"md.content", md.content[0],"-",md.content[uiSpliteContentLength-1]);
				
				AddToArray(md);
				
				baT = new ByteArray();
				baT.position = 0;
				baT.writeBytes(i_byteArrContent, uiSpliteContentLength, i_byteArrContent.length - uiSpliteContentLength);
				AddMsgDataByte(ConstUs_Joint_MsgDataAction, baT);
			}
			else{
				//md.content = i_byteArrContent;
				md.Content = i_byteArrContent;
				
				//trace("---------普通----------------");
				//trace("md.length", md.length, "md.action", md.action, "md.content", md.content[0], "-", md.content[i_byteArrContent.length-1]);
				
				AddToArray(md);
			}
			
			return true;
		}
		
		private function AddToArray(i_md:MsgData):void {
			_arrMsgDatas.push(i_md);
			_usPackageTotalLength += i_md.length;
		}
		
		public function Package():ByteArray {
			if (!_boolPackage) {
				PackageMsgData();
				PackageHead();
				_boolPackage = true;
			}
			//trace(_baPackaged[0], _baPackaged[1], _baPackaged[2], _baPackaged[3], _baPackaged[4], _baPackaged[5]);
			return _baPackaged;
		}
		
		private function PackageMsgData():void {
			var length:int = _arrMsgDatas.length;
			for (var i:uint = 0; i < length; i++ ) {
				var md:MsgData = _arrMsgDatas[i];
				_baMsgData.writeByte(NubmerToUByte(md.length));
				_baMsgData.writeByte(md.action);
				//_baMsgData.writeBytes(md.content);
				_baMsgData.writeBytes(md.Content);
				
				//trace("======打包======");
				//trace("r:", _baMsgData[0],_baMsgData[1], "---", _baMsgData[_baMsgData.length - 1]);
			}
		}

		private function PackageHead():void {
			_baPackaged.writeShort(_usPackageTotalLength);
			_baPackaged.writeByte(_usHeadAction);
			_baPackaged.writeBytes(_baMsgData);
		}
		
		private function NubmerToUByte(i_number:Number):uint {
			//var c:uint;
			//c = (uint)(0xff & i_number);
			return 0xff & i_number;
		}
		
		private function NubmerToByte(i_number:Number):int {
			return 0xff & i_number;
		}
		
		private function UIntToBytes(i_uint:uint):ByteArray {
			var ba:ByteArray = new ByteArray();
			ba[3] = 0xff & i_uint;
			ba[2] = (0xff00 & i_uint) >> 8;
			ba[1] = (0xff0000 & i_uint) >> 16;
			ba[0] = (0xff000000 & i_uint) >> 24;
			ba.position = 0;
			return ba;
		}
		private function IntToBytes(i_int:int):ByteArray {
			var ba:ByteArray = new ByteArray();
			ba[3] = 0xff & i_int;
			ba[2] = (0xff00 & i_int) >> 8;
			ba[1] = (0xff0000 & i_int) >> 16;
			ba[0] = (0xff000000 & i_int) >> 24;
			ba.position = 0;
			return ba;
		}
		private function UShortToBytes(i_ushort:uint):ByteArray {
			var ba:ByteArray = new ByteArray();
			ba[1] = 0xff & i_ushort;
			ba[0] = (0xff00 & i_ushort) >> 8;
			ba.position = 0;
			return ba;
		}
		private function ShortToBytes(i_short:int):ByteArray {
			var ba:ByteArray = new ByteArray();
			ba[1] = 0xff & i_short;
			ba[0] = (0xff00 & i_short) >> 8;
			ba.position = 0;
			return ba;
		}
		
		
		/**
		 * 解包用
		 * @return
		 */
		private function Unpackage():void {
			
			var baForRead:ByteArray = new ByteArray();
			baForRead.writeBytes(_baPackaged, 0, ConstInt_Length_Of_PackageContentLength);
			_usPackageTotalLength = BytesToUShort(baForRead);

			if (_usPackageTotalLength == _baPackaged.length) {
				baForRead = new ByteArray();
				baForRead.writeBytes(_baPackaged, ConstInt_Length_Of_PackageContentLength, ConstInt_Length_Of_PackageActionLength);
				_usHeadAction = ByteToUInt(baForRead);
				baForRead = new ByteArray();
				baForRead.writeBytes(_baPackaged, ConstInt_Length_Of_PackageHead);
				UnpackageMsgData(baForRead, baForRead.length);
			}
		}
		
		private function UnpackageMsgData(i_ba:ByteArray,i_intTotalLength:int):void {
			if (i_intTotalLength > 0 && i_intTotalLength>=i_ba.length) {
				var usFirstMsgDataLength:uint = i_ba[0];// BytesToUShort(i_ba[0]);
				var usFirstMsgDataAction:uint = i_ba[ConstInt_Length_Of_MsgDataContentLength];//BytesToUShort(i_ba[ConstInt_Length_Of_MsgDataContentLength]);
				
				var baOtherMsgDatas:ByteArray = new ByteArray();
				
				if (usFirstMsgDataAction==ConstUs_Joint_MsgDataAction){
					//_vMsgData[_vMsgData.size()-1]
					if (_arrMsgDatas.length>0){
						JoinMsgData(_arrMsgDatas[_arrMsgDatas.length - 1], usFirstMsgDataLength, i_ba);
						baOtherMsgDatas.writeBytes(i_ba, usFirstMsgDataLength, i_intTotalLength - usFirstMsgDataLength);
					}
				}
				else{
					var baFirstMsgDataContent:ByteArray = new ByteArray();
					//trace(i_ba.length,usFirstMsgDataLength - ConstInt_Length_Of_MsgDataHead);
					baFirstMsgDataContent.writeBytes(
						i_ba, 
						ConstInt_Length_Of_MsgDataHead, 
						usFirstMsgDataLength - ConstInt_Length_Of_MsgDataHead
					);
					
					var md:MsgData = new MsgData();
					md.length = usFirstMsgDataLength;
					md.action = usFirstMsgDataAction;
					//md.content = baFirstMsgDataContent;
					baFirstMsgDataContent.position = 0;
					md.Content = baFirstMsgDataContent;
					//md.content.position = 0;
					//trace(baFirstMsgDataContent[0],baFirstMsgDataContent[1],baFirstMsgDataContent[2],baFirstMsgDataContent[3]);
					_arrMsgDatas.push(md);

					baOtherMsgDatas.writeBytes(i_ba, usFirstMsgDataLength, i_intTotalLength - usFirstMsgDataLength);
				}
				
				UnpackageMsgData(baOtherMsgDatas,i_intTotalLength-usFirstMsgDataLength);
			}
		}
		
		private function JoinMsgData(i_md:MsgData,i_usLength:uint,i_lpChar:ByteArray):void {
			//var md:MsgData = _arrMsgDatas[_arrMsgDatas.length - 1];
			var uiLength:uint= i_md.length+i_usLength-ConstInt_Length_Of_MsgDataHead;
			
			var lpChar:ByteArray = new ByteArray();
			//lpChar.writeBytes(i_md.content);
			lpChar.writeBytes(i_md.Content);
			lpChar.writeBytes(i_lpChar, ConstInt_Length_Of_MsgDataHead, i_usLength - ConstInt_Length_Of_MsgDataHead);
			lpChar.position = 0;

			i_md.length = uiLength;
			i_md.Content = lpChar;
		}
		 
		public function GetPackageAction():uint {
			return _usHeadAction;
		}
		
		public function GetPackageTotalLength():uint {
			return _usPackageTotalLength;
		}
		
		public function GetMsgDataById(i_intIndex:uint):ByteArray {
			var baTemp:ByteArray = _arrMsgDatas[i_intIndex];
			var baReturn:ByteArray = new ByteArray();
			baReturn.writeBytes(baTemp, uint.length, baTemp.length - uint.length);
			//baTemp.readBytes(baReturn, uint.length,baTemp.length-uint.length);
			return baReturn;
		}
		
	
		public function GetAllMsgData():Array {
			return _arrMsgDatas;
		}
		
				
		public static function ByteToUInt(i_lpChar:ByteArray):uint {
			if (null != i_lpChar && i_lpChar.length > 0) {
				return i_lpChar[0];
			}
			else{
				return 0;
			}
		}
		
		public function BytesToShort(i_ba:ByteArray):int{
			var res:int = i_ba[1] & 0xFF;
			res |= ((i_ba[0] << 8) & 0xFF00);
			return res;
		}

		public static function  BytesToUShort(i_lpChar:ByteArray):uint {
			var res:uint = i_lpChar[1] & 0xFF;
			res |= ((i_lpChar[0] << 8) & 0xFF00);
			return res;
		}
		
		public static function BytesToInt(i_ba:ByteArray):int {
			var res:int=i_ba[3] & 0xFF;
			res |= ((i_ba[2] << 8) & 0xFF00);
			res |= ((i_ba[1] << 16) & 0xFF0000);
			res |= ((i_ba[0] << 24) & 0xFF000000);
			return res;
		}

		public static function  BytesToUInt(i_lpChar:ByteArray):uint{
			var res:uint = i_lpChar[3] & 0xFF;
			res |= ((i_lpChar[2] << 8) & 0xFF00);
			res |= ((i_lpChar[1] << 16) & 0xFF0000);
			res |= ((i_lpChar[0] << 24) & 0xFF000000);
			return res;
		}
		
	}

}