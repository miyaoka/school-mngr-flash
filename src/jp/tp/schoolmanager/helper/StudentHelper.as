package jp.tp.schoolmanager.helper
{
	import jp.tp.schoolmanager.constants.NameList;
	import jp.tp.schoolmanager.vo.StudentVO;

	public class StudentHelper
	{
		private static const charcodeA:Number = "A".charCodeAt(0);
		
		public static var num:Number = 0;
		public static function random():StudentVO
		{
			var vo:StudentVO = new StudentVO();
			
			//lastname
			vo.lastName = NameList.familyNameList[Math.floor(Math.random() * Math.random() * Math.random() * NameList.familyNameList.length)];

			//firstname
			vo.firstName = 
//				(vo.gender == 0) 
				false
//				Math.random() > 0.5
				? NameList.femaleNameList[Math.floor(Math.random() * NameList.femaleNameList.length)]
				: NameList.maleNameList[Math.floor(Math.random() * NameList.maleNameList.length)];
			
			num++;
			vo.id = num;
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
			return minmax(normalDistribution(0.5, 0.125)) * 100;
			return transRandom4(0.5, 0.3) * 100;
		}
		private static function randomTall():Number
		{
			return normalDistribution(170, 7);
			return transRandom4(0.5, 0.3) * 40 + 145;
		}
		private static function randomWealth():Number
		{
			return Math.ceil(
				Math.sqrt(-2 * Math.log(Math.random())) // 0~1~5 mean 1.25
				* 4000 / 1000
			) * 1000;
			return Math.floor((Math.max(normalDistribution(3000, 500, 10, 1), 1000)) / 1000) * 1000;
//			return Math.ceil(transRandom4(0.3, 0.3) * transRandom4(0.5, 0.5) * 20) * 1000;
		}
		private static function randomIntelligence():Number
		{
			var iq:Number = normalDistribution(0.6, 0.12);
			return minmax(iq) * 100;
			
			var total:Number = 0;
			for(var i:int = 0; i < 5; i++)
			{
				total += minmax(iq + (Math.random() - 0.5) * 0.2);
			}
			return total * 100;
//			return transRandom4(0.65, 0.3) * 100;
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
		/**
		 * 正規分布
		 * average: 平均
		 * sd: 標準偏差 (av-sd)から(av+sd)の範囲内が68.26%、2sdが95.44%、3sdが99.74%になる
		 * 
		 * over/under: 平均以上／以下の場合に掛ける係数
		 */ 
		private static function normalDistribution(mean:Number = 0.5, sd:Number= 0.1, over:Number = 1, under:Number = 1):Number
		{
			//独立した乱数2つ
			var r1:Number = 1 - Math.random(); // 0 < x <= 1
			var r2:Number = Math.random(); // 0 <= x < 1
			
						
			//Box-Muller's method
			return sd 
			* Math.sqrt(-2 * Math.log(r1))
			* Math.sin(2 * Math.PI * r2) // 0 ~ 1 ~ 0 ~ -1
			* ((r2 < 0.5) ? over : under) //r2が0.5未満ならsinの上弦で正　：0.5以上なら下弦で負
			+ mean;
		}
		private static function minmax(value:Number, min:Number = 0, max:Number = 1):Number
		{
			return Math.min(Math.max(value, min), max);
		}
	}
}