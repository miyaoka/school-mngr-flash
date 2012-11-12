package jp.tp.schoolmanager.view
{

	import flash.events.Event;
	
	import jp.tp.schoolmanager.SMFacade;
	import jp.tp.schoolmanager.constants.SMConst;
	import jp.tp.schoolmanager.model.StudentListProxy;
	import jp.tp.schoolmanager.model.StudentProxy;
	import jp.tp.schoolmanager.vo.StudentVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MainViewMediator extends Mediator
	{
		public static const NAME:String = "MainViewMediator";
		public function MainViewMediator(view:Object)
		{
			super(NAME, view);
			initView();
		}
		public static function getInstance():MainViewMediator
		{
			return SMFacade.getInstance().retrieveMediator(NAME) as MainViewMediator;
		}
		private function get view():MainView
		{
			return viewComponent as MainView;
		}
		private function initView():void
		{
			view.addEventListener(MainView.STUDENT_LIST_RELOAD, onReload);

		}	
		private function onReload(e:Event):void
		{
			sendNotification(SMConst.CALL_RAND_STUDENT_LIST, Math.random() * 100 + 20);
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