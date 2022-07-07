package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.math.FlxPoint;
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
import lime.app.Application;
import Achievements;
import flixel.input.mouse.FlxMouseEventManager;
import editors.MasterEditorMenu;

import PlayState;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.4.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	var optionShit:Array<String> = ['story_mode', 'freeplay', #if ACHIEVEMENTS_ALLOWED 'awards', #end 'credits', #if !switch 'donate', #end 'options'];

	var menuguys:FlxSprite;
	var magenta:FlxSprite;


	function onMouseUp(object:FlxObject){

	}

	function onMouseOver(object:FlxObject){
		if(!selectedSomethin){
			for(idx in 0...menuItems.members.length){
				var obj = menuItems.members[idx];
				if(obj==object){
					if(idx!=curSelected){
						FlxG.sound.play(Paths.sound('scrollMenu'));
					};
				}
			}
		}
	}

	function onMouseOut(object:FlxObject){

	}

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end



		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;
		FlxG.mouse.visible = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuYOKAI'));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.setGraphicSize(Std.int(bg.width * 0.90));
		bg.setGraphicSize(Std.int(bg.height * 1));
		add(bg);

		var magenta:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuYOKAI'));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		bg.setGraphicSize(Std.int(bg.width * 0.90));
		bg.setGraphicSize(Std.int(bg.height * 1));
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		add(magenta);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
			{
				var offset:Float = 200 - (Math.max(optionShit.length, 8) - 4) * 80;
				var menuItem:FlxSprite = new FlxSprite(0, (i * 89)  + offset);
				menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
				menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
				menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
				menuItem.animation.play('idle');
				menuItem.ID = i;
				menuItem.screenCenter(X);
				menuItems.add(menuItem);
				var scr:Float = (optionShit.length - 4) * 0.135;
				if(optionShit.length < 6) scr = 0;
				menuItem.scrollFactor.set(0, scr);
				menuItem.setGraphicSize(Std.int(menuItem.width * 0.60));
				menuItem.antialiasing = ClientPrefs.globalAntialiasing;
				//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
				menuItem.updateHitbox();
			}

		menuguys = new FlxSprite();
		menuguys.frames = Paths.getSparrowAtlas('menuguys');
		menuguys.animation.addByPrefix('awards', "bf", 24);
		menuguys.animation.addByPrefix('freeplay', "bf", 24);
		menuguys.animation.addByPrefix('credits', "bf", 24);
		menuguys.animation.addByPrefix('story_mode', "bf", 24);
		menuguys.animation.addByPrefix('options', "options", 24);
		menuguys.scrollFactor.set();
		menuguys.setGraphicSize(Std.int(menuguys.width * 1.23));
		menuguys.setGraphicSize(Std.int(menuguys.height * 1.23));
		menuguys.antialiasing = true;
		FlxTween.tween(menuguys, {y: menuguys.y + 10}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});
		FlxTween.tween(menuguys, {x: menuguys.x + 10}, 2, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.15});


		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (!Achievements.achievementsUnlocked[achievementID][1] && leDate.getDay() == 5 && leDate.getHours() >= 18) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
			Achievements.achievementsUnlocked[achievementID][1] = true;
			giveAchievement();
			ClientPrefs.saveSettings();
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	var achievementID:Int = 0;
	function giveAchievement() {
		add(new AchievementObject(achievementID, camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement ' + achievementID);
	}
	#end

	public var offsets:Map<String, FlxPoint> = [
		'story_mode' => new FlxPoint(5, 300),
		'options' => new FlxPoint(0, 0),
	  ];
	  public function playMenuGuysAnim(?anim:String = 'story_mode') {
		if (menuguys == null) return;

		var offset = offsets.get('story_mode');
		if (offsets.exists(anim)) var offset = offsets.get(anim);

		menuguys.x = offset.x;
		menuguys.y = offset.y;

		menuguys.animation.play(anim);
	  }

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 5.6, 0, 1);

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				/*if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else*/
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'donate':
										MusicBeatState.switchState(new VaultMenu());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										MusicBeatState.switchState(new OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.justPressed.SEVEN)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}

			else if (FlxG.keys.justPressed.TWO)
				{
					PlayState.storyPlaylist = ['for-naughty-brats'];
					PlayState.isStoryMode = false;
					PlayState.storyDifficulty = 2;
					PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + '-hard', StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
					PlayState.storyWeek = 10;
					PlayState.campaignScore = 0;
					LoadingState.loadAndSwitchState(new PlayState(), true);
				}
			#end
		}

		menuItems.forEach(function(spr:FlxSprite){
			spr.scale.set(0.6, 0.6);

			switch(spr.ID)
			{
			case 0: //story
			spr.x = 25;
			spr.y = 300;

			case 1: //freeplay
			spr.x = 500;
			spr.y = 300;

			case 2: //awards
			spr.x = 895;
			spr.y = 300;

			case 3: //credits
			spr.x = 25;
			spr.y = 620;

			case 4: //bank
			spr.x = 510;
			spr.y = 610;

			case 5: //options
			spr.x = 895;
			spr.y = 620;
		}
		});

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuguys.animation.play(optionShit[curSelected]);
		FlxG.camera.zoom = 1;
		FlxTween.tween(FlxG.camera, {zoom: 1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.offset.y = 0;
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				spr.offset.x = 0.15 * (spr.frameWidth / 2 + 180);
				spr.offset.y = 0.15 * spr.frameHeight;
				FlxG.log.add(spr.frameWidth);
			}
		});
	}
}