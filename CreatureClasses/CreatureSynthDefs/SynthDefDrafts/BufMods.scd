//: Load all sound files from folder audiofiles,into buffers.
// Store each buffer in the current environment, named after
// the name of the file. 
PathName("~/audiofiles/".standardizePath).entries do: { | p |
	var bufname;
	bufname = p.fileNameWithoutExtension.asSymbol.postln;
	currentEnvironment.put(bufname,
		Buffer.read(Server.default, p.fullPath)
	);
	
};
//:
//==================================================================================================== 
//:
a = { | f = 400, a = 1 |
	var buf, sig;
	buf = ~crickets;
	sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf), doneAction: 2);
	sig * SinOsc.ar(Line.kr(1, 5000, 10), 0, a);
}.play;
//:
a = {
	var buf, sig;
	buf = ~crickets;
	sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1, doneAction: 2);
	sig * SinOsc.ar(LFNoise1.kr(5.reciprocal).range(1, 500));
}.play;
//: !!!!! MAKE A NOTE OF THIS ONE !!!!!
a = {
	var buf, sig;
	buf = ~crickets;
	sig = PlayBuf.ar(1, buf,
		LFNoise1.kr(10.reciprocal).range(0.1, 2) * BufRateScale.kr(buf),
		loop: 1, doneAction: 2);
	sig * SinOsc.ar(LFNoise1.kr(5.reciprocal).range(1, 500));
}.play;
//:
a.set(\f, 3000)
//:
{
	PlayBuf.ar(1, Cricket.buffer) * Env.sine.kr(2)
}.play;
//:

{
	PlayBuf.ar(1, Cricket.buffer) * SinOsc.ar(1000) * Env.sine.kr(2)
}.play;
//:

{
	PlayBuf.ar(1, Cricket.buffer) * SinOsc.ar(Line.kr(100, 1000, 1)) * Env.sine.kr(2)
}.play;
//:

{
	PlayBuf.ar(1, Cricket.buffer, Line.kr(0.2, 2, 1) * BufRateScale.kr(Cricket.buffer)) * Env.sine.kr(2)
}.play;
//:

{
	var buf;
	buf = Cricket.buffer.bufnum;
	PlayBuf.ar(1, buf,
		Line.kr(1.5, 0.2, 1) * BufRateScale.kr(buf),
		1, 15 * BufSampleRate.kr(buf)
	) * Env.sine(1).kr(2)
}.play;
//:

{
	var buf, mod;
	buf = Cricket.buffer.bufnum;
	mod = SinOsc.ar(1000);
	PlayBuf.ar(1, buf,
		Line.kr(1.5, 0.2, 1) * BufRateScale.kr(buf),
		1, 15 * BufSampleRate.kr(buf)
	) * mod * Env.sine(1).kr(2)
}.play;
//:

{
	PlayBuf.ar(1, Cricket.buffer) * Env.welch.kr(2)
}.play;