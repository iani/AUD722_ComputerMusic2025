/*

Minimal example of a Creature class.

States to be implemented are:

dawn
morning
day
noon
afternoon
evening
night

*/

ExampleCreature : Creature { // Creatures must be subclasses of Creature

	// define one method for each state
	// any states that do not have a method will remain silent (play nothing).
	dawn {
		this add: { GrayNoise.ar(LFNoise1.kr(0.1) * 0.05).dup }.play;
	}

	morning {
		this addLoop: {
			this add: {
				Ringz.ar(
					WhiteNoise.ar(LFNoise1.kr(0.1) * 0.1)
					* Env.perc(
						0.01.exprand(1), 0.1.exprand(5),
						0.01.rrand(0.1)
					).kr(2),
					{ 100.rrand(4000) } ! 2,
					0.4.rrand(2)
				)
			}.play;
			0.1.exprand(5).wait;
		}
	}

	day {
		this add: { SinOsc.ar(LFNoise1.kr(2).range(100, 1000), 0, 0.1).dup }.play;
	}
	noon {
		this add: {
			SinOsc.ar(LFNoise1.kr(2).range(100, 1000), 0, 0.1)
			* Decay.kr(Dust.kr(1).dup)
		}.play
	}
	afternoon {
		this add: {
			LFNoise0.ar(LFNoise1.kr(2).range(100, 1000), 0.1)
			* Decay2.kr(Dust.kr(1).dup, 0.5, 5)
		}.play
	}
	evening {
		this add: {
			LFNoise1.ar(LFNoise0.kr(2).range(500, 6000), 0.1)
			* Decay2.kr(Dust.kr(1).dup, 0.5, 5)
		}.play
	}
	night {
		this addLoop: {
			{
				(degree: -30.rrand(10), dur: 0.1.rrand(3)).play;
				0.1.wait;
			} ! (1..8).choose;
			[1, 2, 4, 8].choose.wait;
		}
	}

}