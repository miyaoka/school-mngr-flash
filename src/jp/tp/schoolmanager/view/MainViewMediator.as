package jp.tp.schoolmanager.view
{

	import flash.events.Event;
	
	import jp.tp.schoolmanager.SMFacade;
	import jp.tp.schoolmanager.constants.SMConst;
	import jp.tp.puremvc.ViewMediator;
	import jp.tp.schoolmanager.model.StudentListProxy;
	import jp.tp.schoolmanager.model.StudentProxy;
	import jp.tp.schoolmanager.vo.StudentVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MainViewMediator extends ViewMediator
	{
		public static const NAME:String = "MainView";
		public function MainViewMediator(view:Object)
		{
			super(view);
			view.addEventListener(MainView.STUDENT_LIST_RELOAD, onReload);
			view.geneNum = 30;
		}
		private function get view():MainView
		{
			return viewComponent as MainView;
		}
		private function onReload(e:Event):void
		{
			sendNotification(SMConst.CALL_RAND_STUDENT_LIST, view.geneNum);
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