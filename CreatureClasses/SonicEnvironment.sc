
SonicEnvironment {
	classvar default;   // the default environment. 
	var <>creatures;
	var <>states;
	var <currentState;
	var <task;
	var <>releaseTime = 10; // default release time for releasing ending states
	var <>defaultDuration = 15;

	// easy testing of instance methods dawn, day, etc.
	*doesNotUnderstand { | selector ... args |
		^this.default.perform(selector, *args);
	}

	*default {
		default ?? { this.makeDefault };
		^default;
	}

	*start { ^this.default.start }
	*stop { ^this.default.stop }

	play { | ... argCreatures |
		if (argCreatures.size > 0) {
			creatures = argCreatures collect: _.asInstance;
		};
		this.start;
	}
	 // made after ServerBoot and loading creature buffers:
	
	*makeDefault { default = this.new } // see Creature:initClass

	*new {^super.new.init;}

	init {
		this.makeStates;
		this.makeCreatures;
	}

	setStates { | argStates |
		if (argStates[1].isKindOf(SimpleNumber)) {
			states = argStates;
		} {
			var times;
			times = defaultDuration ! argStates.size;
			states = [argStates, times].flop.flat;
		};
		states.postln;
	}
	stateNames { ^states.clump(2).flop.first }
	stateTimes { ^states.clump(2).flop.last }
	cycleDuration { ^this.stateTimes.sum }
	scaleDurationTo { | newDuration = 600 | // default: 10 minutes
		var oldDurs, newDurs;
		oldDurs = this.stateTimes;
		newDurs = oldDurs * (newDuration / oldDurs.sum);
		states = [this.stateNames, newDurs].flop.flat;
	}

	makeStates {
		states = [
		dawn: 4,
		morning: 8,
		day: 12,
		noon: 6,
		afternoon: 7,
		evening: 4,
		night: 12];
	}

	makeCreatures {
		creatures = Creature.allSubclasses collect: _.new;
	}
	
	start {
		if (task.isPlaying) { ^"SonicEnvironment is already playing".postln; };
		this.makeTask;
	}

	stop {
		task.stop;
		task = nil;
	}

	makeTask {
		task =  Task({
			loop {
				states keysValuesDo: { | argState, duration |
					this playState: argState;
					duration.wait;
				}
			};
		});
		task.play(AppClock);
	}

	playState { | s |
		postln("SonicEnvironment plays state:" + s);
		currentState = s;
		creatures do: { | c |
			c release: releaseTime;
			if (c respondsTo: s) { c perform: s; }
		};
	}
}