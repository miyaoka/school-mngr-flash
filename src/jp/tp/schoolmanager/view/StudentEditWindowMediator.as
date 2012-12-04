package jp.tp.schoolmanager.view
{

	import flash.events.Event;
	
	import jp.tp.puremvc.ViewMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	
	public class StudentEditWindowMediator extends ViewMediator
	{
		public static const NAME:String = "StudentEditWindowMediator";
		public function StudentEditWindowMediator(view:Object)
		{
			super(view);
		}
		private function get view():StudentEditWindow
		{
			return viewComponent as StudentEditWindow;
		}
		override public function listNotificationInterests():Array
		{
			return [
			];
		}

		override public function handleNotification(n:INotification):void
		{
			switch (n.getName())
			{
			}
		}
	}
	
}