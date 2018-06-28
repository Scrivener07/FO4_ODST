package
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

	public dynamic class TextureLoader extends MovieClip
	{
		private var f4se:*; // I cant get the f4se native object from MCM?

		// Files
		private var Uri:String;
		private var LastFile:String;
		public var ImageMountID:String; // must set from Preview.as

		private static const DDS:String = "dds";

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
			this.visible = false;
			ContentLoader = new Loader();
			Info.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			Info.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			Debug.WriteLine("TextureLoader", "(ctor)", "Constructor Code");
		}


		public function onF4SEObjCreated(codeObject:*):void
		{ // @F4SE
			if(codeObject != null)
			{
				f4se = codeObject;
				Debug.WriteLine("[TextureLoader]", "(onF4SEObjCreated)", "Received F4SE code object.");
				Debug.TraceObject(f4se);
			}
			else
			{
				Debug.WriteLine("[TextureLoader]", "(onF4SEObjCreated)", "The f4se object is null.");
			}
		}


		// Methods
		//---------------------------------------------

		private function Load(filepath:String):void
		{
			Clear();
			var urlRequest:URLRequest;

			// if(GetTextureExists(filepath))
			// {
				F4SE.Extensions.MountImage(f4se, Preview.MenuName, filepath, ImageMountID);
				urlRequest = new URLRequest("img://"+ImageMountID);
				Debug.WriteLine("[TextureLoader]", "(Load)", "'"+urlRequest.url+"' as '"+filepath+"' to "+Preview.MenuName+" with resource ID "+ImageMountID);
			// }
			// else
			// {
			// 	Debug.WriteLine("[TextureLoader]", "(Load)", "'"+filepath+"' does not exist.");
			// 	return;
			// }

			LastFile = filepath;
			ContentLoader.load(urlRequest);
		}


		private function GetTextureExists(filepath:String):Boolean
		{
			var folder:String = Path.GetDirectory("Data\\Textures\\"+filepath);
			return F4SE.Extensions.GetDirectoryListing(f4se, folder, "*.dds", true).length > 0;
		}


		private function OnLoadComplete(e:Event):void
		{
			addChild(Content);
			this.visible = true;
			Debug.WriteLine("[TextureLoader]", "(OnLoadComplete)", e.toString()+"\n"+toString());
		}


		private function OnLoadError(e:IOErrorEvent):void
		{
			Clear();
			Debug.WriteLine("[TextureLoader]", "(OnLoadError)", e.toString()+"\n"+toString());
		}


		// Methods
		//---------------------------------------------

		private function Clear():void
		{
			this.visible = false;
			Unmount(LastFile);
			Unload();
		}


		private function Unmount(filepath:String):Boolean
		{
			if (filepath != null)
			{
				F4SE.Extensions.UnmountImage(f4se, Preview.MenuName, filepath);
				Debug.WriteLine("[TextureLoader]", "(Unmount)", "Unmounted the image '"+filepath+"' from "+Preview.MenuName+" with resource ID "+ImageMountID);
				return true;
			}
			else
			{
				Debug.WriteLine("[TextureLoader]", "(Unmount)", "Cannot unmount file null filepath.");
				return false;
			}
		}


		private function Unload():Boolean
		{
			if (Content)
			{
				this.visible = false;
				removeChild(Content);
				Content.loaderInfo.loader.unload();
				Debug.WriteLine("[TextureLoader]", "(Unload)", "Unloaded content from loader.");
				return true;
			}
			else
			{
				Debug.WriteLine("[TextureLoader]", "(Unload)", "No existing content to unload.");
				return false;
			}
		}


		// Functions
		//---------------------------------------------

		public override function toString():String
		{
			var sResolution = "Resolution: "+stage.width+"x"+stage.height+" ("+this.x+"x"+this.y+")";
			var sURI = "Uri: '"+Uri+"'";
			var sLastFile = "LastFile: '"+LastFile+"'";
			var sUrl = "Url: '"+Url+"'";
			return sResolution+"\n"+sURI+"\n"+sLastFile+"\n"+sUrl;
		}


	}
}
