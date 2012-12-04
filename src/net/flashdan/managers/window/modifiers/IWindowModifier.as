package net.flashdan.managers.window.modifiers
{
	import flash.geom.Rectangle;
	
	import net.flashdan.containers.customtitlewindow.CustomTitleWindow;
	import net.flashdan.managers.window.IWindowManager;
	
	import spark.components.TitleWindow;
	
	public interface IWindowModifier
	{
		
		function set enabled(value:Boolean):void;
		function get enabled():Boolean;
		
		//lifecycle events
		function onWindowAdd(window:TitleWindow):void;
		function onWindowRemove(window:TitleWindow):void;
		
		//user initiated interaction events
		function onWindowMoving(window:TitleWindow, bounds:Rectangle):void;
		function onWindowMoveEnd(window:TitleWindow, bounds:Rectangle):void;
		function onWindowResizing(window:CustomTitleWindow, bounds:Rectangle):void;
		function onWindowResizeEnd(window:CustomTitleWindow, bounds:Rectangle):void;
		
		//manual update of window
		function onWindowUpdated(window:TitleWindow, bounds:Rectangle):void;
		function onModifiersComplete():void;
		
		function set windowManager(value:IWindowManager):void;
		function get windowManager():IWindowManager;
		
		
		
	}
}