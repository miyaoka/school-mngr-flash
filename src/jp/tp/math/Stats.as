package jp.tp.math
{
	public class Stats
	{
		public static const PI2:Number = Math.PI * 2;
		public function Stats()
		{
		}

		/**
		 * 正規分布による乱数を生成する
		 * 
		 * mean: 平均
		 * sd: 標準偏差 (av-sd)から(av+sd)の範囲内が68.26%、2sdが95.44%、3sdが99.74%になる
		 * 
		 * over/under: 平均以上／以下の場合に掛ける係数
		 */ 
		public static function randND(mean:Number = 0.5, sd:Number= 0.1, over:Number = 1, under:Number = 1):Number
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
		
		/**
		 * 正規分布の点aにおける確率を返す
		 * 
		 * a:確率変数
		 * mean:平均
		 * variance:標準偏差
		 */
		public static function probabilityDensity(a:Number, mean:Number, variance:Number):Number
		{
			return Math.exp( -Math.pow(a - mean, 2 ) / ( 2 * variance ) ) / Math.sqrt(PI2 * variance);
		}
		
		/**
		 * 区間 [-∞,a] における確率密度を返す
		 */
		public static function lowerDistribution(a:Number, mean:Number, variance:Number):Number
		{
			a = ( a - mean ) / Math.sqrt( 2 * variance );
			var p:Number = erf( Math.abs( a ) ) / 2.0;
			
			if ( a < 0 )
				p = 0.5 - p;
			else
				p += 0.5;
			
			return p;
		}
		
		/**
		 * 区間 [a,b] における確率密度を返す
		 */ 
		public static function cumulativeDistribution(a:Number, b:Number, mean:Number, variance:Number):Number
		{
			if ( a == b ) return 0;
			if ( a > b ) 
			{
				var d:Number = a;
				a = b;
				b = d;
			}
			
			a = ( a - mean ) / Math.sqrt( 2 * variance );
			b = ( b - mean ) / Math.sqrt( 2 * variance );
			
			if ( a > 0 && b > 0 ) 
			{
				return( ( erf( b ) - erf( a ) ) / 2 );
			}
			if ( a < 0 && b > 0 ) 
			{
				return( ( erf( b ) + erf( -a ) ) / 2 );
			}
			return( ( erf( -a ) - erf( -b ) ) / 2 );
		}		
		
		private static const erfa1:Number =  0.254829592;
		private static const erfa2:Number = -0.284496736;
		private static const erfa3:Number =  1.421413741;
		private static const erfa4:Number = -1.453152027;
		private static const erfa5:Number =  1.061405429;
		private static const erfp1:Number  =  0.3275911;
		
		/**
		 * 誤差関数(Error Function)
		 */
		public static function erf(x:Number):Number
		{
			// Save the sign of x
			var sign:int = 1;
			if (x < 0)
				sign = -1;
			x = Math.abs(x);
			
			// A&S formula 7.1.26
			var t:Number = 1.0/(1.0 + erfp1 * x);
			var y:Number = 1.0 - (((((erfa5 * t + erfa4) * t) + erfa3) * t + erfa2) * t + erfa1) * t * Math.exp(-x * x);
			
			return sign * y;
		}		
	}
}