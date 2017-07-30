package net.flashdan.managers.window
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.core.FlexGlobals;
	import mx.core.IChildList;
	import mx.core.IMXMLObject;
	import mx.core.UIComponent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.SandboxMouseEvent;
	
	import net.flashdan.containers.customtitlewindow.CustomTitleWindow;
	import net.flashdan.containers.customtitlewindow.CustomTitleWindowBoundsEvent;
	import net.flashdan.managers.window.modifiers.IWindowModifier;
	
	import spark.components.TitleWindow;
	import spark.effects.Move;
	import spark.events.TitleWindowBoundsEvent;
	import spark.primitives.Rect;
	
	
	public class WindowManager implements IMXMLObject, IWindowManager {
		
		private var _parent:UIComponent;
		private var _windows:Dictionary = new Dictionary();
		private var _windowModifiers:Array;
		private var _windowBoundsArea:Rectangle;
		public var windowBoundsAreaFunction:Function;
		
		
		public function WindowManager() {
			
		}
		
		public function initialized(document:Object, id:String):void {
			_parent = document as UIComponent;
			_parent.addEventListener(FlexEvent.CREATION_COMPLETE, parentOnCreationComplete);
		}
		
		private function parentOnCreationComplete(event:FlexEvent):void {
			//listen for when title windows are added and removed
			_parent.systemManager.addEventListener(Event.ADDED, onAdded);
			_parent.systemManager.addEventListener(Event.REMOVED, onRemoved);
		}
		
		private function onAdded(event:Event):void {
			//This manager only manages TitleWindows that implement the IManagedWindow interface.
			if(event.target is IManagedWindow){
				var win:TitleWindow = event.target as TitleWindow;
				//wait for the creation complete event on the window before allowing any modifiers access to it.
				//If I don't do this, the logic in the PopUpManager that adds the window can mess with the logic in
				//a modifier that does logic in its onWindowAdd function.
				win.addEventListener(FlexEvent.CREATION_COMPLETE, onWindowCreationComplete);
			}
		}
		
		private function onWindowCreationComplete(event:FlexEvent):void {
			var win:TitleWindow = event.target as TitleWindow;
			//add this new title window to our managed windows list
			windows[win] = win;
			
			//add the window listeners needed by this manager
			addWindowListeners(win);
			
			for each(var modifier:IWindowModifier in windowModifiers){
				modifier.onWindowAdd(win);
			}
			
			notifyModifiersAreComplete();
		}
		
		private function notifyModifiersAreComplete():void {
			for each(var modifier:IWindowModifier in windowModifiers){
				modifier.onModifiersComplete();
			}
		}
		
		private function onRemoved(event:Event):void {
			if(event.target is IManagedWindow){
				var win:TitleWindow = event.target as TitleWindow;
				
				for each(var modifier:IWindowModifier in windowModifiers){
					modifier.onWindowRemove(win);
				}
				
				notifyModifiersAreComplete();
				
				//clean up the window listeners
				removeWindowListeners(win);
				delete windows[win];
			}
		}
		
		private function addWindowListeners(win:TitleWindow):void {
			win.addEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, onWindowMoving);
			win.addEventListener(TitleWindowBoundsEvent.WINDOW_MOVE_END, onWindowMoveEnd);
			win.addEventListener(CustomTitleWindowBoundsEvent.WINDOW_RESIZING, onWindowResizing);
			win.addEventListener(CustomTitleWindowBoundsEvent.WINDOW_RESIZE_END, onWindowResizingEnd);
		}
		
		private function removeWindowListeners(win:TitleWindow):void {
			win.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, onWindowMoving);
			win.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVE_END, onWindowMoveEnd);
			win.removeEventListener(CustomTitleWindowBoundsEvent.WINDOW_RESIZING, onWindowResizing);
			win.removeEventListener(CustomTitleWindowBoundsEvent.WINDOW_RESIZE_END, onWindowResizingEnd);
		}
		
		protected function onWindowMoving(event:TitleWindowBoundsEvent):void {
			var newAfterBounds:Rectangle = event.afterBounds.clone();
			var win:TitleWindow = event.target as TitleWindow;
			
			for each(var modifier:IWindowModifier in windowModifiers){
				if(modifier.enabled){
					modifier.onWindowMoving(win, newAfterBounds);
				}
			}
			
			notifyModifiersAreComplete();
			
			//update the original afterBounds based on any modifications made to the newAfterBounds
			setAfterBoundProperties(event.afterBounds, newAfterBounds);
		}        
		
		protected function onWindowResizing(event:CustomTitleWindowBoundsEvent):void {
			var newAfterBounds:Rectangle = event.afterBounds.clone();
			var win:CustomTitleWindow = event.target as CustomTitleWindow;
			
			for each(var modifier:IWindowModifier in windowModifiers){
				if(modifier.enabled){
					modifier.onWindowResizing(win, newAfterBounds);
				}
			}
			
			notifyModifiersAreComplete();
			
			setAfterBoundProperties(event.afterBounds, newAfterBounds);
		}
		
		protected function onWindowResizingEnd(event:CustomTitleWindowBoundsEvent):void {
			var afterBounds:Rectangle = event.afterBounds;
			var win:CustomTitleWindow = event.target as CustomTitleWindow;
			
			for each(var modifier:IWindowModifier in windowModifiers){
				if(modifier.enabled){
					modifier.onWindowResizeEnd(win, afterBounds);
				}
			}
			
			notifyModifiersAreComplete();
		}
		
		protected function onWindowMoveEnd(event:TitleWindowBoundsEvent):void {
			var afterBounds:Rectangle = event.afterBounds;
			var win:TitleWindow = event.target as TitleWindow;
			
			for each(var modifier:IWindowModifier in windowModifiers){
				if(modifier.enabled){
					modifier.onWindowMoveEnd(win, afterBounds);
				}
			}
			
			notifyModifiersAreComplete();
		}
		
		protected function setAfterBoundProperties(original:Rectangle, newAfterBounds:Rectangle):void {
			original.x = newAfterBounds.x; 
			original.y = newAfterBounds.y;
			original.width = newAfterBounds.width;
			original.height = newAfterBounds.height;
		}
		
		[ArrayElementType("net.flashdan.managers.window.modifiers.IWindowModifier")]
		public function get windowModifiers():Array {
			return _windowModifiers;
		}
		public function set windowModifiers(value:Array):void {
			_windowModifiers = value;
			
			for each(var modifier:IWindowModifier in _windowModifiers){
				modifier.windowManager = this;
			}
		}
		
		public function get windowBoundsArea():Rectangle {
			_windowBoundsArea = new Rectangle(0,0,
				FlexGlobals.topLevelApplication.stage.stageWidth,
				FlexGlobals.topLevelApplication.stage.stageHeight);
			
			if(windowBoundsAreaFunction != null){
				_windowBoundsArea = windowBoundsAreaFunction();
			}
			
			return _windowBoundsArea;
		}
		
		public function get windows():Dictionary {
			return _windows;
		}
		
		public function updateWindow(win:TitleWindow, bounds:Rectangle):void {
			//loop through the modifiers and notify them of the window update
			for each(var modifier:IWindowModifier in windowModifiers){
				if(modifier.enabled){
					modifier.onWindowUpdated(win, bounds);
				}
			}
		}
		
	}
}