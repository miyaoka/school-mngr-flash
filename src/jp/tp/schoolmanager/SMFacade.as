package jp.tp.schoolmanager
{
	import org.puremvc.as3.patterns.facade.Facade;
	public class SMFacade extends Facade
	{
		public function SMFacade(enforcer:SingletonEnforcer)
		{
		}
		public static function getInstance():SMFacade
		{
			if(!instance)
			{
				instance = new SMFacade(new SingletonEnforcer());
			}
			return instance as SMFacade
		}
	}
}
class SingletonEnforcer{}