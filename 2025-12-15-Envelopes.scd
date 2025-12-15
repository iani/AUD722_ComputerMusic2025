// Basic envelope definition:
// Env(levels, times, [optional: curves]):
// Example
e = Env([0, 1, 0], [0.5, 0.5]);
// PLot an envelope:
e.plot;
// Test an envelope as sound
e.test;
// Using curves. Simple example:
e = Env([0, 1, 0], [0.5, 0.5], [-1, -1]);
e.plot;
//------------------------------------------------------------ 
// Env shortcuts.
// There are many shortcuts for creating commonly used envelopes.
// See notes in curriculum folder for a complete list of shapes.
// There are 4 categories of envelope constructors
// 1. Plain envelopes
// 2. Envelopes with release node
// 3. Looping envelopes
// 4. Special-Purpose Envelope Constructors
//: Here is an example playing some envelopes made with constructors:
{
	[\perc, \triangle, \sine, \linen, \step] do: { | constructor |
		var env;
		env = Env.perform(constructor);
		env.plot;
		env.test;
		3.wait;
	};
} fork: AppClock;
//:Shortcut for creating envelope generator UGens:
//Instead of writing
EnvGen.kr(env, gate, doneAction: 2)
// One can write
env.kr(2, gate);

//: What happens when an envelope finishes
// The argument doneAction specifies what happens when the envelope
// finishes.
// 
//:Done action 2: Free the synth
{
	var env;
	env = Env([0, 1, 0,] / 10, [1, 1]);
	SinOsc.ar(400) * env.kr(2, 1)
}.play;
//:Done action 0: Do nothing
{
	var env;
	env = Env([0, 1, 0,] / 10, [1, 1]);
	SinOsc.ar(400) * env.kr(0, 1)
}.play;
//: RELEASE NODE
//============================================================
//Using envelopes without release:
//THe duration of the envelope is fixed.
//One cannot change it, once the synth is running.
//The release node fixes a node where the envelope will wait
//until it gets released by a gate value in the EnvGen unit generator.
//: Example: Add a release node to an enevelope.


//:LOOP NODE (example with several steps!)
// 1. Create a synthdef:
SynthDef(\loopEnvTest, { | gate = 0 |
    var env, sig;

    env = Env(
        levels: [0, 1, 0] / 10,
        times:  [1, 1],
        releaseNode: 2,  // exit after index 2
        loopNode: 1      // loop starts at index 1
    );

    sig = SinOsc.ar(400)
        * EnvGen.kr(env, gate, doneAction: 0);

    Out.ar(0, sig ! 2);
}).add;

//:2. Create a synth with the synthdef
~synth = Synth(\loopEnvTest);
//
~synth.set(\gate, 1);

//: stop (exit loop)
~synth.set(\gate, 0);

// restart loop
~synth.set(\gate, 1);

//:Simpler example using tr. Retrigger the envelope:
SynthDef(\trEnv, {
    var env, sig;

    env = EnvGen.kr(
        Env.perc(0.01, 0.3),
        \gate.tr   // ← always retriggers
    );

    sig = SinOsc.ar(400) * env;

    Out.ar(0, sig ! 2);
}).add;
//:
~s = Synth(\trEnv);

~s.set(\gate, 1);
~s.set(\gate, 1);
~s.set(\gate, 1);  // always retriggers
//:The same in a loop:
r = {
	loop { [0.1, 0.2, 0.4].choose.wait; ~s.set(\gate, 1); }
}.fork;
//:
r.stop;
//:
a = { | amp = 0.1 |
	SinOsc.ar(400, 0, amp).dup
}.play;
//:
b = Bus.control;
a.map(\amp, b.index);
b.set(0.1);
//:
c = { Out.kr(b.index, LFNoise2.kr(2).range(0, 0.2)) }.play;
c.free;
c = { Out.kr(b.index, Env.perc.kr(2)) }.play;
c = { Out.kr(b.index, Env.sine.kr(4) * 0.1) }.play;
)

a release: 5;
a release: 0.005