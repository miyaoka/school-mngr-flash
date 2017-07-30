package net.flashdan.managers.window.modifiers {
	import flash.geom.Rectangle;
	
	import net.flashdan.containers.customtitlewindow.CustomTitleWindow;
	
	import spark.components.TitleWindow;
	
	public class WindowSnapper extends WindowModifier {
		
		public var snapDistance:Number = 8;
		public var padding:Number = 5;
		public var snapToEdges:Boolean = true;
		
		public function WindowSnapper() {
			super();
		}
		
		override public function onWindowMoving(window:TitleWindow, bounds:Rectangle):void {
			snapWindow(window, bounds);
		}
		
		override public function onWindowResizing(window:CustomTitleWindow, bounds:Rectangle):void {
			snapWindow(window,bounds,window.currentResizeHandle);
		}
		
		protected function snapWindow(dragWindow:TitleWindow, rect:Rectangle, dragHandle:String=null):void {
			var xDist:Number = NaN;                         
			var yDist:Number = NaN;                         
			var dragRect:Rectangle = getPaddedBounds(rect);
			var windowBoundsArea:Rectangle = windowManager.windowBoundsArea;
			
			// find the minimum snap (if one exists)                         
			for each(var window:TitleWindow in windowManager.windows) {                                 
				if(window != dragWindow && dragRect.intersects(getPaddedBounds(rect))) { 
					if(!dragHandle || CustomTitleWindow.isLeft(dragHandle)) {                                                 
						xDist = calculateSnapDistance(rect.x, window.x + window.width + padding, xDist);                                                 
						xDist = calculateSnapDistance(rect.x, window.x, xDist);                                         
					}                                          
					if(!dragHandle || CustomTitleWindow.isRight(dragHandle)) {                                                 
						xDist = calculateSnapDistance(rect.x + rect.width, window.x - padding, xDist);                                                 
						xDist = calculateSnapDistance(rect.x + rect.width, window.x + window.width, xDist);                                         
					}                                          
					if(!dragHandle || CustomTitleWindow.isTop(dragHandle)) {                                                 
						yDist = calculateSnapDistance(rect.y, window.y + window.height + padding, yDist);                                                 
						yDist = calculateSnapDistance(rect.y, window.y, yDist);                                         
					}                                          
					if(!dragHandle || CustomTitleWindow.isBottom(dragHandle)) {                                                 
						yDist = calculateSnapDistance(rect.y + rect.height, window.y - padding, yDist);                                   
						yDist = calculateSnapDistance(rect.y + rect.height, window.y + window.height, yDist);                                         
					}                                 
				}                         
			} 
			
			//check if we should snap on the edges
			if(snapToEdges){
				//left edge
				if(!dragHandle || CustomTitleWindow.isLeft(dragHandle)) { 
					xDist = calculateSnapDistance(rect.x, windowBoundsArea.left, xDist); 
				}
				//right edge
				if(!dragHandle || CustomTitleWindow.isRight(dragHandle)) {
					xDist = calculateSnapDistance(rect.x + rect.width, windowBoundsArea.right, xDist);
				}
				//top edge
				if(!dragHandle || CustomTitleWindow.isTop(dragHandle)) {
					yDist = calculateSnapDistance(rect.y, windowBoundsArea.top, yDist); 
				}
				//bottom edge
				if(!dragHandle || CustomTitleWindow.isBottom(dragHandle)) { 
					yDist = calculateSnapDistance(rect.y + rect.height, windowBoundsArea.bottom, yDist);
				}
			}
			
			
			var xChanged:Boolean = !isNaN(xDist);                         
			var yChanged:Boolean = !isNaN(yDist);                          
			// update the x, y, width, height based on the user interaction                         
			// dragHandle contains either a MDIResizeHandle value, or null if the window is being dragged                         
			switch(dragHandle) {                                 
				case CustomTitleWindow.LEFT:                                         
					if(xChanged) {                                                 
						rect.x -= xDist;                                                 
						rect.width += xDist;                                         
					}                                 
					break;                                  
				case CustomTitleWindow.RIGHT:                                         
					if(xChanged )                                                 
						rect.width -= xDist;                                 
					break;                                  
				case CustomTitleWindow.TOP:      
					if(yChanged) {                                                 
						rect.y -= yDist;                                                 
						rect.height += yDist;                                         
					}                                 
					break;                                  
				case CustomTitleWindow.BOTTOM:                                         
					if(yChanged)                                                 
						rect.height -= yDist;                                 
					break;                                  
				case CustomTitleWindow.TOP_LEFT:                                         
					if(xChanged) {                                                 
						rect.x -= xDist;                                                 
						rect.width += xDist;                                         
					}                                         
					if(yChanged) {                                                 
						rect.y -= yDist;                                                 
						rect.height += yDist;                                         
					}                                 
					break;                                  
				case CustomTitleWindow.TOP_RIGHT:                                         
					if(xChanged)                                                 
						rect.width -= xDist;                                         
					if(yChanged) {                                                 
						rect.y -= yDist;                                                 
						rect.height += yDist;                                         
					}                                 
					break;                                  
				case CustomTitleWindow.BOTTOM_LEFT:                                         
					if(xChanged) {                                                 
						rect.x -= xDist;                                                 
						rect.width += xDist;                                         
					}                                         
					if(yChanged)                                                 
						rect.height -= yDist;                                 
					break;                                  
				case CustomTitleWindow.BOTTOM_RIGHT:                                         
					if(yChanged)                                                 
						rect.height -= yDist;                                         
					if(xChanged)                                                 
						rect.width -= xDist;                                 
					break;                                  
				default:                                         
					if(xChanged)                                                 
						rect.x -= xDist;                                         
					if(yChanged)                                                 
						rect.y -= yDist;                                 
					break;                         
			} 
		}
		
		
		protected function calculateSnapDistance(edge1:Number, edge2:Number, currentShift:Number):Number {                         
			var gap:Number = edge1 - edge2;                          
			// if we're within snapping range                         
			if(gap > -snapDistance && gap < snapDistance) {                                 
				// if this snap is shorter than the currentShift                                 
				if(isNaN(currentShift) || Math.abs(gap) < Math.abs(currentShift))  {                                 
					currentShift = gap;                         
				}   
			}
			
			return currentShift;                 
		} 
		
		protected function getPaddedBounds(rect:Rectangle):Rectangle {                         
			return new Rectangle(rect.x - padding - snapDistance/2, 
				rect.y - padding - snapDistance/2,                                                                  
				rect.width + padding + snapDistance,                                                                  
				rect.height + padding + snapDistance 
			);                
		} 
	}
}