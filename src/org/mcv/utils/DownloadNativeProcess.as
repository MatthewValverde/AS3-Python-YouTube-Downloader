package org.mcv.utils 
{
	import flash.desktop.NativeProcess;
	
	public class DownloadNativeProcess extends NativeProcess 
	{
		public var url:String;
		
		public var title:String;
				
		public var destination:String;
		
		public var fullPath:String;
		
		public function DownloadNativeProcess() 
		{
			super();
		}
		
	}

}