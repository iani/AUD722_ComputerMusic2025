
SonicEnvironment {
	classvar default;   // the default environment. 
	var <creatures;

	*default {^default ?? { default = this.new };}

	*new {^super.new.init;}

	init {this.makeCreatures;}

	makeCreatures {
		creatures = Creature.allSubclasses collect: _.new;
	}
	
	day {
		creatures do: _.day;
	}
}