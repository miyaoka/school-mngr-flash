package jp.tp.schoolmanager.vo
{
	[Bindable]
	public class StudentVO
	{
		public var id:Number;
		public var name:String;
		public var firstName:String;
		public var lastName:String;
		
		public var strength:Number;
		public var looks:Number;
		public var sociality:Number;
		public var wealth:Number;
		public var intelligence:Number;
		
		public var strengthScore:Number;
		public var looksScore:Number;
		public var socialityScore:Number;
		public var wealthScore:Number;
		public var intelligenceScore:Number;
		
		public function StudentVO()
		{
		}

		public function get fullName():String
		{
			return lastName + " " + firstName;
		}

	}
}