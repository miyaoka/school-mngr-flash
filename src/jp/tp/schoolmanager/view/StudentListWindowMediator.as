package jp.tp.schoolmanager.view
{

	import flash.events.Event;
	
	import jp.tp.puremvc.ViewMediator;
	import jp.tp.schoolmanager.constants.SMConst;
	
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	
	public class StudentListWindowMediator extends ViewMediator
	{
		public static const NAME:String = "StudentListWindow";
		public function StudentListWindowMediator(viewComponent:Object)
		{
			super(viewComponent);
			view.addEventListener(StudentListWindow.ADD_NEW_STUDENT, onAddNewStudent);
		}
		private function onAddNewStudent(e:Event):void
		{
			sendNotification(SMConst.CALL_OPEN_STUDENT_EDIT_WINDOW);
		}
		
		private function get view():StudentListWindow
		{
			return viewComponent as StudentListWindow;
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