// NOTES 24 Nov 2025

/*
How to set the sampling rate of the server
check the post window for current settings and adjust accordingly
*/
Server.default.options.sampleRate = 48000;


// play buffer only when it is ready
Buffer.read(Server.default, "γράψτε το path και το filename με το extension".standardizePath,
	action: { | buffer | buffer.play; }
);


// Define a function that loops a buffer.
(
f = { | buf |
	PlayBuf.ar(buf.numChannels,
		buf, loop: 1).dup(2);
};
)


// Define a function that modifies looped buffer with an envelope.
(
f = { | buf |
	var env;
	env = Env.adsr;
	PlayBuf.ar(buf.numChannels,
		buf, loop: 1).dup(2)
	* env.kr;
};
)


// Plot the envelope
Env.adsr.plot;

// store the synth into a variable
/* ΠΡΟΣΟΧΗ !!!
ΣΤΗ ΘΕΣΗ ΤΗΣ ΜΕΤΑΒΛΗΤΗΣ ~emro722mono ΘΑ ΒΑΛΕΤΕ ΤΗ ΜΕΤΑΒΛΗΤΗ ΠΟΥ ΕΧΕΤΕ ΗΔΗ ΦΤΙΑΞΕΙ ΒΑΣΕΙ ΤΩΝ ΣΗΜΕΙΩΣΕΩΝ ΤΩΝ ΠΡΟΗΓΟΥΜΕΝΩΝ ΣΥΝΑΝΤΗΣΕΩΝ !
YOU HAVE TO REPLACE THE VARIABLE ~emro722mono WITH THE VARIABLE YOU YOURSELF HAVE CREATED BASED ON THE NOTES OF OUR PREVIOYS LESSONS !
*/

(
~myCreature = f.play(args: [buf: ~emro722mono]);
)

// stop the synth
~myCreature.free; // tropos 01, but creates a click

~myCreature.release; // tropos 02, without click

~myCreature.release(3);


// stop the buffer and the sinewave independently
(
~myBuffer = f.play(args: [buf: ~emro722mono]);
~mySine = { SinOsc.ar(178, 0, 0.05).dup(2); }.play;
)
~myBuffer.release(3);
~mySine.release(3);

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
