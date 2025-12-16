
SynthDef(\panPlaybuf, {| out=0, buf, amp=0.1, rate=1, pan=0|
	var sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, doneAction:2);
	Out.ar(out, Pan2.ar(sig, pan) * amp);
});