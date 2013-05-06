package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.mcv.utils.DownloadMovies;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class Main extends Sprite 
	{
		private var progressText:TextField;
		
		public function Main():void 
		{			
			progressText = new TextField();
			progressText.width = stage.stageWidth;
			progressText.textColor = 0xffffff;
			addChild(progressText);
			
			DownloadMovies.initialize();
			DownloadMovies.addEventListener(DownloadMovies.PROGRESS_EVENT, downloadProgressHandler);
			DownloadMovies.addEventListener(DownloadMovies.DOWNLOAD_COMPLETE, downloadCompleteHandler);
			DownloadMovies.start("Zr4JwPb99qU");
		}
		
		private function downloadProgressHandler(event:Event):void
		{
			progressText.text = DownloadMovies.progressValue;
		}
		
		private function downloadCompleteHandler(event:Event):void
		{
			progressText.text += "\ndownload is complete";
		}
		
	}
}