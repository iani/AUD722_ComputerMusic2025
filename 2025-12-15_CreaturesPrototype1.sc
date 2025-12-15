Kostas {
	var <synth;
	/*
~state = 0; // 0 : Day - Normal
~state = 1; // 1 : Hunting
~state = 2; // 2 : Hiding
~state = 3; // 3 : Seeking other creatures
~state = 4; // 4 : Night - Normal
~state = 5; // 5 : Sleeping

~state = 10; // 10 : End
	*/

	// ----- GENERIC UTILITIES ------
	startSynth { | ... args |
		if (synth.isRunning.not) {
			// put your synth function here 
			synth = {
				// put your synth function here. 
			}.play(args: args);
			synth.isRunning = true;
			synth.register;
		}{
			
		} 
	}

	// BEHAVIOUR SPECIFIC METHOD
	day {
		this.startSynth(freq: 600, rate: 0.5);
	}
	
	hunt {

	}

	hide {

	}
	
	seek {

	}

	night {

	}

	sleep {
		
	}

	die {
		
	}
}