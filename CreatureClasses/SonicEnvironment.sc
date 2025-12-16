
SonicEnvironment {
	classvar default;   // the default environment. 
	var <creatures;
	var <states;
	var <currentState;
	var <task;

	*initClass {
		Class.initClassTree(ServerBoot);
		ServerBoot add: { this.default }; // make default, load buffers
	}

	*start { ^this.default.start }
	*stop { ^this.default.stop }
	*default { ^default ?? { default = this.new };}

	*new {^super.new.init;}

	init {
		this.makeStates;
		this.makeCreatures;
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
	
	test {
		thisMethod.postln;
		thisMethod.name.postln;
		thisMethod.name.class.postln;
	}

	start {
		if (task.isPlaying) { ^"SonicEnvironment is already playing".postln; };
		this.makeTask;
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
			if (c respondsTo: s) { c perform: s; }
		};
	}
}