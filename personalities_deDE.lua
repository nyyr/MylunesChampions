MylunesChampions.P["deDE"] = {

["Default"] = {
	INHERIT = nil,
	AUTHORS = "nyyr",
	
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
		someoneAtPet = "schnüffelt an %s.\nfreut sich %s zu sehen.",
		someoneAtYou = "schnüffelt an %s.",
		someoneNoTarget = "schnüffelt an %s.",
		youAtPet = "freut sich seinen Meister zu sehen.",
		youAtTarget = "schnüffelt an %t.",
		
		f_youAtPet = "freut sich ihren Meister zu sehen.",
	},
	EMOTE_STARE = {
		someoneAtPet = "starrt zurück. Wer zuerst blinzelt!\nversteckt sich hinter seinem Meister.",
		youAtPet = "starrt zurück. Wer zuerst blinzelt!",
		
		f_someoneAtPet = "starrt zurück. Wer zuerst blinzelt!\nversteckt sich hinter ihrem Meister.",
	},
	EMOTE_WAVE = {
		someoneAtPet = "schaut fragend.",
		youAtPet = "schaut fragend.",
	},
	
	EMOTE_AGREE = {},
	EMOTE_AMAZE = {},
	EMOTE_ANGRY = {},
	EMOTE_APOLOGIZE = {},
	EMOTE_APPLAUD = {},
	EMOTE_BARK = {},
	EMOTE_BECKON = {},
	EMOTE_BEG = {},
	EMOTE_BURP = {},
	EMOTE_BITE = {},
	EMOTE_BLINK = {},
	EMOTE_BLEED = {},
	EMOTE_BORED = {},
	EMOTE_BOW = {},
	EMOTE_KISS = {},
	EMOTE_SCRATCH = {},
	EMOTE_CHICKEN = {},
	EMOTE_EAT = {},
	EMOTE_CHUCKLE = {},
	EMOTE_CLAP = {},
	EMOTE_COLD = {},
	EMOTE_CONFUSED = {},
	EMOTE_CONGRATULATE = {},
	EMOTE_COUGH = {},
	EMOTE_COWER = {},
	EMOTE_CRY = {},
	EMOTE_CUDDLE = {},
	EMOTE_CURIOUS = {},
	EMOTE_CURTSEY = {},
	EMOTE_DANCE = {},
	EMOTE_DRINK = {},
	EMOTE_FLEE = {},
	EMOTE_FOLLOW = {},
	EMOTE_HUNGRY = {},
	EMOTE_GOLFCLAP = {},
	EMOTE_GRIN = {},
	EMOTE_HUG = {},
	EMOTE_INSULT = {},
	EMOTE_TIRED = {},
	EMOTE_TRAIN = {},
	EMOTE_THANK = {},
	EMOTE_VICTORY = {},
	EMOTE_WELCOME = {},
	EMOTE_YAWN = {},
	
	EVENT_PET_LOWHEALTH = {
		emotes = "",
	},
	EVENT_PLAYER_LOWHEALTH = {
		emotes = "versucht den Gegner abzuspotten. Grrar!\nversucht sein Herrchen zu retten. Grrr!",
		["fm_emotes"] = "versucht den Gegner abzuspotten. Grrar!\nversucht ihr Frauchen zu retten. Grrr!",
		["f_emotes"] = "versucht den Gegner abzuspotten. Grrar!\nversucht ihr Herrchen zu retten. Grrr!",
		["mm_emotes"] = "versucht den Gegner abzuspotten. Grrar!\nversucht sein Frauchen zu retten. Grrr!",
	},
	EVENT_TARGET_LOWHEALTH = {
		emotes = "",
	},
	EVENT_RANDOM = {
		emotes = "ist gelangweilt.\nwill etwas unternehmen!\nmacht ein Nickerchen.\nist hungrig.\nversucht nach einer Fliege zu schnappen.",
		incombat = "nervt der ganze Lärm. Ruhe!\nversteckt sich hinter seinem Herrchen.\nschnappt nach dem Gegner.",
		afk = "stubst sein Herrchen an.\nsucht nach ein paar Leckerlis in der Tasche seines Herrchens.",
		f_afk = "stubst ihr Herrchen an.\nsucht nach ein paar Leckerlis in der Tasche ihres Herrchens.",
		mm_afk = "stubst sein Frauchen an.\nsucht nach ein paar Leckerlis in der Tasche seines Frauchens.",
		fm_afk = "stubst ihr Frauchen an.\nsucht nach ein paar Leckerlis in der Tasche ihres Frauchens.",
	},
},

["Beast (cute)"] = {
	INHERIT = "Default",
	AUTHORS = "nyyr, Hanouneh",
	
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
	
	["EVENT_RANDOM"] = {
		["emotes"] = "ist gelangweilt.\nwill etwas unternehmen!\nmacht ein Nickerchen.\nist hungrig.\nversucht nach einer Fliege zu schnappen.\npinkelt seinem Herrchen ans Bein.\nführt ein Kunststückchen auf. Wie beeindruckend!",
	},
	["EMOTE_GREET"] = {
		["youAtPet"] = "freut sich seinen Meister zu sehen.",
	},
},

