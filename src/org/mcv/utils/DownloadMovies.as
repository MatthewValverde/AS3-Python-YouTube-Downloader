package org.mcv.utils
{
	import flash.display.Sprite;
	import org.mcv.utils.DownloadNativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import __AS3__.vec.Vector;
	import flash.events.EventDispatcher;
	
	public class DownloadMovies
	{
		public static var PROGRESS_EVENT:String = "progress_event";
		public static var DOWNLOAD_COMPLETE:String = "download_complete";
		protected static var dispatch:EventDispatcher;
		public static var exeFile:File;
		public static var workingDir:File;
		public static var folderName:String = "YouTube Downloads";
		public static var exeName:String = "youtube-dl.exe";
		public static var mainDir:File = File.desktopDirectory;
		public static var progressValue:String;
		private static var currentVideoID:String;
		
		public static function initialize():void
		{
			var python:String = folderName + "/" + exeName;
			var pythonFile:File = File.applicationDirectory.resolvePath(python);
			
			workingDir = mainDir.resolvePath(folderName);
			exeFile = workingDir.resolvePath(exeName);
			
			if (!exeFile.exists)
			{
				pythonFile.copyTo(exeFile);
			}
		}
		
		public static function start(youtubeWatchPath:String):void
		{
			var args:Vector.<String> = new Vector.<String>();
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var process:DownloadNativeProcess = new DownloadNativeProcess();
			
			currentVideoID = youtubeWatchPath;
			
			args.push(" " + youtubeWatchPath);
			
			nativeProcessStartupInfo.executable = exeFile;
			nativeProcessStartupInfo.workingDirectory = workingDir;
			nativeProcessStartupInfo.arguments = args;
			
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			process.title = youtubeWatchPath;
			process.start(nativeProcessStartupInfo);
			process.standardInput.writeUTFBytes(args + "\n");
		}
		
		public static function onOutputData(event:ProgressEvent):void
		{
			var outputString:String = event.target.standardOutput.readUTFBytes(event.target.standardOutput.bytesAvailable);
			var destinationInt:int = outputString.search("Destination:");
			
			if (destinationInt > 0)
			{
				var desArray:Array = outputString.split("Destination: ");
				var desArray2:Array = String(desArray[1]).split("\n");
				event.target.destination = String(desArray2[0]);
			}
			
			progressValue = outputString.slice(outputString.search("]")+2, outputString.length);
			
			dispatchEvent(new Event(PROGRESS_EVENT));
		}
		
		public static function onExit(event:NativeProcessExitEvent):void
		{
			event.target.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			event.target.removeEventListener(NativeProcessExitEvent.EXIT, onExit);
			dispatchEvent(new Event(DOWNLOAD_COMPLETE));
		}
		
		public static function addEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean = false, p_priority:int = 0, p_useWeakReference:Boolean = false):void
		{
			if (dispatch == null)
			{
				dispatch = new EventDispatcher();
			}
			
			dispatch.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
		}
		
		public static function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean = false):void
		{
			if (dispatch == null)
			{
				return;
			}
			dispatch.removeEventListener(p_type, p_listener, p_useCapture);
		}
		
		public static function dispatchEvent(event:Event):void
		{
			if (dispatch == null)
			{
				return;
			}
			
			dispatch.dispatchEvent(event);
		}
	
	}
}
