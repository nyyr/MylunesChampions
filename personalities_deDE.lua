MylunesChampions.P["deDE"] = {

["Default"] = {
	INHERIT = nil,
	
	EMOTE_BYE = {
		someoneAtPet = "ist traurig, dass %s geht.",
		someoneAtYou = "ist traurig, dass %s geht.",
		someoneNoTarget = "ist traurig, dass %s geht.",
		youAtPet = "ist traurig.",
		youAtTarget = "ist traurig, dass %t geht.",
		youNoTarget = "ist traurig.",
	},
	EMOTE_CHEER = {
	},
	EMOTE_GREET = {
		someoneAtPet = [=[schnüffelt an %s.
freut sich %s zu sehen.]=],
		someoneAtYou = "schnüffelt an %s.",
		someoneNoTarget = "schnüffelt an %s.",
		youAtPet = "freut sich seinen Meister zu sehen.",
		youAtTarget = "schnüffelt an %t.",
	},
	EMOTE_STARE = {
		someoneAtPet = [=[starrt zurück. Wer zuerst blinzelt!
versteckt sich hinter seinem Meister.]=],
		youAtPet = "starrt zurück. Wer zuerst blinzelt!",
	},
	EMOTE_WAVE = {
		someoneAtPet = "schaut fragend.",
		youAtPet = "schaut fragend.",
	},
	EVENT_PET_LOWHEALTH = {
		emotes = "",
	},
	EVENT_PLAYER_LOWHEALTH = {
		emotes = [=[versucht den Gegner abzuspotten. Grrar!
versucht seinen Meister zu retten. Grrr!]=],
	},
	EVENT_TARGET_LOWHEALTH = {
		emotes = "",
	},
},

["Default (m)"] = {
	INHERIT = "Default",
},

["Default (f)"] = {
	INHERIT = "Default",
	
	EMOTE_GREET = {
		youAtPet = "freut sich ihren Meister zu sehen.",
	},
	EMOTE_STARE = {
		someoneAtPet = [=[starrt zurück. Wer zuerst blinzelt!
versteckt sich hinter ihrem Meister.]=],
	},
	EVENT_PLAYER_LOWHEALTH = {
		emotes = [=[versucht den Gegner abzuspotten. Grrar!
versucht ihren Meister zu retten. Grrr!]=],
	},
},

["Beast (cute)"] = {
	INHERIT = "Default",
	
	EMOTE_CHEER = {
		someoneAtPet = "quiekt vor Freude.",
		someoneAtYou = "ist voller Aufregung wegen %s.",
		youAtTarget = "ist voller Aufregung wegen %t.",
		youNoTarget = "ist aufgeregt.",
		youAtPet = "quiekt vor Freude.",
	},
	EMOTE_WAVE = {
		someoneAtPet = "quiekt vor Freude.",
		someoneAtYou = "ist voller Aufregung wegen %s.",
		youAtTarget = "ist voller Aufregung wegen %t.",
		youNoTarget = "ist aufgeregt.",
		youAtPet = "quiekt vor Freude.",
	},
},

["Beast (cute, m)"] = {
	INHERIT = "Beast (cute)",
},

["Beast (cute, f)"] = {
	INHERIT = "Beast (cute)",
	
	EMOTE_GREET = {
		youAtPet = "freut sich ihren Meister zu sehen.",
	},
	EMOTE_STARE = {
		someoneAtPet = [=[starrt zurück. Wer zuerst blinzelt!
versteckt sich hinter ihrem Meister.]=],
	},
	EVENT_PLAYER_LOWHEALTH = {
		emotes = [=[versucht den Gegner abzuspotten. Grrar!
versucht ihren Meister zu retten. Grrr!]=],
	},
},

["Beast (ferocious)"] = {
	INHERIT = "Default",
	
	["EMOTE_WAVE"] = {
		["someoneAtPet"] = "schaut fragend.\nknurrt %s an.",
	},
	["EMOTE_CHEER"] = {
		["youAtPet"] = "knurrt %s an.",
		["someoneAtPet"] = "schaut fragend.",
	},
	["EMOTE_GREET"] = {
		["someoneAtPet"] = "schnüffelt an %s.\nknurrt %s an.",
	},
	["EMOTE_STARE"] = {
		["someoneAtPet"] = "starrt zurück. Wer zuerst blinzelt!\nknurrt %s an.",
	},
	
	EVENT_PET_LOWHEALTH = {
		emotes = "brüllt vor Schmerz.",
	},
	EVENT_PLAYER_LOWHEALTH = {
		emotes = "brüllt fürchterlich ob der Schmerzen seines Meisters!\ngerät in einen Blutrausch weil sein Meister leidet.",
	},
	EVENT_TARGET_LOWHEALTH = {
		emotes = [=[wittert den nahen Tod seiner Beute und brüllt fürchterregend.
gerät in einen tödlichen Rausch wegen des ganzen Blutes, das aus den Wunden seiner Beute rinnt.]=],
	},
},

["Beast (ferocious, m)"] = {
	INHERIT = "Beast (ferocious)",
},

["Beast (ferocious, f)"] = {
	INHERIT = "Beast (ferocious)",
	
	["EMOTE_GREET"] = {
		["youAtPet"] = "freut sich ihren Meister zu sehen.",
	},
	
	EVENT_PLAYER_LOWHEALTH = {
		emotes = "brüllt fürchterlich ob der Schmerzen ihres Meisters!\ngerät in einen Blutrausch weil ihr Meister leidet.",
	},
	EVENT_TARGET_LOWHEALTH = {
		emotes = [=[wittert den nahen Tod ihrer Beute und brüllt fürchterregend.
gerät in einen tödlichen Rausch wegen des ganzen Blutes, das aus den Wunden ihrer Beute rinnt.]=],
	},
},

}

