package net.flashdan.managers.window.modifiers
{
	import flash.geom.Rectangle;
	
	import net.flashdan.containers.customtitlewindow.CustomTitleWindow;
	import net.flashdan.managers.window.IWindowManager;
	
	import spark.components.TitleWindow;
	
	public class WindowModifier implements IWindowModifier {
		
		private var _enabled:Boolean = true;
		private var _windowManager:IWindowManager;
		
		public function WindowModifier() {
		}
		
		public function onWindowAdd(window:TitleWindow):void {
			//override this function
		}
		
		public function onWindowRemove(window:TitleWindow):void {
			
		}
		
		public function onWindowMoving(window:TitleWindow, bounds:Rectangle):void {
			//override this function
		}
		
		public function onWindowMoveEnd(window:TitleWindow, bounds:Rectangle):void {
			//override this function
		}
		
		public function onWindowResizing(window:CustomTitleWindow, bounds:Rectangle):void {
			//override this function
		}
		
		public function onWindowResizeEnd(window:CustomTitleWindow, bounds:Rectangle):void {
			
		}
		
		public function onWindowUpdated(window:TitleWindow, bounds:Rectangle):void {
			
		}
		
		public function onModifiersComplete():void {
			
		}
		
		public function get windowManager():IWindowManager {
			return _windowManager;
		}
		public function set windowManager(value:IWindowManager):void {
			_windowManager = value;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void {
			_enabled = value;
		}
		
		
	}
}