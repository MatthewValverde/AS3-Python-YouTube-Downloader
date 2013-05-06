package org.mcv.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class ObjectEvent extends Event 
	{
		public var object:Object;
		
		public static var COMPLETE:String = "objectEventComplete";
		
		public function ObjectEvent(type:String, object:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			this.object = object;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ObjectEvent(type, object, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ObjectEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}