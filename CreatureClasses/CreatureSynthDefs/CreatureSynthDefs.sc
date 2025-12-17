
CreatureSynthDefs {
	*initClass {
		ServerBoot add: { this.loadSynthDefs };
	}

	*loadSynthDefs {
		(PathName(this.class.filenameSymbol.asString).pathOnly +/+ "*.scd")
		.pathMatch do: { | p |
			var def;
			def = p.load;
			postln("Adding synthdef: " + def.name);
			def.add;
		};
	}
}


