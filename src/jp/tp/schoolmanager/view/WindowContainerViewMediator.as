package jp.tp.schoolmanager.view
{

	import jp.tp.puremvc.ViewMediator;
	import jp.tp.schoolmanager.constants.SMConst;
	
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.TitleWindow;
	
	public class WindowContainerViewMediator extends ViewMediator
	{
		public static const NAME:String = "WindowContainerView";
		public function WindowContainerViewMediator(viewComponent:Object)
		{
			super(viewComponent);
			openStudentListWindow();
		}
		private function get view():WindowContainerView
		{
			return viewComponent as WindowContainerView;
		}
		private function openStudentListWindow():void
		{
			var win:TitleWindow = new StudentListWindow();
			PopUpManager.addPopUp(win, view.root);
		}
		private function openStudentEditWindow():void
		{
			var win:TitleWindow = new StudentEditWindow();
			PopUpManager.addPopUp(win, view.root, true);
			PopUpManager.centerPopUp(win);
		}
		override public function listNotificationInterests():Array
		{
			return [
				SMConst.CALL_OPEN_STUDENT_LIST_WINDOW,
				SMConst.CALL_OPEN_STUDENT_EDIT_WINDOW
			];
		}

		override public function handleNotification(n:INotification):void
		{
			switch (n.getName())
			{
				case SMConst.CALL_OPEN_STUDENT_LIST_WINDOW:
					openStudentListWindow();
					break;
				case SMConst.CALL_OPEN_STUDENT_EDIT_WINDOW:
					openStudentEditWindow();
					break;
					
			}
		}
	}
	
}