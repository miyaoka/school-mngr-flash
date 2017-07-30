package jp.tp.schoolmanager.view
{

	import jp.tp.puremvc.ViewMediator;
	import jp.tp.schoolmanager.SMFacade;
	import jp.tp.schoolmanager.constants.SMConst;
	import jp.tp.schoolmanager.model.StudentListProxy;
	import jp.tp.schoolmanager.model.StudentProxy;
	import jp.tp.schoolmanager.vo.StudentVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class StudentListViewMediator extends ViewMediator
	{
		public static const NAME:String = "StudentListViewMediator";
		public function StudentListViewMediator(view:Object)
		{
			super(view);
			update();
		}
		private function get view():StudentListView
		{
			return viewComponent as StudentListView;
		}
		private function update():void
		{
			view.ac.source = StudentListProxy.getInstance().list;
		}
		override public function listNotificationInterests():Array
		{
			return [
				SMConst.UPDATE_STUDENT_LIST
			];
		}
		override public function handleNotification(n:INotification):void
		{
			switch (n.getName())
			{
				case SMConst.UPDATE_STUDENT_LIST:
					update();
					break;
			}
		}
	}
	
}