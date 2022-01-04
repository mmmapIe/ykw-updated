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

class VaultMenu extends MusicBeatState
{
 
    // this shit is ripped from 500 im malding

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


    var inImage:Bool = false;

    var shitassResultsFuckYouMaple:FlxSprite;
    var textBox:FlxSprite;

    override function create()
        {
            inputThisShit = 
            [
                'burning',
                'rubrub',
                'cirtrax',
                'bob',
                'boyfriend',
                'clubbete',
                'potbor',
                'sparky',
                'glubfub',
                'challenge',
                'thisislongonpurposejustforpeopletolookintothesourcecodeandpossiblyinputthisinlol', 
                'hi ash',
                'ohsovanilla',
                'bosip',
                'ron',
                'kazoo',
                'justifited',
                'sticky',
                'cj',
                'tankman',
                'table',
                'zim',
                'viprin',
                'maple',
                'ratemylvl',
                'sneed',
                'attempt 0',
                'doorstuck',
                'forbidden'
            ];
        
            whenRight = 
            [
                'RUBRUBRUBRUBRUBRUBRUB',
                'You mean Avery?',
                'I heard of them, they are cool!',
                'Who is that?',
                'Not her...',
                'He is kinda scary...',
                'They seem weird.',
                'They are annoying!',
                'What challenge?',
                'Did you expect anything from this...?',
                'hi ash'
            ];
        
            randomWhenWrong =
            [
                'No!',
                'That is wrong!',
                'Try again!',
                'WRONG!',
                'Maybe try harder!',
                'False!',
                'Nope!' //this shit doesnt work lol lets not worry about this
            ];

            /*FlxG.sound.playMusic(Paths.music('sounds/RS1', 'shared'), 0);
            FlxG.sound.music.fadeIn(3, 0, 0.6);*/

            var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('vault/BankBG'));
			bg.scrollFactor.x = 0;
			bg.scrollFactor.y = 0;
			bg.setGraphicSize(Std.int(bg.width * 0.55));
			bg.updateHitbox();
			bg.screenCenter();
			bg.antialiasing = true;
			add(bg);

            textBox = new FlxSprite(0,0);
            textBox.frames = Paths.getSparrowAtlas('vault/Text box');
            textBox.animation.addByPrefix('piss', "speech bubble normal", 24, false);
            if(FlxG.save.data.antialiasing)
                {
                    textBox.antialiasing = true;
                }
            textBox.scrollFactor.set();
            textBox.setGraphicSize(Std.int(textBox.width * 0.70));
            textBox.y += 540; //FNF REFERENCE????
            textBox.updateHitbox();
            textBox.animation.play('piss', true);
            add(textBox); // fuck haxe i hate layering

            var shitassResultsFuckYouMaple:FlxSprite = new FlxSprite().loadGraphic(Paths.image('vault/results'));
			shitassResultsFuckYouMaple.scrollFactor.x = 0;
			shitassResultsFuckYouMaple.scrollFactor.y = 0;
			shitassResultsFuckYouMaple.setGraphicSize(Std.int(shitassResultsFuckYouMaple.width * 0.6));
			shitassResultsFuckYouMaple.updateHitbox();
			shitassResultsFuckYouMaple.screenCenter();
            shitassResultsFuckYouMaple.y += 345;
            shitassResultsFuckYouMaple.x += 600;
			shitassResultsFuckYouMaple.antialiasing = true;
			add(shitassResultsFuckYouMaple);

