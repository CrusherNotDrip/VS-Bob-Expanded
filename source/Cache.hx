package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import lime.app.Application;
#if windows
import Discord.DiscordClient;
#end
import openfl.display.BitmapData;
import openfl.utils.Assets;
import haxe.Exception;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class Cache extends MusicBeatState
{
	public static var bitmapData:Map<String,FlxGraphic>;
	public static var bitmapData2:Map<String,FlxGraphic>;

	var images = [];
	var music = [];

	var shitz:FlxText;

	override function create()
	{
		var maxAmountImages:Int = Std.parseInt(Assets.getText("assets/images/loadingScreens/MaxLoadingScreens.txt"));
		FlxG.mouse.visible = false;

		FlxG.worldBounds.set(0,0);

		bitmapData = new Map<String,FlxGraphic>();
		bitmapData2 = new Map<String,FlxGraphic>();

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('loadingScreens/loadingscreen-' + FlxG.random.int(1, maxAmountImages)));
		menuBG.screenCenter();
		add(menuBG);

		shitz = new FlxText(12, 630, 300, "Loading... the FARTTTT", 12);
		shitz.scrollFactor.set();
		shitz.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(shitz);

		#if sys
		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
		{
			if (!i.endsWith(".png"))
				continue;
			images.push(i);
		}

		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
		{
			music.push(i);
		}

		sys.thread.Thread.create(() -> {
			cache();
		});
		#end

		super.create();
	}

	override function update(elapsed) 
	{
		super.update(elapsed);
	}

	public static var updateVersion:String = "";
	function cache()
	{
		#if !linux
		for (i in images)
		{
			var replaced = i.replace(".png","");
			var data:BitmapData = BitmapData.fromFile("assets/shared/images/characters/" + i);
			var graph = FlxGraphic.fromBitmapData(data);
			graph.persist = true;
			graph.destroyOnNoUse = false;
			bitmapData.set(replaced,graph);
			trace(i);
		}

		for (i in music)
		{
			trace(i);
		}
		#end

		#if CHECK_FOR_UPDATES
		if(ClientPrefs.checkForUpdates) {
			trace('checking for update');
			var http = new haxe.Http("https://raw.githubusercontent.com/CrusherNotDrip/VS-Bob-Expanded/main/gitVersion.txt");

			http.onData = function (data:String)
			{
				updateVersion = data.split('\n')[0].trim();
				var curVersion:String = MainMenuState.bobSexpandedVersion.trim();
				trace('version online: ' + updateVersion + ', your version: ' + curVersion);
				if(updateVersion != curVersion) {
					trace('versions arent matching!');
					FlxG.switchState(new OutdatedState());
				}
				else if(updateVersion == curVersion)
					FlxG.switchState(new TitleState());
			}

			http.onError = function (error) {
				trace('error: $error');
				FlxG.switchState(new TitleState());
			}

			http.request();
		}
		#end
	}

}