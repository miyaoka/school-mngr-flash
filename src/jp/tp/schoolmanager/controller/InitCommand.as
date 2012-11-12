package jp.tp.schoolmanager.controller
{	
	import jp.tp.schoolmanager.constants.SMConst;
	import jp.tp.schoolmanager.helper.StudentHelper;
	import jp.tp.schoolmanager.vo.StudentVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class InitCommand extends SimpleCommand
	{
		public function InitCommand()
		{
			super();
		}
		
		override public function execute(n:INotification):void
		{
			facade.registerCommand(SMConst.CALL_ADD_STUDENT, StudentCommand);
			facade.registerCommand(SMConst.CALL_RAND_STUDENT_LIST, StudentCommand);
			
			
			
//			facade.registerCommand(SMConst.CALL_ADD_LOG, AddLogCommand);
			/*
			facade.registerCommand(PureMVCConst.CALL_ADD_LOG, AddLogCommand);
			facade.registerCommand(PureMVCConst.CALL_ADD_POPUP, PopupCommand);
			facade.registerCommand(PureMVCConst.CALL_CLOSE_POPUP, PopupCommand);
			facade.registerCommand(PureMVCConst.CALL_CANCEL_POPUP, PopupCommand);
			
			facade.registerCommand(PureMVCConst.SET_APP_INFO, AppInfoCommand);
			facade.registerCommand(PureMVCConst.CALL_SHOW_APP_INFO, AppInfoCommand);
			
			facade.registerCommand(PureMVCConst.CALL_ADD_TASK, TaskCommand);
			facade.registerCommand(PureMVCConst.CALL_UNSHIFT_TASK, TaskCommand);
			facade.registerCommand(PureMVCConst.CALL_COMPLETE_TASK, TaskCommand);
			
			
			facade.registerCommand(PureMVC_SMSConst.CALL_SMS_INIT, SMS_InitCommand);
			sendNotification(PureMVC_SMSConst.CALL_SMS_INIT);
			
			facade.registerCommand(PureMVCSplexConst.CALL_SPLEX_INIT, SplexInitCommand);
			sendNotification(PureMVCSplexConst.CALL_SPLEX_INIT);
			*/
		}

	}
}