            input = new FlxUIInputText(10, 10, 120, '', 8);
            input.setFormat(Paths.font("vcr.ttf"), 8, FlxColor.WHITE);
            input.setGraphicSize(Std.int(input.height * 1));
            input.alignment = CENTER;
            input.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
            input.screenCenter();
            input.scrollFactor.set();
            input.y += 280;
            input.x -= 250;
            //input.visible = false;
            add(input);
            input.maxLength = 30;
            input.lines = 3;

        }

        

        override function update(elapsed:Float)
            {

            if (FlxG.keys.justPressed.ENTER && inImage)
                {
                    LoadingState.loadAndSwitchState(new VaultMenu());
                }
               
                super.update(elapsed);
                FlxG.mouse.visible = true;
                
            if (FlxG.keys.justPressed.ESCAPE)
                {
                    FlxG.switchState(new MainMenuState());
                }
            if (FlxG.keys.justPressed.ANY)
                    {
                        if (textTyped == true)
                        {
                            remove (inputLol);
                            remove (inputLol2);
                        }
            
                        inputLength = input.text.length;
            
                        if (inputLength >= 81)
                            {
                                inputLol = new Alphabet(3, 50, (input.text.substr(0, 11).trim()), true);
                                inputLol.screenCenter();
                                inputLol.y = (inputLol.y + 300);
                                inputLol.scrollFactor.set();
                                add(inputLol);
                                textTyped = true;
                
                                inputLol2 = new Alphabet(3, 50, (input.text.substr(11).trim()), true);
                                inputLol2.screenCenter();
                                inputLol2.y = (inputLol2.y + 300);
                                inputLol2.scrollFactor.set();
                                add(inputLol2);
                                textTyped = true;
                            }
                            if (inputLength < 81)
                            {
                                inputLol2 = new Alphabet(3, 100, (input.text.toLowerCase()), true);
                                inputLol2.screenCenter();
                                inputLol2.y = (inputLol2.y + 280);
                                inputLol2.x = (inputLol2.x - 250);
                                inputLol2.scrollFactor.set();
                                add(inputLol2);
                                textTyped = true;
                            }
                    }
              if (FlxG.keys.justPressed.ENTER && input.text != '')
                {    
                inputResult = input.text.toLowerCase();
                    switch (inputResult)
                        {
                        case 'jaywalking':
                            new FlxTimer().start(1, function(tmr:FlxTimer)
                            {
                                PlayState.storyPlaylist = ['for-naughty-brats'];
                                PlayState.isStoryMode = false;
                                PlayState.storyDifficulty = 2;
                                PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + '-hard', StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
                                PlayState.storyWeek = 10;
                                PlayState.campaignScore = 0;
                                LoadingState.loadAndSwitchState(new PlayState(), true);
                            });
                        case 'twitter':
                            daDialogueArray("Follow us\non Twitter!");
                            new FlxTimer().start(1.6, function(tmr:FlxTimer)
                                {
                                    CoolUtil.browserLoad("https://twitter.com/fnfykw");      
                                }); //example of link loading, use this if you want to do something cool like promo shit or general trolling
                        case 'maple':
                            daDialogueArray("Like the syrup?");
                        default:
                            daDialogueArray("Enter somethin' correct\nwill ya?!");
                        }
                }       
                    // this shit above is easy to impliment a code and a result
                    // all you need to do is make a new case statement, and then use daDialogueArray(""); as you can see here.
                    // add as many codes as you want, more complicated shit can be found here at: https://github.com/Cirtrax/V.S.-500/blob/main/sourcect/VaultMenu.hx
                    // -avery


            }
            
         //daDialogueArray("");  
        function unlockText():Void
                {
                    screenLock = false;
                }
                function unlockExit():Void
                {
                    exitLock = false;
                }
               
        

        function dialogueArray(text:String = '')
            {
                swagDialogue = new FlxTypeText(240, 540, Std.int(FlxG.width * 0.6), text, 20);
                swagDialogue.font = 'VCR OSD Mono';
                swagDialogue.color = 0xF000000;
                swagDialogue.alignment = CENTER;
                add(swagDialogue);
                swagDialogue.resetText(text);
                swagDialogue.screenCenter();
                swagDialogue.y += 300;
                swagDialogue.x += 450;
                swagDialogue.start(0.03, true, false);
            }


        function daDialogueArray(text:String = "", ?Callback:Void->Void)
            {
                remove(swagDialogue);
                dialogueArray(text);
            }
        /*function getWrongShit(text:Array<String>)
            {
                if (inputResult != daDialogueArray)
                    if (FlxG.random.int(0, 7) == 50)
                    inputResult = randomWhenWrong;
            }*/
      

}