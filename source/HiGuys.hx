package;

import lime.system.System;
import openfl.Lib;
import lime.app.Application;
import flixel.addons.ui.FlxUIInputText;
import flixel.input.keyboard.FlxKey;
import sys.FileSystem;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.util.FlxGradient;
import flixel.addons.transition.FlxTransitionableState;
#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.addons.text.FlxTypeText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.addons.display.FlxBackdrop;

using StringTools;

class HiGuys extends MusicBeatState
{

    var input:FlxUIInputText;
    var textTyped:Bool = false;
    var inputLength:Int = 0;
    var inputLol:Alphabet;
    var inputLol2:Alphabet;
    var screenLock:Bool = false;
    var exitLock:Bool = false;
    var swagDialogue:FlxTypeText;
    var inputThisShit:Array<String>;
    var whenRight:Array<String>;
    var randomWhenWrong:Array<String>;
    public static var inputResult:String = "";

    var logoBl:FlxSprite;
    var higuys:FlxSprite;
    var bg:FlxSprite;

override function create()
    {
    //blank cuz flixel lokl
    inputThisShit = 
    [
        
        ];
            FlxG.sound.playMusic(Paths.music('Bank'));

            var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('secret/scarybg'));
			bg.scrollFactor.x = 0;
			bg.scrollFactor.y = 0;
			bg.setGraphicSize(Std.int(bg.width * 0.55));
			bg.updateHitbox();
			bg.screenCenter();
			bg.antialiasing = true;
			add(bg);

            logoBl = new FlxSprite(0, 0);
            logoBl.frames = Paths.getSparrowAtlas('secret/hazy');
            logoBl.antialiasing = ClientPrefs.globalAntialiasing;
            logoBl.animation.addByPrefix('idle', 'explung', 24);
            logoBl.animation.play('idle');
            logoBl.updateHitbox();
            logoBl.screenCenter();
            // logoBl.color = FlxColor.BLACK;
        
            higuys = new FlxSprite(0, 0);
            higuys.frames = Paths.getSparrowAtlas('secret/hi guys');
            higuys.antialiasing = ClientPrefs.globalAntialiasing;
            higuys.updateHitbox();
            higuys.screenCenter();

}
}