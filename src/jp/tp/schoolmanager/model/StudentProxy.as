package jp.tp.schoolmanager.model
{
	
	import jp.tp.schoolmanager.SMFacade;
	import jp.tp.schoolmanager.constants.SMConst;
	import jp.tp.schoolmanager.vo.StudentVO;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	

	public class StudentProxy extends Proxy
	{
		// Proxyの名称
		public static const PROXY_NAME:String = "StudentProxy";
		
		private var _list:Array = [];
			
		public function StudentProxy()
		{
			super(PROXY_NAME);
		}
		
		public function get random():StudentVO
		{
			var vo:StudentVO = new StudentVO();
			var len:Number = Math.random() *10 + 3;
			var name:String;
			while(len--)
			{
				name = name + randomStr();
			}
			vo.name = name;
			vo.intelligence = randomNum();
			vo.looks = randomNum();
			vo.sociality = randomNum();
			vo.strength = randomNum();
			vo.wealth = randomNum();
			return vo;
		}
		private function get randomStr():String
		{
			var charcodeA:Number = "A".charCodeAt(0);
			return String.fromCharCode(charcodeA + Math.random() * 26)			
		}
		private function get randomNum():Number
		{
			return (Math.random() + Math.random()) / 2 * 100;
		}
		public static function getInstance():StudentProxy
		{
			if (!SMFacade.getInstance().hasProxy(PROXY_NAME))
			{
				 SMFacade.getInstance().registerProxy(new StudentProxy());
			}
			return SMFacade.getInstance().retrieveProxy(PROXY_NAME) as StudentProxy;
		}

	}
}