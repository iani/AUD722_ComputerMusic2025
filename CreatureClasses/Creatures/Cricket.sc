// IZ Creature.
/*
States to cover:
	dawn
	morning
	day
	noon
	afternoon
	evening
	night
*/

Cricket : Creature {

	dawn {
		this add: Task({
			loop {
				(1..500).normalize(0.01, 0.3).reverse do: { | r |
					this.addTimed(
						Synth(\panPlayBuf, [
							buf: buffer.bufnum,
							rate: r,
							pan: 1.0.rand2,
							amp: 0.001.exprand(0.05),
							startPos: 0.rrand(buffer.dur - 0.1)
						]),
						0.3.exprand(5)
					);
					[0.25, 0.5, 0.1].choose.wait;
				}
			};
		}).play;
		this add: Task({
			loop {
				(1..100).normalize(0.01, 0.3) do: { | r |
					this.addTimed(
						Synth(\panPlayBuf, [
							buf: buffer.bufnum,
							rate: r,
							pan: 1.0.rand2,
							amp: 0.001.exprand(0.05),
							startPos: 0.rrand(buffer.dur - 0.1)
						]),
						0.3.exprand(5)
					);
					[0.25, 0.5, 0.1].choose.wait;
				}
			};
		}).play	
	}

	morning {
		this add: this.playBufLoop(0.2, 0.5);	
	}

	day {
		this add: Task({
			loop {
				this.addTimed(
					Synth(\panPlayBuf, [
						buf: buffer.bufnum,
						rate: 0.1.rrand(3),
						pan: 1.0.rand2,
						amp: 0.01.exprand(0.5),
						startPos: 0.rrand(buffer.dur - 0.1)
					]),
					0.3
				);
				0.01.exprand(0.3).wait;
			};
		}).play;
	}

	noon {
		this add: Task({
			loop {
				this.addTimed(
					Synth(\panPlayBuf, [
						buf: buffer.bufnum,
						rate: 0.1.exprand(0.3),
						pan: 1.0.rand2,
						amp: 0.01.exprand(0.5),
						startPos: 0.rrand(buffer.dur - 0.1)
					]),
					0.3.exprand(5)
				);
				1.exprand(2.3).wait;
			};
		}).play;
	}

	afternoon {
		this add: Task({
			loop {
				(1..100).normalize(0.01, 0.3).reverse do: { | r |
					this.addTimed(
						Synth(\panPlayBuf, [
							buf: buffer.bufnum,
							rate: r,
							pan: 1.0.rand2,
							amp: 0.001.exprand(0.05),
							startPos: 0.rrand(buffer.dur - 0.1)
						]),
						0.3.exprand(5)
					);
					[0.25, 0.5, 0.1].choose.wait;
				}
			};
		}).play;
	
	}

	evening {
		this add: this.playBufLoop;
	}

	night {
		this add: this.playBufLoop(2, 2.5);	
	}

	playBufLoop { |rateMin=1, rateMax=2, delayMin=0.2, delayMax=2, amp=0.05|
		^Task({
			loop {
				this add: Synth(\panPlayBuf, [
					buf: buffer.bufnum,
					rate: rrand(rateMin, rateMax),
					pan: 1.0.rand2,
					amp: amp
				]);
				rrand(delayMin, delayMax).wait;
			}
		}).play;
	}

	playBufLoopTimed { | durMin=1.0, durMax=20, releaseMin=0.01, releaseMax=10,
		rateMin=1, rateMax=2, delayMin=0.2, delayMax=2, amp=0.05|
		^Task({
			loop {
				this.addTimed(
					Synth(\panPlayBuf, [
						buf: buffer.bufnum,
						rate: rrand(rateMin, rateMax),
						pan: 1.0.rand2,
						amp: amp
					]),
					rrand(durMin, durMax),
					exprand(releaseMin, releaseMax)
				);
				rrand(delayMin, delayMax).wait;
			}
		}).play;
	}

}