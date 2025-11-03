// Playing with buffer playback rate modulation
//----------------------------------------
// Introduction - prepare the buffers
//: A PLAYBACK RATE MANIPULATION
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
//:5 Create a function that changes the playback rate
f = { | buf, rate = 1 |
	PlayBuf.ar(buf.numChannels, buf, rate, loop: 1);
}
//:6. Playback a buffer with default rate.
// store the synth in y for future manipulation
y = f.play(args: [buf: ~hanbaiki])
//:7 Change the playback rate
y.set(\rate, 0.4);
//:
y.set(\rate, 0.2);
//:8 Continuously change the playback rate by mapping to a control bus
b = Bus.control; // create a control bus for mapping
// start a synth that writes into the control bus
z = { Out.kr(b.index, LFNoise1.kr(1).range(0.1, 2)) }.play;
// Map the rate input of synth y to the control bus;
y.map(\rate, b.index);
// Replace the control synth by a different synth
z.free;
z = { Out.kr(b.index, LFNoise0.kr(10).range(0.1, 2)) }.play;