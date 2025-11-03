
s.boot;
// Note : this is equivalent to :
Server.default.boot;
s;
s === Server.default;

Server.default.options.numOutputBusChannels:

Server.default.options.numAudioBusChannels;
Server.default.options.numControlBusChannels;


S V

Help.gui;

{ SinOsc.ar(440, 0, 0.2); }.play;

//: Channel variations
// Customize the output channel number
// Output to the first channel (left)
{ Out.ar(0, SinOsc.ar(440, 0, 0.2)); }.play;
// Output to the second channel (right)
{ Out.ar(1, SinOsc.ar(440, 0, 0.2)); }.play;
// Other channels - usually internal
{ Out.ar(2, SinOsc.ar(440, 0, 0.2)); }.play;

//: Mulichannel expansion
// = Many UGen with one statement.
{ SinOsc.ar([440, 550], 0, 0.2); }.play;

{ SinOsc.ar([440, 550, 660], 0, 0.2); }.play;
//: Mixing
{ Mix(SinOsc.ar([440, 550, 660], 0, 0.2)); }.play;
//: Duplicating a signal
{ Mix(SinOsc.ar([440, 550, 660], 0, 0.2)).dup; }.play;
//: Duplicating many times
{ Mix(SinOsc.ar([440, 550, 660], 0, 0.2)).dup(10); }.play;
//:Using decibel amplitude
{ SinOsc.ar(440, 0, -2.dbamp); }.play;
//: Print calculations from an array of numbers
(-20..20);
(-20..20).dbamp;
(-20..20).dbamp do: _.postln;
//:dbamp ampdb
(-20..20).dbamp do: { | a | [a, a.dbamp].postln };
//:
(-20..20) do: { | a |
  postf("value: %, dbamp: %\n", a, a.dbamp)
};
//:
//:
(-50..0) do: { | a |
  postf("value: %, dbamp: %\n", a, a.dbamp)
};
//:
//
Server.default.scope;
//:

//: Syntax:
// Subject    Verb   Object
// Alexandros opened the laptop
// Subject Verb Modifier/specifier
Alexandros runs fast
// Subject : Always first
// !!! Subject === RECEIVER !!!
// !!! Verb === MESSAGE
// !!! Obect(s) / Modifier === ARGUMENT


//: Class system
Object.allSubclasses.size

Object.allSubclasses do: _.postln;



//: Variations
