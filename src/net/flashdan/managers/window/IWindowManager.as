package net.flashdan.managers.window {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import spark.components.TitleWindow;
	
	public interface IWindowManager {
		
		function get windows():Dictionary;
		function get windowModifiers():Array;
		function get windowBoundsArea():Rectangle;
		function updateWindow(window:TitleWindow, bounds:Rectangle):void;
		
	}
}