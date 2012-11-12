package jp.tp.schoolmanager.controller
{	
	import jp.tp.schoolmanager.constants.SMConst;
	import jp.tp.schoolmanager.helper.StudentHelper;
	import jp.tp.schoolmanager.model.StudentListProxy;
	import jp.tp.schoolmanager.model.StudentProxy;
	import jp.tp.schoolmanager.vo.StudentVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StudentCommand extends SimpleCommand
	{
		public function StudentCommand()
		{
			super();
		}
		
		override public function execute(n:INotification):void
		{
			var px:StudentListProxy = StudentListProxy.getInstance();
			switch(n.getName())
			{
				case SMConst.CALL_ADD_STUDENT:
					px.add(n.getBody() as StudentVO);
					break;
				case SMConst.CALL_RAND_STUDENT_LIST:
					px.clear();
					var i:Number = Number(n.getBody());
					var list:Array = [];
					while(i-- > 0)
					{
						list.push(StudentHelper.random());
					}
					px.addList(list);
					break;
			}
		}

	}
}