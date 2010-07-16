package Up.Game.Sever
{
	import com.SS.Net.ClientSoket;

	public class SocketClient extends ClientSoket
	{
		/**
		 *SocketClient实例 
		 *sockect客户端 
		 */
		private static var __instance:SocketClient;
		
		public function SocketClient(prt:PrivateClass)
		{
			super(SocketConfig.IPADD,SocketConfig.PORT);
		}
		
		/**
		 * 获取实例 
		 * @return 
		 * 
		 */
		public static function _instance():SocketClient
		{
			if(SocketClient.__instance == null)
			{
				SocketClient.__instance = new SocketClient(new PrivateClass());
			}
			return SocketClient.__instance;
		}
		
		/**
		 *	初始化 
		 */
		public function Initialize(i_connect_fun:Function = null):void
		{
			
			//数据操作
			var stran:SocketTransaction = new SocketTransaction();
			this.SetTran(stran);
			
			//连接操作
			var scon:SocketBeConnect = new SocketBeConnect(i_connect_fun);
			this.SetConnect(scon);
			
			//start
			this.Connect();
		}
	}
}

class PrivateClass
{
	public function PrivateClass()
	{
		
	}
}