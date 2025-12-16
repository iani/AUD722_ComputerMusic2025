
c = SynthController(\model, Synth(\default));
\model.changed(\release);
//:
c = Cricket();
c substitute: Synth(\default, [freq: 500 rrand: 1000]);
c substitute: Task({ loop { (degree: 10.rand.neg, dur: 0.1).play; 0.1.wait; } }).start;
c.substituteTimed(Synth(\default, [freq: 500 rrand: 1000]), 0.5);

c addTimed: Task({ loop { (degree: 10.rand.neg, dur: 0.1).play; 0.1.wait; } }).start
c addTimed: Synth(\default, [freq: 500 rrand: 1000]);

c add: Synth(\default, [freq: 500 rrand: 1000]);
c.set(\freq, 560, \amp, 0.05);
c add: Task({ loop { (degree: 10.rand.neg, dur: 0.1).play; 0.1.wait; } }).start;
c.release;
Server.default.defaultGroup isKindOf: Node;


c addTimed: c.buffer.play;
c.addTimed(Synth(\default), 500);

a = Task({ loop { (degree: 10.rand.neg, dur: 0.1).play; 0.1.wait; } }).start;
a.isRunning;
a.isPlaying;
a.stop;

b = Synth(\default);
b.register;
b.isRunning = true;
b.isPlaying = true;
b run: 0;
b run: 1;
b.isRunning;
b.isPlaying;

c.buffer.play;