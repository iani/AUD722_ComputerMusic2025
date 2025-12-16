/*
This superclass provides the makeSynth and the loadBuffer method.
All creature classes should be created as subclasses of this class. Like this:

Frog : Creature {
	...
}

THis makes it possible to automatically create one instance of each creature and add it to the Environment. 
*/

Creature {
	classvar <buffer;
	var <synth;

	*new {
		^super.new.loadBuffer;
	}

	buffer { ^buffer } // make classvar available to instance method
	bufferPlay { ^buffer.play }
	//============================================================ 
	//        ------------- Buffer loading --------------
	//============================================================ 
	loadBuffer {
		buffer !? { ^this }; // load once only
		postln("Loading buffer for" + this.class.name);
		postln(this.class.name + "loading buffer from file:" + this.fileName);
		"Buffer path is:".postln;
		this.bufferPath.postln;
		buffer = Buffer.read(Server.default, this.bufferPath);
	}

	bufferPath {
		^this.audioFilesFolder +/+ this.fileName;
	}

	audioFilesFolder { ^"~/CreaturesAudio/".standardizePath }
	fileName {
		// subclasses define here the name of the file containing the buffer to be loaded.
		^this.class.name ++ ".wav";
	}

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