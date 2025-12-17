/*
Cricket with methods written by GeminiCLI AI.

GeminiCricket().buffer;

*/

GeminiCricket : Creature {
	var <chirpTask;

	*addSynthDefs {
		SynthDef(
			\cricket, {
				|out=0, buf, amp=0.1, rate=1, pan=0|
				var sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, doneAction:2);
				Out.ar(out, Pan2.ar(sig, pan) * amp * Env.adsr.kr(2, \gate.kr(1)));
			}
		).add;
	}

	// Overwrite default filename method, to load Cricket.wav
	*fileName { ^"cricket.wav"; }

	// --- State Methods ---

	dawn {
		//	this.stopChirping;
		this add: Synth(\cricket, args: [buf: buffer.bufnum]);
	}

	morning {
		this.stopChirping;
	}

	day {
		this.stopChirping;
	}

	noon {
		this.stopChirping;
	}

	afternoon {
		this.stopChirping;
	}

	evening {
		postln("Cricket: It's evening, starting to chirp.");
		this.startChirping(rateMin: 0.8, rateMax: 1.5, delayMin: 1.0, delayMax: 4.0, amp: 0.03);
	}

	night {
		postln("Cricket: It's night, chirping actively.");
		this.startChirping(rateMin: 1.0, rateMax: 2.0, delayMin: 0.2, delayMax: 1.0, amp: 0.05);
	}


	// --- Helper Methods ---

	release {
		super.release;
		this.stopChirping;
	}
	startChirping {
		|rateMin=1, rateMax=2, delayMin=0.2, delayMax=2, amp=0.05|
		this.stopChirping; // Stop any existing task before starting a new one
		chirpTask = Task({
			loop {
				this.add(
					Synth(
						\cricket,
						[
							\buf,
							buffer,
							\rate,
							rrand(rateMin, rateMax),
							\pan,
							1.0.rand2,
							\amp,
							amp
						]
					)
				);
				rrand(delayMin, delayMax).wait;
			}
		}).play(AppClock, quant:1);
	}

	stopChirping {
		if(chirpTask.notNil) {
			"Cricket: Stopping chirps.".postln;
			chirpTask.stop;
			chirpTask = nil;
			this.release(0.1);
		};
	}
}
