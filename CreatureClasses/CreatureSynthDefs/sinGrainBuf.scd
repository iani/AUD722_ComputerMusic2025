
SynthDef(\panPlayBuf, {| out=0, buf, amp=0.1, rate=1, pan=0, gate=1, startPos = 0 |
	var sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate,
		1,
		startPos * BufSampleRate.kr(buf) min: BufFrames.kr(buf),
		1,
		doneAction:2);
	Out.ar(out, Pan2.ar(sig, pan) * amp * Env.adsr(0.01, 0.3, 1).kr(2, gate));
});