-- creature type -> personality
MylunesChampions.PCT["deDE"] = {
	Bat = "Default",
	Bear = "Beast (ferocious, m)",
	Beast = "Beast (ferocious)",
	Beetle = "Default",
	["Bird of Prey"] = "Default",
	Boar = "Beast (ferocious, m)",
	["Carrion Bird"] = "Default",
	Cat = "Beast (ferocious, f)",
	Chimaera = "Default",
	["Core Hound"] = "Beast (ferocious, m)",
	Crab = "Default",
	Crocolisk = "Beast (ferocious, m)",
	Demon = "Default",
	Devilsaur = "Beast (ferocious, m)",
	Dog = "Beast (ferocious, m)",
	Doomguard = "Default",
	Dragonhawk = "Default",
	Dragonkin = "Default",
	Elemental = "Default",
	Felguard = "Default",
	Felhunter = "Default",
	Fox = "Default",
	["Gas Cloud"] = "Default",
	Ghoul = "Default",
	Giant = "Default",
	Gorilla = "Beast (ferocious, m)",
	Humanoid = "Default",
	Hyena = "Default",
	Imp = "Default",
	Mechanical = "Default",
	Monkey = "Default",
	Moth = "Default",
	["Nether Ray"] = "Default",
	Raptor = "Beast (ferocious, m)",
	Ravager = "Default",
	["Remote Control"] = "Default",
	Rhino = "Beast (ferocious, m)",
	Scorpid = "Default",
	Serpent = "Default",
	["Shale Spider"] = "Default",
	Silithid = "Default",
	Spider = "Default",
	["Spirit Beast"] = "Beast (ferocious, f)",
	Sporebat = "Default",
	Succubus = "Default",
	Tallstrider = "Default",
	Totem = "Default",
	Turtle = "Default",
	Undead = "Default",
	Voidwalker = "Default",
	["Warp Stalker"] = "Default",
	Wasp = "Default",
	["Water Elemental"] = "Default",
	["Wind Serpent"] = "Default",
	Wolf = "Beast (ferocious, m)",
	Worm = "Default",
}
