/*
This superclass provides the makeSynth and the loadBuffer method.
All creature classes should be created as subclasses of this class. Like this:

Frog : Creature {
	...
}

THis makes it possible to automatically create one instance of each creature and add it to the Environment. 
*/

Creature {
	var <synth, <buffer;

	*new {
		^super.new.loadBuffer;
	}

	loadBuffer {
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
}