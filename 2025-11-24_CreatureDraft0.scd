/*
This exercise continues the work on buffers.
As in the previous exercise, we load all audio
files contained in folder "audiofiles" under the
home directory into buffers, and store each buffer
in a separate environment variable.

Then we create a synth that plays a buffer.
To this synth we add a SinOsc UGen.
We use an adsr envelope to stop the synth with release.

*/
*/
//----------------------------------------
//:1. Define the directory where the audio files is stored;

// edit the file path to your own location choice:
~myfiles = "~/audiofiles/".standardizePath;
};
//:2. Read the files and store them in environment variables
(~myfiles +/+ "*.wav").standardizePath.pathMatch do: { | p |
	currentEnvironment.put(
		PathName(p).fileNameWithoutExtension.asSymbol,
		Buffer.read(Server.default, p)
	);
};
//:3. test if buffers are stored in currentEnvironment
currentEnvironment;
//:4. Print all environment variable names of the currentEnvironment
currentEnvironment.keys do: _.postln;
//:5 Play a buffer using the default play method:
~hanbaiki.play;

//------------------------------------------------------------
// Older stuff. Needs editing
//:8 Define a function that plays a buffer.
f = { | buf |
	PlayBuf.ar(buf.numChannels, buf);
};
//:9 Test the function
f.play(args: [buf: ~hanbaiki]);
//:10 Add an effect to the buffer sound
g = { | buf |
	var src;
	src = PlayBuf.ar(buf.numChannels, buf, loop: 1);
	Ringz.ar(src, LFNoise1.kr(0.2).range(400, 4000), 0.01, 0.1);
};
//:
g.play(args: [buf: ~hanbaiki]);
//:11 Add a second parameter : LFNoise1 period
g = { | buf, noiseper = 5 |
	var src;
	src = PlayBuf.ar(buf.numChannels, buf, loop: 1);
	Ringz.ar(src, LFNoise1.kr(noiseper.reciprocal).range(400, 4000), 0.01, 0.1);
};
//:Run with a different LFNoise1 period
//: default period
g.play(args: [buf: ~hanbaiki]);
//: custom period
g.play(args: [buf: ~hanbaiki, noiseper: 0.25]);
//:12 add even more parameters: low and high range for Ringz LFNoise
//Note : this is an exercise - please provide the code.
//The names of the new arguments are lo and hi
g = { | buf, noiseper = 5 |
	var src;
	src = PlayBuf.ar(buf.numChannels, buf, loop: 1);
	Ringz.ar(src, LFNoise1.kr(noiseper.reciprocal).range(400, 4000), 0.01, 0.1);
};
//: Try a variant that uses function f:
h = { | buf |
	var src;
	src = f.(buf);
	Ringz.ar(src, LFNoise1.kr(0.2).range(400, 4000), 0.01, 0.1);
};
//:
h.play(args: [buf: ~hanbaiki]);
//:
//: Try a variant that uses function f:
i = { | buf |
	Ringz.ar(f.(buf), LFNoise1.kr(0.2).range(400, 4000), 0.01, 0.1);
};
//:
i.play(args: [buf: ~hanbaiki]);
//:
Buffer.read(Server.default, "~/audiofiles/hanbaiki.wav".standardizePath,
	action: { | buffer | buffer.play; }
);
//:
