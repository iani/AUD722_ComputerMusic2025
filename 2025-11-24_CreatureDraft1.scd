// NOTES 24 Nov 2025

/*
How to set the sampling rate of the server
check the post window for current settings and adjust accordingly
*/
Server.default.options.sampleRate = 48000;


// A note on asynchronous execution and completion functions.
// See the SuperCollider help system documentation on asynchronous execution.
// NOTE, here is how to play a buffer when it is loaded
// This is an example. You do not need to use it for your projec
Buffer.read(Server.default, "γράψτε το path και το filename με το extension".standardizePath,
	action: { | buffer | buffer.play; }
);


// Load a buffer and store it in environment variable for later use.
~emro722mono = Buffer.read(Server.default, "γράψτε το path και το filename με το extension".standardizePath);
//Note: you may want to change the name of the variable where you store the buffer.
//Remember, if you change the variable name, you must also change it in all other places in your code.

// Define a function that loops a buffer.
(
f = { | buf | PlayBuf.ar(buf.numChannels, buf, loop: 1).dup(2); };
)


// Define a function that modifies looped buffer with an envelope.
(
f = { | buf |
	var env;
	env = Env.adsr;
	PlayBuf.ar(buf.numChannels,	buf, loop: 1).dup(2) * env.kr;
};
)


// Plot the envelope
Env.adsr.plot;

// store the synth into a variable
(
~myCreature = f.play(args: [buf: ~emro722mono]);
)

// stop the synth
~myCreature.free; // tropos 01, but creates a click

~myCreature.release; // tropos 02, without click

~myCreature.release(3); // tropos 03, with custom release time


// Method 1: Create the buffer and the sinewave as separate synths
// One must then store and stop both synths.
(
~myBuffer = f.play(args: [buf: ~emro722mono]);
~mySine = { SinOsc.ar(178, 0, 0.05).dup(2); }.play;
)
~myBuffer.release(3);
~mySine.release(3);

// Method 2: Play buffer and sine in one function and combine them.
// This simplifies handling and opens up new alternative ways to combine the two sources.
// Define a function that loops a buffer and plays a sinewave.
(
f = { | buf |
	var env, playbuf, playsine;
	env = Env.adsr(2, 5);
	playbuf = PlayBuf.ar(buf.numChannels,
		buf, loop: 1).dup(2);
	playsine = SinOsc.ar(178, 0, 0.05).dup(2);
	(playbuf + playsine) * env.kr;
};
)

// store the synth into a variable
(
~myCreature = f.play(args: [buf: ~emro722mono]);
)
~myCreature.release(3);
