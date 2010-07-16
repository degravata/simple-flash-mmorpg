package Up.Game.Sever
{
	public class ReadHandleProxy
	{
		public static var ProxyHandle:Array = [];
		
		public static function AddProxy(name:int,value:Function):void
		{
			ProxyHandle[name] = value;
		}
		
		public static function DelProxy(name:int):void
		{
			ProxyHandle[name] = null;
		}
	}
}