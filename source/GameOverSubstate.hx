package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxPoint;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float, camX:Float, camY:Float)
	{
		var daBf:String = '';
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'bfmii':
				daBf = 'bfmii';
			case 'alvaro' | 'alvaro-reanimated' | 'alvaro-car-reanimated':
				daBf = 'alvaro';
			case 'bb':
				daBf = 'bbdead';
			case 'disc-bf':
				daBf = 'disc-bf-ded';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		camFollow = new FlxPoint(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y);

		if(PlayState.SONG.song.toLowerCase() == 'hecker')
		{
			FlxG.sound.play(Paths.sound('ded'));
		}
		else
		{
			FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		}
		Conductor.changeBPM(100);
		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');

		var exclude:Array<Int> = [];

		camFollowPos = new FlxObject(0, 0, 1, 1);
		camFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2));
		add(camFollowPos);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if(updateCamera) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 0.6, 0, 1);
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		}

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;

			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new StoryMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());


			if(ClientPrefs.newMusicMenu)
			{
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
			else if(!ClientPrefs.newMusicMenu)
			{
				FlxG.sound.playMusic(Paths.music('freakyMenu-alt'));
			}
		}

		if (bf.animation.curAnim.name == 'firstDeath')
		{
			if(bf.animation.curAnim.curFrame == 12)
			{
				FlxG.camera.follow(camFollowPos, LOCKON, 1);
				updateCamera = true;
			}

			if (bf.animation.curAnim.finished)
			{
				if(ClientPrefs.tankmanDeathLines)
				{
					tankmanBruh();
				}
				coolStartDeath();
				bf.startedDeath = true;
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function tankmanBruh(?volume:Float = 7):Void
	{
		if (PlayState.SONG.player2 == 'tankman')
		{
			FlxG.sound.play(Paths.sound('jeffGameover-' + FlxG.random.int(1, 25)), volume);
		}
	}

	function coolStartDeath(?volume:Float = 1):Void
	{
		if(PlayState.SONG.song.toLowerCase() == 'hecker')
		{
			FlxG.sound.playMusic(Paths.music('silence'), volume);
		}
		else
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix), volume);
		}
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			if(PlayState.SONG.song.toLowerCase() == 'hecker')
			{
				FlxG.sound.play(Paths.music('retrydc'));
			}
			else
			{
				FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			}
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
