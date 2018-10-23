package ODST
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import AS3.*;
	import F4SE.*;

	// TODO: There is possibly some race condition problems happening with load/unload.
	// It looks like old child movieclips are not being removed in some cases.
	public dynamic class TextureLoader extends MovieClip implements IExtensions
	{
		private var f4se:*;
		public var MenuName:String;
		public var ImageMountID:String;

		// Files
		private var FilePath:String;

		// Stage
		private function get Resolution():Number { return stage.height; }
		private static const DefaultHeight:Number = 720;

		// Loader
		private var ContentLoader:Loader;
		private function get Info() : LoaderInfo { return ContentLoader.contentLoaderInfo; }
		private function get Url() : String { return ContentLoader.contentLoaderInfo.url; }
		private function get Content() : DisplayObject { return ContentLoader.contentLoaderInfo.content; }


		// Events
		//---------------------------------------------

		public function TextureLoader()
		{
			super();
			ContentLoader = new Loader();
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.OnRemovedFromStage);
			Info.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			Info.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			Debug.WriteLine("[TextureLoader]", "(ctor)", "Constructor Code");
		}


		private function OnAddedToStage(e:Event) : void
		{
			Debug.WriteLine("[TextureLoader]", "(OnAddedToStage)", "Unmounting..");
		}


		private function OnRemovedFromStage(e:Event) : void
		{
			Debug.WriteLine("[TextureLoader]", "(OnRemovedFromStage)", "Unmounting..");
			Unload();
		}


		public function onF4SEObjCreated(codeObject:*):void
		{ // @F4SE
			if(codeObject != null)
			{
				f4se = codeObject;
				Debug.WriteLine("[TextureLoader]", "(onF4SEObjCreated)", "Received the F4SE code object.");
			}
			else
			{
				Debug.WriteLine("[TextureLoader]", "(onF4SEObjCreated)", "The f4se object was null.");
			}
		}


		// Methods
		//---------------------------------------------

		public function Load(filepath:String):Boolean
		{
			Unload();
			if(GetTextureExists(filepath))
			{
				try
				{
					F4SE.Extensions.MountImage(f4se, MenuName, filepath, ImageMountID);
					var urlRequest:URLRequest = new URLRequest("img://"+ImageMountID);
					ContentLoader.load(urlRequest);
					FilePath = filepath;
				}
				catch (error:Error)
				{
					Debug.WriteLine("[TextureLoader]", "(Load)", "ERROR:", error.toString());
				}

				Debug.WriteLine("[TextureLoader]", "(Load)", "'"+urlRequest.url+"' as '"+filepath+"' to "+MenuName+" with resource ID "+ImageMountID);
				return true;
			}
			else
			{
				Debug.WriteLine("[TextureLoader]", "(Load)", "'"+filepath+"' does not exist.");
				return false;
			}
		}


		private function GetTextureExists(filepath:String):Boolean
		{
			var folder:String = Path.GetDirectory("Data\\Textures\\"+filepath);
			return F4SE.Extensions.GetDirectoryListing(f4se, folder, "*.dds", true).length > 0;
		}


		private function OnLoadComplete(e:Event):void
		{
			Debug.WriteLine("[TextureLoader]", "(OnLoadComplete)", e.toString()+"\n"+toString());
			addChild(Content);
			Utility.ScaleToHeight(this, 75);
		}


		private function OnLoadError(e:IOErrorEvent):void
		{
			Debug.WriteLine("[TextureLoader]", "(OnLoadError)", e.toString()+"\n"+toString());
			Unload();
		}


		// Methods
		//---------------------------------------------

		private function Unload():void
		{
			if (FilePath != null)
			{
				F4SE.Extensions.UnmountImage(f4se, MenuName, FilePath);
				Debug.WriteLine("[TextureLoader]", "(Unload)", "Unmounted the image '"+FilePath+"' from "+MenuName+" with resource ID "+ImageMountID);
			}

			if (Content)
			{
				removeChild(Content);
				Content.loaderInfo.loader.unload();
				Debug.WriteLine("[TextureLoader]", "(Unload)", "Unloaded content from loader.");
			}
		}


		// Functions
		//---------------------------------------------

		public override function toString():String
		{
			var sResolution = "Resolution: "+stage.width+"x"+stage.height+" ("+this.x+"x"+this.y+")";
			var sLastFile = "FilePath: '"+FilePath+"'";
			var sUrl = "Url: '"+Url+"'";
			return "[TextureLoader]"+ImageMountID+", "+sResolution+", "+sLastFile+", "+sUrl;
		}


	}
}
