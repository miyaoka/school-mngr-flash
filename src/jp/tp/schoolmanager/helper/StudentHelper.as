package jp.tp.schoolmanager.helper
{
	import jp.tp.schoolmanager.vo.StudentVO;

	public class StudentHelper
	{
		private static const charcodeA:Number = "A".charCodeAt(0);
		
		public static var num:Number = 0;
		public static function random():StudentVO
		{
			var vo:StudentVO = new StudentVO();
			var len:Number = Math.random() * 7 + 3;
			var name:String = "";
			while(len-- > 0)
			{
				name = name + randomStr();
			}
			vo.name = name;
			num++;
			vo.id = num;
//			vo.name = num.toString();
			vo.intelligence = randomIntelligence();
			vo.looks = randomNum();
			vo.sociality = randomNum();
			vo.strength = randomTall();
			vo.wealth = randomWealth();
			return vo;
		}
		private static function randomStr():String
		{
			return String.fromCharCode(charcodeA + Math.random() * 26)			
		}
		private static function randomNum():Number
		{
			return transRandom4(0.5, 0.3) * 100;
		}
		private static function randomTall():Number
		{
			return transRandom4(0.5, 0.3) * 40 + 145;
		}
		private static function randomWealth():Number
		{
			return Math.ceil(transRandom4(0.3, 0.3) * transRandom4(0.5, 0.5) * 20) * 1000;
		}
		private static function randomIntelligence():Number
		{
			return transRandom4(0.6, 0.3) * 100;
		}
		
		/* 
		変形4平方ランダム。
		値に沿ってrandomの割合を変換して返す。
		中心点に設定した部分が一番確率が高く、両脇の確率がほぼ０になる。
		
		balance - 中心点の位置。0～1で指定する。省略すれば0.5
		velvet  - なだらかさ。0～1で指定する。
		　　　　　0で尖った形（人←こんなん）、0.2で３角形、0.3で正規分布に近く、
		　　　　　0.5～0.7でドーム型、0.9で台形になり、1は普通のランダムと同じ一様な分布となる
		　　　　　省略すれば0.3
		*/
		private static function transRandom4(balance:Number = 0.5, velvet:Number = 0.3):Number
		{
			var ans:Number;
			var sqrtFunctionY:Number;
			var reBalance:Number;
			var x:Number;
			x = Math.random();
			if (x < balance){
				sqrtFunctionY = sqrt4(x / balance) * balance;
			}else{
				reBalance = 1 - balance;
				sqrtFunctionY= -sqrt4((1 - x)/reBalance) * reBalance + 1;
			}
			ans = sqrtFunctionY*(1 - velvet) + x * velvet;
			return ans;
		}
		private static function sqrt4(arg:Number):Number{
			return Math.sqrt(Math.sqrt(arg));
		}		
	}
}