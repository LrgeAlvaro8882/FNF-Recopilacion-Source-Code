package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class MenuCharacter extends FlxSprite
{
	public var character:String;

	public function new(x:Float, character:String = 'bf')
	{
		super(x);

		changeCharacter(character);
	}

	public function changeCharacter(?character:String = 'bf') {
		if(character == this.character) return;
	
		this.character = character;
		antialiasing = ClientPrefs.globalAntialiasing;

		switch(character) {
			case 'bf':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_BF');
				animation.addByPrefix('idle', "M BF Idle", 24);
				animation.addByPrefix('confirm', 'M bf HEY', 24, false);

			case 'gf':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_GF');
				animation.addByPrefix('idle', "M GF Idle", 24);

			case 'dad':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Dad');
				animation.addByPrefix('idle', "M Dad Idle", 24);

			case 'spooky':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Spooky_Kids');
				animation.addByPrefix('idle', "M Spooky Kids Idle", 24);

			case 'pico':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Pico');
				animation.addByPrefix('idle', "M Pico Idle", 24);

			case 'mom':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Mom');
				animation.addByPrefix('idle', "M Mom Idle", 24);

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Parents');
				animation.addByPrefix('idle', "M Parents Idle", 24);

			case 'senpai':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Senpai');
				animation.addByPrefix('idle', "M Senpai Idle", 24);

			case 'nothing':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Nothing');
				animation.addByPrefix('idle', "M Nothing", 24);

			case 'tankman':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Tankman');
				animation.addByPrefix('idle', "Tankman Menu BLACK", 24);
				
			case 'matt':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Matt');
				animation.addByPrefix('idle', "M Matt Idle", 24);

			case 'garcello':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Garcello');
				animation.addByPrefix('idle', "M Garcello Idle", 24);

			case 'huggymenu':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Huggy');
				animation.addByPrefix('idle', "HUGGY MENU", 24);

			case 'hecker':
				frames = Paths.getSparrowAtlas('menucharacters/Menu_Hecker');
				animation.addByPrefix('idle', "Hecker idle dance", 24);
		}
		animation.play('idle');
		updateHitbox();

		switch(character) {
			case 'bf':
				offset.set(15, -40);

			case 'gf':
				offset.set(0, -25);

			case 'spooky':
				offset.set(0, -80);

			case 'pico':
				offset.set(0, -120);

			case 'mom':
				offset.set(0, 10);

			case 'parents-christmas':
				offset.set(110, 10);

			case 'senpai':
				offset.set(60, -70);

			case 'tankman':
				offset.set(50, -30);

			case 'matt':
				offset.set(140, 30);
				
			case 'garcello':
				offset.set(120, 34);

			case 'huggymenu':
				offset.set(100, 220);

			case 'hecker':
				offset.set(150, 60);
		}

		switch(character)
		{
			case 'bf':
				scale.set(1, 1);
			case 'gf':
				scale.set(1, 1);
			case 'dad':
				scale.set(1, 1);
			case 'spooky':
				scale.set(1, 1);
			case 'pico':
				scale.set(1, 1);
			case 'mom':
				scale.set(1, 1);
			case 'parents-christmas':
				scale.set(1, 1);
			case 'senpai':
				scale.set(1, 1);
			case 'tankman':
				scale.set(1, 1);
			case 'matt':
				scale.set(0.6, 0.6);
			case 'garcello':
				scale.set(0.57, 0.57);
			case 'huggymenu':
				scale.set(0.5, 0.5);
			case 'hecker':
				scale.set(0.6, 0.6);
		}
	}
}
