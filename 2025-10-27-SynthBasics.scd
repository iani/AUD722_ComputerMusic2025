// Creating synths
// Creating routines
// Controlling synths

Server.default.boot;

// Server.default.quit;

Synth(\default);
//:
a = Synth(\default);
//;
a.free;
//:
a.release;
//:
a.release(10);
//:
a = Synth(\default, [freq: 550]);
//:
a = Synth(\default, [freq: 200.rrand(1550)]);
//:
f = { a = Synth(\default, [freq: 200.rrand(1550)]); };
//:
f.value;
//:
(
f = {
a = Synth(\default, [freq: 200.rrand(1550)]);
};
)
//:
(
f = {
var synth;
synth = Synth(\default, [freq: 200.rrand(1550)]);
1.wait;
synth.release;
};
)
//:
f.fork;
//:
5 do: { f.fork; };
//:
i = { 5 do: { f.fork; }; };
//:
i.value;
//:
j = { 5 do: { f.fork; 0.8.wait; }; };
//:
j = { 5 do: { f.fork; 0.1.rrand(0.5).wait; }; };
//:
j.fork;
//:
k = { 15 do: { f.fork; [0.2, 0.4].choose.wait; }; };
//:
k.fork;
//:
g = {
var synth;
synth = Synth(\default, [freq: 200.rrand(1550)]);
nil.yield;
synth.release;
};
//:
//:
h = g.fork;

Receiver.message;

Yield.new;

nil.yield;

WaitForEver.new;
WaitForEver();

h.next;
//
//
f.value;
//:
f.fork;
//:
a.release;
//
200.rrand(1500.0);

f;


//
a ... z

a, b, c, d, e ..... x, y, z;


a.isRunning;
a.isPlaying;

z
