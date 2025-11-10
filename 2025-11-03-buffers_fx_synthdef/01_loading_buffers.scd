/*
In this exercise, we are going to load all audio
files contained in folder "audiofiles" under the
home directory into buffers.
We are going to store each buffer in a separate
environment variable named after the name of the
file from which the buffer was loaded.
*/
//:0. Print the home directory
"~/".standardizePath;
/* Notes:
~ is the location of the home directory in unix
/ indicates that we are looking at a directory.
so:
~/ is the home directory.
the messager "standardizePath" translates a path
such as "~/" into the full path on the computer
where sclang is running.
On my computer,
	"~/".standardizePath;
returns:
	/Users/iani
Note: The root of the directory on a computer is: "/".
	"/".standardizePath;
NOTE: For the following examples, audio files should be mono
	(1 audio channel). NOT Stereo.
*/
//----------------------------------------
//:1 Specify directory audiofiles:
"~/audiofiles/".standardizePath;
//:2 List all wav files under audiofiles;
"~/audiofiles/*.wav".standardizePath.pathMatch;
//:3 Collect the filenames and paths
"~/audiofiles/*.wav".standardizePath.pathMatch collect: { | p |
	[PathName(p).fileNameWithoutExtension, p];
};
//:4 Read the files and store them in environment variables
"~/audiofiles/*.wav".standardizePath.pathMatch do: { | p |
	currentEnvironment.put(
		PathName(p).fileNameWithoutExtension.asSymbol,
		Buffer.read(Server.default, p)
	);
};
//:5. test if buffers are stored in currentEnvironment
currentEnvironment;
//:6. Print all environment variable names of the currentEnvironment
currentEnvironment.keys do: _.postln;
//:7 Play a buffer using the default play method:
~hanbaiki.play;
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
