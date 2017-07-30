package net.flashdan.managers.window.modifiers {
	import flash.geom.Rectangle;
	
	import mx.events.EffectEvent;
	
	import net.flashdan.containers.customtitlewindow.CustomTitleWindow;
	
	import spark.components.TitleWindow;
	import spark.effects.Move;
	import spark.events.TitleWindowBoundsEvent;
	
	public class WindowBoundaryEnforcer extends WindowModifier {
		
		private var _softBoundaries:Boolean = false;
		private var _softBoundariesMoveEffect:Move;
		
		private var _notifyOfUpdate:Boolean = false;
		private var _lastWindowModified:TitleWindow;
		private var _lastWindowModifiedBounds:Rectangle;
		
		public function WindowBoundaryEnforcer() {
			super();
		}
		
		override public function onWindowAdd(window:TitleWindow):void {
			if(window is CustomTitleWindow){
				//make sure enforceBoundaries is off as this would interfere with the enforce boundary logic in this class
				CustomTitleWindow(window).enforceBoundaries = false;
			}
		}
		
		override public function onWindowMoving(window:TitleWindow, winBounds:Rectangle):void {
			if(!softBoundaries){//don't run this logic if soft boundaries is on.
				var windowBoundsArea:Rectangle = windowManager.windowBoundsArea;
				if (winBounds.left < windowBoundsArea.left) {
					winBounds.left = windowBoundsArea.left;
				} else if (winBounds.right > windowBoundsArea.right) {
					winBounds.left = Math.max(windowBoundsArea.left,(windowBoundsArea.width+windowBoundsArea.left) - winBounds.width);
				}
				if (winBounds.top < windowBoundsArea.top) {
					winBounds.top = windowBoundsArea.top;
				} else if (winBounds.bottom > windowBoundsArea.bottom) {
					winBounds.top = Math.max(windowBoundsArea.top,(windowBoundsArea.height+windowBoundsArea.top) - winBounds.height);
				}
			}
		}
		
		override public function onWindowResizing(window:CustomTitleWindow, winBounds:Rectangle):void {
			var windowBoundsArea:Rectangle = windowManager.windowBoundsArea;
			
			//always restrict sizing to within the bounds area
			if (winBounds.left < windowBoundsArea.left) {
				winBounds.left = windowBoundsArea.left;
			} else if (winBounds.right > windowBoundsArea.right) {
				winBounds.right = windowBoundsArea.right;
			}
			
			if (winBounds.top < windowBoundsArea.top) {
				winBounds.top = windowBoundsArea.top;
			} else if (winBounds.bottom > windowBoundsArea.bottom) {
				winBounds.bottom = windowBoundsArea.bottom;
			}
		}
		
		override public function onWindowMoveEnd(window:TitleWindow, bounds:Rectangle):void {
			if(softBoundaries){
				var windowBoundsArea:Rectangle = windowManager.windowBoundsArea;
				var xVal:Number = bounds.left;
				var yVal:Number = bounds.top;
				
				//Check to see if the window is out of bounds, and if it is, move it back on screen
				if (bounds.left < windowBoundsArea.left) {
					xVal = windowBoundsArea.left;
				} else if (bounds.right > windowBoundsArea.right) {
					xVal = Math.max(windowBoundsArea.left,(windowBoundsArea.width+windowBoundsArea.left) - bounds.width);
				}
				if (bounds.top < windowBoundsArea.top) {
					yVal = windowBoundsArea.top;
				} else if (bounds.bottom > windowBoundsArea.bottom) {
					yVal = Math.max(windowBoundsArea.top,(windowBoundsArea.height+windowBoundsArea.top) - bounds.height);
				}
				
				//Only move if the window was adjusted to move back into the screen
				if(xVal != bounds.left || yVal != bounds.top){
					if(softBoundariesMoveEffect){
						window.enabled = false;//disable the window while the effect plays
						softBoundariesMoveEffect.target = window;
						softBoundariesMoveEffect.xTo = xVal;
						softBoundariesMoveEffect.yTo = yVal;
						softBoundariesMoveEffect.addEventListener(EffectEvent.EFFECT_END, 
							function():void {
								window.enabled = true;
							}
						);
						softBoundariesMoveEffect.play();
					}
					else {
						//default move with no effect
						window.x = xVal;
						window.y = yVal;
					}
					
					_notifyOfUpdate = true;
					_lastWindowModified = window;
					_lastWindowModifiedBounds = new Rectangle(xVal, yVal, window.width, window.height);
				}
			}
		}
		
		override public function onModifiersComplete():void {
			//check if we modified the window.  If we did, then we need to tell the window manager, so it can
			//relay this information to other modifiers that might need this information
			if(_notifyOfUpdate){
				_notifyOfUpdate = false;
				windowManager.updateWindow(_lastWindowModified, _lastWindowModifiedBounds);
			}
			
		}
		
		public function set softBoundaries(val:Boolean):void {
			if(val != _softBoundaries){
				_softBoundaries = val;
			}
		}
		public function get softBoundaries():Boolean {
			return _softBoundaries;
		}
		
		public function set softBoundariesMoveEffect(val:Move):void {
			_softBoundariesMoveEffect = val;
		}
		public function get softBoundariesMoveEffect():Move {
			return _softBoundariesMoveEffect;
		}
		
	}
}