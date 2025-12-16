
c = SynthController(\model, Synth(\default));
\model.changed(\release);
//:
c = Cricket();
c substitute: Synth(\default, [freq: 500 rrand: 1000]);
c substitute: Task({ loop { (degree: 10.rand.neg, dur: 0.1).play; 0.1.wait; } }).start;

c addTimed: Task({ loop { (degree: 10.rand.neg, dur: 0.1).play; 0.1.wait; } }).start
c addTimed: Synth(\default, [freq: 500 rrand: 1000]);

Server.default.defaultGroup isKindOf: Node;


a = Task({ loop { (degree: 10.rand.neg, dur: 0.1).play; 0.1.wait; } }).start;
a.isRunning;
a.isPlaying;

b = Synth(\default);
b.register;
b.isRunning = true;
b.isPlaying = true;
b run: 0;
b run: 1;
b.isRunning;
b.isPlaying;