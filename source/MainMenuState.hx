package;

import freeplay.FreeplayState;
import flixel.util.FlxTimer;
#if DISCORD_RPC
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import ColorblindFilters;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var osEngineVersion:String = '1.5.1';
	public static var bobSexpandedVersion:String = '1.0.0h'; //sex hehe || 💀💀💀💀
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story mode',
		'freeplay',
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
		'options',
		'fart'
	];

	#if MODS_ALLOWED
	var customOption:String;
	var	customOptionLink:String;
	#end

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var blackShit:FlxSprite;
	var blackShit2:FlxSprite;

	var enteredState:Bool = false;

	override function create()
	{
		TitleState.titleTime = 0;

		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();
		if (ClientPrefs.colorblindMode != null) ColorblindFilters.applyFiltersOnGame(); // applies colorbind filters, ok?

		#if DISCORD_RPC
		// Updating Discord Rich Presence

		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.add(camAchievement, false);
		//camera.zoom = 1.85;

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBG'));
        bg.scrollFactor.set(0, 0);
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);

        if(ClientPrefs.themedmainmenubg == true) {

            var themedBg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
            themedBg.scrollFactor.set(0, 0);
            themedBg.updateHitbox();
            themedBg.screenCenter();
            themedBg.antialiasing = ClientPrefs.globalAntialiasing;
            add(themedBg);

            var hours:Int = Date.now().getHours();
            if(hours > 18) {
                themedBg.color = 0x545f8a; // 0x6939ff
            } else if(hours > 8) {
                themedBg.loadGraphic(Paths.image('menuBG'));
            }
        }

        camFollow = new FlxObject(0, 0, 1, 1);
        camFollowPos = new FlxObject(0, 0, 1, 1);
        add(camFollow);
        add(camFollowPos);

        magenta = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        magenta.scrollFactor.set(0, 0);
        magenta.updateHitbox();
        magenta.screenCenter();
        magenta.visible = false;
        magenta.antialiasing = ClientPrefs.globalAntialiasing;
        magenta.color = 0xFFfd719b;
        add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 0.7;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		//var curoffset:Float = 100;

		for (i in 0...optionShit.length)
		{
			var offset:Float = 200 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite((i * 500) + offset, 0);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " static", 24);
			menuItem.animation.addByPrefix('pressed', optionShit[i] + " press", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(Y);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set(1, 0);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
			//curoffset = curoffset + 20;
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		blackShit = new FlxSprite(0, -200).makeGraphic(FlxG.width, 144, FlxColor.BLACK);
		blackShit.scrollFactor.set();
		add(blackShit);

		blackShit2 = new FlxSprite(0, FlxG.height + 200).makeGraphic(FlxG.width, 144, FlxColor.BLACK);
		blackShit2.scrollFactor.set();
		add(blackShit2);

		FlxTween.tween(blackShit, {y: 0}, 1, {ease: FlxEase.bounceIn});
		FlxTween.tween(blackShit2, {y: FlxG.height - 144}, 1, {ease: FlxEase.bounceIn});

		var versionShit:FlxText = new FlxText(FlxG.width * 0.7, FlxG.height - 64, 0, "Bloberrrrrrrs Expanded v" + bobSexpandedVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(FlxG.width * 0.7, FlxG.height - 44, 0, "OS Engine v" + osEngineVersion + " - Modded Psych Engine", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(FlxG.width * 0.7, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}


	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (blackShit.y == 0 && blackShit2.y == FlxG.height - 144)
			enteredState = true;

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_LEFT_P && enteredState == true)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_RIGHT_P && enteredState == true)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK && enteredState == true)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT && enteredState == true)
			{
				menuItems.forEach(function(spr:FlxSprite)
				{
					if (spr.ID == curSelected)
						spr.animation.play('pressed');
				});

				if (optionShit[curSelected] == 'fart') {
					FlxG.sound.music.volume = 0.1;
					FlxG.sound.play(Paths.sound('fartsoundlol'), 1, false, null, false, function() {
						FlxG.sound.music.volume = 1;
					});

					new FlxTimer().start(0.1, function(tmr:FlxTimer) {
						menuItems.forEach(function(spr:FlxSprite)
						{
							if (spr.ID == curSelected)
								spr.animation.play('idle');
						});
					});
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							spr.kill();
						}
						else
						{
							FlxTween.tween(FlxG.camera, {zoom : 1.5}, 0.5, {ease: FlxEase.sineIn});
							FlxTween.tween(blackShit, {y: -200}, 1, {ease: FlxEase.bounceOut});
							FlxTween.tween(blackShit2, {y: FlxG.height + 200}, 1, {ease: FlxEase.bounceOut, onComplete: function(twn:FlxTween) {
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new freeplay.SelectinState());
									#if ACHIEVEMENTS_ALLOWED
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									#end
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							}});
						}
					});
				}
			}
			else if (FlxG.keys.anyJustPressed(debugKeys) && enteredState == true)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(Y);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.scale.set(1, 1);

			if (spr.ID == curSelected)
			{
				spr.scale.set(1.4, 1.4);
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				//spr.centerOffsets();
			}
		});
	}
}
