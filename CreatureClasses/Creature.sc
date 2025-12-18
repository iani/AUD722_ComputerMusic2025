/*
This superclass provides the makeSynth and the loadBuffer method.
All creature classes should be created as subclasses of this class. Like this:

Frog : Creature {
	...
}

THis makes it possible to automatically create one instance of each creature and add it to the Environment. 
*/

Creature {
	classvar <buffers; // Event with all buffers
	classvar defaults; // default Creature instances for easy testing
	classvar <>defaultBuffer;
	classvar <>defaultFileName = "cricket.wav";
	var <buffer;

	*asInstance { ^this.default }
	asInstance { ^this }
	// easy testing of instance methods dawn, day, etc.
	*doesNotUnderstand { | selector ... args |
		^this.default.perform(selector, *args);
	}

	*default {
		^this.defaults.at(this.name);
	}

	*defaults { // lazily create defaults
		defaults !? { ^defaults };
		defaults = ();
		Creature.allSubclasses do: { | c |
			defaults.put(c.name, c.new)
		};
		^defaults;
	}

	// overwrite Object/Class release to enable custom Creature release:
	*release {
		this.default.release;
	}
	// ------------------	
	*initClass {
		Class.initClassTree(ServerBoot);
		ServerBoot add: {
			{
				this.addSynthDefs;
				this.allSubclasses do: { | c |
					c.postln;
					"adding synthdef for above class".postln;
					c.addSynthDefs
				};
				Server.default.sync;
				this.loadBuffers;
				Server.default.sync;
				SonicEnvironment.makeDefault;
			}.fork(AppClock)
		};
	}

	*loadBuffers {
		buffers = ();
		{
			this.loadDefaultBuffer;
			this.allSubclasses do: _.loadBuffer;
			Server.default.sync;
		}.fork(AppClock);
	}

	*loadDefaultBuffer {
		var defaultPath;
		defaultPath = this.audioFilesFolder +/+ defaultFileName;
		postln("Loading default buffer from:\n" + defaultPath);
		defaultBuffer = Buffer.read(Server.default, defaultPath);
	}

	*new {
		^super.new.init;
	}

	init {
		buffer = buffers[this.class.name];
	}

	*addSynthDefs {
		// subclasses can add their own synthdefs here
	}
	//============================================================ 
	//        ------------- Buffer loading --------------
	//============================================================ 
	*loadBuffer {
		var thePath;
		postln("Loading buffer for" + this.name);
		thePath = this.bufferPath;
		"Buffer path is:".postln;
		thePath.postln;
		if (File exists: thePath) {
			buffers[this.name] = Buffer.read(Server.default, thePath);
		}{
			postln("Audiofile path not found:\n" + thePath);
			"Using default buffer instead".postln;
			buffers[this.name] = defaultBuffer;
		}
	}

	*bufferPath {
		^this.audioFilesFolder +/+ this.fileName;
	}

	*audioFilesFolder { ^"~/CreaturesAudio/".standardizePath }
	*fileName {
		// subclasses define here the name of the file containing the buffer to be loaded.
		^this.name.asString.toLower ++ ".wav";
	}

	bufferPlay { ^this.buffer.play } // utility: play buffer, return synth

	//============================================================ 
	//   ------------- sound process interface -----------
	//============================================================ 

	// set argument/control values of synth
	set { | ... args |
		this.changed(\set, args);
	}

	// substitute all previous processes with this one
	// play this one for dur seconds
	substituteTimed {  | process, dur, releaseTime |
		this.release;
		{ this.addTimed(process, dur, releaseTime); }.defer;
	}
	
	// release previous and add new synth or task
	substitute { | process, releaseTime |
		this release: releaseTime;
		this add: process;
	}

	// release all added processes
	release { | releaseTime = 0.05 | 
		this.changed(\release, releaseTime);
	}

	// start tracking process for set, release.
	add { | process | 
		^process addModel: this;
	}

	addTask { | func |
		this add: Task(func).play;
	}

	addLoop { | func |
		this add: Task({ func.loop }).play;
	}

	// add process, and stop it after dur seconds.
	addTimed { | process, dur = 1, releaseTime = 0.05 |
		var controller;
		controller = this add: process;
		{
			if (process.isPlaying) {
				process stopProcess: releaseTime;
			};
			controller.remove;
		} defer: dur;
	}
	
}