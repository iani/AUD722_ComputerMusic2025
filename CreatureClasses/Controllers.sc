// Controllers for Synth and Task

SynthController : SimpleController {
	var <synth;

	*new { | model, synth |
		^super.new(model) initSynth: synth;
	}

	initSynth { | argSynth |
		synth = argSynth;
		synth.register;
		synth.isPlaying = true;
		this.put(\release, { | model, change, releaseTime = 0.05 |
			if (synth.isPlaying) { synth release: releaseTime; };
			this.remove;
		});
		this.put(\set, { | model, change, args |
			if (synth.isPlaying) { synth.set(*args); };
		});
		this.put(\map, { | model, change, args |
			if (synth.isPlaying) { synth.map(*args); };
		});
	}
}

TaskController : SimpleController {
	var <task;

	*new { | model, task |
		^super.new(model) initTask: task;
	}

	initTask { | argTask |
		task = argTask;
		this.put(\release, { | model, change, releaseTime = 0.05 |
			task.stop;
			this.remove;
		});
	}
}

+ Synth {
	addModel { | model | ^SynthController(model, this); }
	stopProcess { | releaseTime = 0.05 |
		if (this.isPlaying) { this release: releaseTime }
	}
}

+ Task {
	addModel { | model | ^TaskController(model, this); }
	stopProcess { if (this.isPlaying) { this.stop } }
}