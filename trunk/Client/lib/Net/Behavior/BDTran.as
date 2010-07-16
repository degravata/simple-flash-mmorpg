package com.SS.Net.Behavior 
{
	import com.SS.Net.IBehavior.IBRec;
	import com.SS.Net.IBehavior.IBSend;
	import com.SS.Net.IBehavior.IBTran;
	import com.SS.Net.MessagePackage;
	
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Eric Wang
	 */
	public class BDTran implements IBTran,IBSend
	{
		public function Tran(i_soket:Socket, i_arrMsgPackages:Array):Boolean {
			for (var i:int = 0; i < i_arrMsgPackages.length; i++) {
				var mp:MessagePackage = new MessagePackage(i_arrMsgPackages[i]);
				var a:int = mp.GetPackageAction();
				//trace("PackageAction=", a);
				switch(a) {
					case 0:	//ping
						return false;
					break;
					
					//case 1:		//new
//
					//break;
					//
					//case 2:		//move
//
					//break;
					//
					//case 3:		//quit
//
					//break;
					//
					//case 4:		//monster
					//
					//break;
					//
					//case 5:		//hit stop upd
					//
					//break;
					//
					//case 6:
					//
					//break;
					//
					//case 7:			//玩家被弹出
					//
					//break;
					
					default:

					break;
				}
			}
			return true;
		}
		
		public function Send(i_soket:Socket, i_byteArr:ByteArray):void {
			if (i_soket.connected){
				i_soket.writeBytes(i_byteArr);
				i_soket.flush();
			}
		}
	}

}