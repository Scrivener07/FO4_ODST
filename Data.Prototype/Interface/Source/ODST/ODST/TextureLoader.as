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

	// This file is a duplication of `ODST:Emblem:TextureLoader`

	public dynamic class TextureLoader extends MovieClip implements IExtensions
	{
		public var MenuName:String;
		public var ImageMountID:String;
		private var f4se:*;

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
			this.visible = false;
			ContentLoader = new Loader();
			Info.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			Info.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			Debug.WriteLine("[TextureLoader]", "(ctor)", "Constructor Code");
		}


		public function onF4SEObjCreated(codeObject:*):void
		{ // @F4SE
			if(codeObject != null)
			{
				f4se = codeObject;
				Debug.WriteLine(toString(), "(onF4SEObjCreated)", "Received F4SE code object.");
			}
			else
			{
				Debug.WriteLine(toString(), "(onF4SEObjCreated)", "The f4se object is null.");
			}
		}


		// Methods
		//---------------------------------------------

		private function Load(filepath:String):Boolean
		{
			Unload();
			if(GetTextureExists(filepath))
			{
				F4SE.Extensions.MountImage(f4se, MenuName, filepath, ImageMountID);
				var urlRequest:URLRequest = new URLRequest("img://"+ImageMountID);
				ContentLoader.load(urlRequest);
				FilePath = filepath;
				Debug.WriteLine(toString(), "(Load)", "'"+urlRequest.url+"' as '"+filepath+"' to "+MenuName+" with resource ID "+ImageMountID);
				return true;
			}
			else
			{
				Debug.WriteLine(toString(), "(Load)", "'"+filepath+"' does not exist.");
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
			Debug.WriteLine(toString(), "(OnLoadComplete)", e.toString()+"\n"+toString());
			addChild(Content);
			Utility.ScaleToHeight(this, 75);
			this.visible = true;
		}


		private function OnLoadError(e:IOErrorEvent):void
		{
			Debug.WriteLine(toString(), "(OnLoadError)", e.toString()+"\n"+toString());
			Unload();
		}


		// Methods
		//---------------------------------------------

		private function Unload():void
		{
			this.visible = false;

			if (FilePath != null)
			{
				F4SE.Extensions.UnmountImage(f4se, MenuName, FilePath);
				Debug.WriteLine(toString(), "(Unload)", "Unmounted the image '"+FilePath+"' from "+MenuName+" with resource ID "+ImageMountID);
			}

			if (Content)
			{
				this.visible = false;
				removeChild(Content);
				Content.loaderInfo.loader.unload();
				Debug.WriteLine(toString(), "(Unload)", "Unloaded content from loader.");
			}
		}


		// Functions
		//---------------------------------------------

		public override function toString():String
		{
			var sResolution = "Resolution: "+stage.width+"x"+stage.height+" ("+this.x+"x"+this.y+")";
			var sLastFile = "FilePath: '"+FilePath+"'";
			var sUrl = "Url: '"+Url+"'";
			return "[TextureLoader]"+ImageMountID+" "+sResolution+"\n"+sLastFile+"\n"+sUrl;
		}


	}
}
