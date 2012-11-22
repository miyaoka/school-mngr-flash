package jp.tp.schoolmanager.model
{
	
	import jp.tp.schoolmanager.SMFacade;
	import jp.tp.schoolmanager.constants.SMConst;
	import jp.tp.schoolmanager.vo.StudentVO;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	

	public class StudentListProxy extends Proxy
	{
		// Proxyの名称
		public static const PROXY_NAME:String = "StudentListProxy";
		
		private var _list:Array = [];
		private var _total:StudentVO = new StudentVO();
		private var _mean:StudentVO;
		private var _standardDeviation:StudentVO;
		private var _max:StudentVO = new StudentVO()
		private var _min:StudentVO = new StudentVO()
		private var fields:Array = ["intelligence", "looks", "sociality", "strength", "wealth"]
			
		public function StudentListProxy()
		{
			super(PROXY_NAME);
		}
		
		public function get list():Array
		{
			return _list;
		}
		/**
		 * 平均値
		 */
		public function get mean():StudentVO
		{
			if(_mean) return _mean;
			_mean = new StudentVO;
			_mean.name = "平均";
			var len:uint = _list.length;
			for each (var key:String in fields)
			{
				_mean[key] = _total[key] / len;
			}
			return _mean;
		}
		/**
		 * 標準偏差
		 */
		public function get standardDeviation():StudentVO
		{
			if(_standardDeviation) return _standardDeviation;
			_standardDeviation = new StudentVO;
			_standardDeviation.name = "標準偏差";
			var len:uint = _list.length;
			
			for each (var key:String in fields)
			{
				var keytotal:Number = 0;
				var student:StudentVO 
				for each (student in _list)
				{
					keytotal += Math.pow(student[key] - _mean[key], 2)
				}
				_standardDeviation[key] = Math.sqrt(keytotal / len);
				
				
				for each (student in _list)
				{
					student[key + "Score"] = (student[key] - mean[key]) / _standardDeviation[key] * 10 + 50;
				}
				
			}
			return _standardDeviation;
		}
		public function get max():StudentVO
		{
			return _max;
		}
		public function get min():StudentVO
		{
			return _min;
		}
		public function addList(ary:Array):void
		{
			for each(var vo:StudentVO in ary)
			{
				_add(vo);
			}
			_mean = 
			_standardDeviation = null;
			sendNotification(SMConst.UPDATE_STUDENT_LIST);
		}

		public function _add(vo:StudentVO):void
		{
			_list.push(vo);
			for each (var key:String in fields)
			{
				_total[key] += vo[key];
				if(!max[key] || max[key] < vo[key])
				{
					max[key] = vo[key]
				}
				if(!min[key] || min[key] > vo[key])
				{
					min[key] = vo[key]
				}
			}

		}
		public function add(vo:StudentVO):void
		{
			_add(vo);
			_mean = 
			_standardDeviation = null;
			
			sendNotification(SMConst.UPDATE_STUDENT_LIST);
		}
		public function remove(vo:StudentVO):void
		{
		}
		public function clear():void
		{
			for (var i:int = 0; i < _list.length; i++)
			{
				delete _list[i];
			}
			_list = [];
			
			_total = new StudentVO();
			for each (var key:String in fields)
			{
				_total[key] = 0;
			}			
			
			_max = new StudentVO();
			_min = new StudentVO();
			_max.name = "最高値";
			_min.name = "最低値";
			
			_mean = 
			_standardDeviation = null;
		}

		public static function getInstance():StudentListProxy
		{
			if (!SMFacade.getInstance().hasProxy(PROXY_NAME))
			{
				 SMFacade.getInstance().registerProxy(new StudentListProxy());
			}
			return SMFacade.getInstance().retrieveProxy(PROXY_NAME) as StudentListProxy;
		}

	}
}