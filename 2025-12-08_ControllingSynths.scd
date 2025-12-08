// 8 12 2025 09:14
// How to control synths.
// 1. The lifecycle of a synth.
/*
Synths are the only objects that generate sounds in SuperCollider.
The lifecycle of a synth is like this:
1. 	Create a synth with:
	~mysynth = {  }.play (Function:play)
	or
	~mysynth = Synth.new, or the shortcut: Synth()
2. 	If the synth is programmed to keep playing forever, then
	stop the synth with aSynhh.release or a aSynth.free
*/
//:
~mysynth = { SinOsc.ar(440, 0, 0.1).dup }.play;
~mysynth.free;
//:
~mysynth = { SinOsc.ar(440, 0, 0.1).dup }.play;
~mysynth.release(5);
//-------------------------------
//:Creating controls for a synth
/*
One uses SynthControl instances to create named objects
inside a synth, whose value can be set by the user.
One can create SynthControl instances in 2 ways
	1. By declaring them as arguments in the synth function
	2. By sending the message kr to a symbol.
*/
//:Creating a control with a function argument:
//create a synth function with a control;
~synthFunc = { | freq = 440 | SinOsc.ar(freq, 0, 0.1).dup };
//1. Play the synth function with the default control value, 440:
~mysynth = ~synthFunc.play;
//Release the synth
~mysynth.release;
//2. !!! Play the synth with custom control value, 550.
~mysynth = ~synthFunc.play(args: [freq: 550]);
~mysynth.release;
//3. !!! Change the value of the parameter while the synth is playing
~mysynth = ~synthFunc.play;
// later do this to change the value of freq control:
~mysynth.set(\freq, 660);
//3a Set the control several times in a loop:
//------- INTRODUCING Routines! with fork!
//: A self contained routine for playing one melody of sorts.
//
//:The same example as above, using yield instead of wwait.
{
	var synthfunc, synth;
	synthfunc = { | freq = 440 | SinOsc.ar(freq, 0, 0.1).dup };
	synth = synthfunc.play;
	0.5.wait;
	[550, 660, 880] do: { | f |
		synth.set(\freq,f);
		0.5.wait;
	};
	synth release: 1.5;
}.fork;
//:The same example as above, using yield instead of wwait.
x = {
	var synthfunc, synth;
	synthfunc = { | freq = 440 | SinOsc.ar(freq, 0, 0.1).dup };
	synth = synthfunc.play;
	nil.yield;
	[550, 660, 880] do: { | f |
		synth.set(\freq,f);
		nil.yield;
	};
	synth release: 1.5;
}.fork;
//:
x.next;

~mysynth = { | freq = 440 | SinOsc.ar(freq, 0, 0.1).dup }.play;


One an use a SynthControl to set a selected value to a parameter
	either when creating the synth
	or while the synth is running
*/


// Appendix : About Symbols
// arguments to a message
receiver.message(freq: ....):
// constructing an event
b = (freq: 100, amp: 0.1)
//symbols in an array
a = [freq: 100, amp: 0.1];
// is a shortcut of:
a = [\freq, 100, \amp, 0.1];
a[0]
a[1];
b[0];
b[\freq]