["Humanoid (silly)"] = {
	INHERIT = "Default",
	AUTHORS = "nyyr, Hanouneh",
	
	["EVENT_RANDOM"] = {
		["incombat"] = "nervt der ganze Lärm. Ruhe!\nversteckt sich hinter seinem Meister.\ngeht solange shoppen bis der Kampf vorbei ist.\nbrüllt: 'Attackeeeee!!'",
	},
},

["Beast (ferocious)"] = {
	INHERIT = "Default",
	AUTHORS = "nyyr",
	
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
		["someoneAtPet"] = "knurrt %s an.",
	},
	
	EVENT_PET_LOWHEALTH = {
		emotes = "brüllt vor Schmerz.",
	},
	EVENT_PLAYER_LOWHEALTH = {
		emotes = "brüllt fürchterlich ob der Schmerzen seines Meisters!\ngerät in einen Blutrausch weil sein Meister leidet.",
		
		f_emotes = "brüllt fürchterlich ob der Schmerzen ihres Meisters!\ngerät in einen Blutrausch weil ihr Meister leidet.",
	},
	EVENT_TARGET_LOWHEALTH = {
		emotes = "wittert den nahen Tod seiner Beute und brüllt fürchterregend.\ngerät in einen tödlichen Rausch wegen des ganzen Blutes, das aus den Wunden seiner Beute rinnt.",
		
		f_emotes = "wittert den nahen Tod ihrer Beute und brüllt fürchterregend.\ngerät in einen tödlichen Rausch wegen des ganzen Blutes, das aus den Wunden ihrer Beute rinnt.",
	},
},

}

-- creature type -> personality
MylunesChampions.PCT["deDE"] = {
	Bat = { p = "Default", s = "f" },
	Bear = { p = "Beast (ferocious)", s = "m" },
	Beast = { p = "Beast (ferocious)" },
	Beetle = { p = "Default", s = "m" },
	["Bird of Prey"] = { p = "Default", s = "m" },
	Boar = { p = "Beast (ferocious)", s = "m" },
	["Carrion Bird"] = { p = "Default", s = "m" },
	Cat = { p = "Beast (ferocious)", s = "f" },
	Chimaera = { p = "Default", s = "f" },
	["Core Hound"] = { p = "Beast (ferocious)", s = "m" },
	Crab = { p = "Default", s = "f" },
	Crocolisk = { p = "Beast (ferocious)", s = "m" },
	Demon = { p = "Default", s = "m" },
	Devilsaur = { p = "Beast (ferocious)", s = "m" },
	Dog = { p = "Beast (ferocious)", s = "m" },
	Doomguard = { p = "Default", s = "f" },
	Dragonhawk = { p = "Default", s = "m" },
	Dragonkin = { p = "Default", s = "m" },
	Elemental = { p = "Default" },
	Felguard = { p = "Default", s = "m" },
	Felhunter = { p = "Default", s = "m" },
	Fox = { p = "Default", s = "m" },
	["Gas Cloud"] = { p = "Default", s = "f" },
	Ghoul = { p = "Default", s = "m" },
	Giant = { p = "Default", s = "m" },
	Gorilla = { p = "Beast (ferocious)", s = "m" },
	Humanoid = { p = "Default", s = "m" },
	Hyena = { p = "Default", s = "f" },
	Imp = { p = "Default", s = "m" },
	Mechanical = { p = "Default" },
	Monkey = { p = "Default", s = "m" },
	Moth = { p = "Default", s = "f" },
	["Nether Ray"] = { p = "Default", s = "m" },
	Raptor = { p = "Beast (ferocious)", s = "m" },
	Ravager = { p = "Default", s = "m" },
	["Remote Control"] = { p = "Default", s = "f" },
	Rhino = { p = "Beast (ferocious)" },
	Scorpid = { p = "Default" },
	Serpent = { p = "Default", s = "f" },
	["Shale Spider"] = { p = "Default" },
	Silithid = { p = "Default", s = "m" },
	Spider = { p = "Default", s = "f" },
	["Spirit Beast"] = { p = "Beast (ferocious)", s = "f" },
	Sporebat = { p = "Default", s = "m" },
	Succubus = { p = "Default", s = "f" },
	Tallstrider = { p = "Default", s = "m" },
	Totem = { p = "Default" },
	Turtle = { p = "Default", s = "f" },
	Undead = { p = "Default", s = "m" },
	Voidwalker = { p = "Default", s = "m" },
	["Warp Stalker"] = { p = "Default", s = "m" },
	Wasp = { p = "Default", s = "f" },
	["Water Elemental"] = { p = "Default" },
	["Wind Serpent"] = { p = "Default", s = "f" },
	Wolf = { p = "Beast (ferocious)", s = "m" },
	Worm = { p = "Default", s = "m" },
}
