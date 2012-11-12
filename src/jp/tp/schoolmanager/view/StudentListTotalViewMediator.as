package jp.tp.schoolmanager.view
{

	import jp.tp.schoolmanager.SMFacade;
	import jp.tp.schoolmanager.constants.SMConst;
	import jp.tp.schoolmanager.model.StudentListProxy;
	import jp.tp.schoolmanager.model.StudentProxy;
	import jp.tp.schoolmanager.vo.StudentVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class StudentListTotalViewMediator extends Mediator
	{
		public static const NAME:String = "StudentListTotalViewMediator";
		public function StudentListTotalViewMediator(view:Object)
		{
			super(NAME, view);
			initView();
		}
		public static function getInstance():StudentListTotalViewMediator
		{
			return SMFacade.getInstance().retrieveMediator(NAME) as StudentListTotalViewMediator;
		}
		private function get view():StudentListTotalView
		{
			return viewComponent as StudentListTotalView;
		}
		private function initView():void
		{

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
					var px:StudentListProxy = StudentListProxy.getInstance();
					view.ac.source = [
						px.mean, 
						px.standardDeviation,
						px.max,
						px.min
					];
					break;
			}
		}
	}
	
}