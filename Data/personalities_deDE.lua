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
		emotes = "ist gelangweilt.\nwill etwas unternehmen!\nmacht ein Nickerchen.\nist hungrig.\nversucht nach einer Fliege zu schnappen.\nist erschöpft vom letzten Abenteuer.",
		incombat = "nervt der ganze Lärm. Ruhe!\nversteckt sich hinter seinem Herrchen.\nschnappt nach dem Gegner.\nversucht den Gegner einzuschüchtern. Grrr!!!\nlässt sich nieder, völlig erschöpft vom Kampf.\nspringt auf die Schultern seines Herrchens und knurrt den Gegner an. Grrr!!!",
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
		useEmote = "CHEER",
	},
	
	["EVENT_RANDOM"] = {
		["emotes"] = "ist gelangweilt.\nwill etwas unternehmen!\nmacht ein Nickerchen.\nist hungrig.\nversucht nach einer Fliege zu schnappen.\npinkelt seinem Herrchen ans Bein.\nführt ein Kunststückchen auf. Wie beeindruckend!",
	},
	["EMOTE_GREET"] = {
		["youAtPet"] = "freut sich seinen Meister zu sehen.",
	},
	
	["EVENT_PLAYER_LOWHEALTH"] = {
		["emotes"] = "versucht den Gegner abzuspotten. Grrar!\nversucht sein Herrchen zu retten. Grrr!\nhat Angst um sein Herrchen.\ngerät in Panik!\nschaut sich wild nach einem Heiler um.\nschaut voller Panik in das schmerzverzerrte Gesicht seines Herrchens.",
	},
	["EVENT_RANDOM"] = {
		["emotes"] = "ist gelangweilt.\nwill etwas unternehmen!\nmacht ein Nickerchen.\nist hungrig.\nversucht nach einer Fliege zu schnappen.\nführt ein Kunststückchen auf. Wie beeindruckend!\nlässt sich erschöpft nieder.\ngähnt kräftig. Als wolle er einen Elekk verschlingen!",
	},
	["EVENT_TARGET_LOWHEALTH"] = {
		["emotes"] = "versucht seinem Gegner den Todesstoß zu versetzen. Daneben!\nstürmt seinen Gegner an - und an ihm vorbei.\nmacht schonmal Platz, um nicht unter dem Gegner zu liegen.",
	},
},

["Beast (ferocious)"] = {
	INHERIT = "Default",
	AUTHORS = "nyyr",
	
	["EMOTE_WAVE"] = {
		["someoneAtPet"] = "schaut %s knurrend an.\nknurrt %s an.",
	},
	["EMOTE_CHEER"] = {
		["youAtPet"] = "knurrt %s an.",
		["someoneAtPet"] = "knurrt %s an.",
	},
	["EMOTE_GREET"] = {
		["someoneAtPet"] = "schnüffelt knurrend an %s.\nknurrt %s an.",
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
		emotes = "wittert den nahen Tod seiner Beute und brüllt furchterregend.\ngerät in einen tödlichen Rausch wegen des ganzen Blutes, das aus den Wunden seiner Beute rinnt.",
		
		f_emotes = "wittert den nahen Tod ihrer Beute und brüllt furchterregend.\ngerät in einen tödlichen Rausch wegen des ganzen Blutes, das aus den Wunden ihrer Beute rinnt.",
	},
},

["Humanoid"] = {
	INHERIT = "Default",
	AUTHORS = "nyyr, Hanouneh",
	
	["EVENT_RANDOM"] = {
		["incombat"] = "nervt der ganze Lärm. Ruhe!\nversteckt sich hinter seinem Meister.\ngeht solange shoppen bis der Kampf vorbei ist.\nbrüllt: 'Attackeeeee!!'",
	},
},

["Demon"] = {
	INHERIT = "Default",
},

["Flying"] = {
	INHERIT = "Beast (cute)",
	["EVENT_RANDOM"] = {
		["emotes"] = "ist gelangweilt.\nwill etwas unternehmen!\nmacht ein Nickerchen.\nist hungrig.\nversucht nach einer Fliege zu schnappen.\nist erschöpft vom letzten Abenteuer.\nflattert unruhig.",
	},
	["EMOTE_CHEER"] = {
		["youAtPet"] = "quiekt vor Freude und flattert wie wild.",
		["youAtTarget"] = "ist voller Aufregung wegen %t und flattert ganz wild.",
		["someoneAtYou"] = "ist voller Aufregung wegen %s und flattert ganz wild.",
		["someoneAtPet"] = "quiekt vor Freude.\nflattert ganz aufgeregt.",
		["youNoTarget"] = "ist aufgeregt und flattert wie wild.",
	},
},

["Undead"] = {
	INHERIT = "Default",
},

["Critter"] = {
	INHERIT = "Default",
},

["Inanimate"] = {
	INHERIT = "Default",
},

["Elemental"] = {
	INHERIT = "Default",
},

["Aquatic"] = {
	INHERIT = "Default",
},

["Mechanical"] = {
	["EMOTE_DANCE"] = {
		["useEmote"] = "CHEER",
	},
	["EMOTE_WAVE"] = {
		["useEmote"] = "CHEER",
	},
	["EMOTE_GREET"] = {
		["useEmote"] = "CHEER",
	},
	["EMOTE_CRY"] = {
		["useEmote"] = "CHEER",
	},
	["EMOTE_KISS"] = {
		["useEmote"] = "CHEER",
	},
	["EMOTE_HUG"] = {
		["useEmote"] = "CHEER",
	},
	["EVENT_RANDOM"] = {
		["emotes"] = "surrt und piepst leise.\nlässt einen Schlag. Ist da gerade eine Bolzen rausgefallen?!\ntuckert gleichmäßig vor sich hin.\nquietscht kräftig.\nverschluckt sich kurz.",
	},
	["EMOTE_CHEER"] = {
		["someoneAtYou"] = "analysiert %ss Verhalten.",
		["someoneAtPet"] = "analysiert %ss Verhalten.",
		["youAtTarget"] = "registriert eine Interaktion zwischen %s und %t. Analyse wird durchgeführt.",
		["youNoTarget"] = "kann %ss Verhalten nicht auswerten.",
	},
	["EMOTE_STARE"] = {
		["youAtPet"] = "",
		["someoneAtPet"] = "scannt %s. 'Ziel erfasst.'",
	},
	["EMOTE_BYE"] = {
		["someoneAtPet"] = "bricht die Analyse ab und löscht %s aus dem Speicher.",
		["youAtTarget"] = "bricht die Analyse ab und löscht %t aus dem Speicher.",
	},
},

}

-- creature type -> personality
MylunesChampions.PCT["deDE"] = {
	Bat = { p = "Flying", s = "f" },
	Bear = { p = "Beast (ferocious)", s = "m" },
	Beast = { p = "Beast (ferocious)" },
	Beetle = { p = "Critter", s = "m" },
	["Bird of Prey"] = { p = "Flying", s = "m" },
	Boar = { p = "Beast (ferocious)", s = "m" },
	["Carrion Bird"] = { p = "Flying", s = "m" },
	Cat = { p = "Beast (ferocious)", s = "f" },
	Chimaera = { p = "Flying", s = "f" },
	["Core Hound"] = { p = "Beast (ferocious)", s = "m" },
	Crab = { p = "Default", s = "f" },
	Critter = { p = "Critter" },
	Crocolisk = { p = "Beast (ferocious)", s = "m" },
	Demon = { p = "Demon", s = "m" },
	Devilsaur = { p = "Beast (ferocious)", s = "m" },
	Dog = { p = "Beast (ferocious)", s = "m" },
	Doomguard = { p = "Demon", s = "f" },
	Dragonhawk = { p = "Flying", s = "m" },
	Dragonkin = { p = "Flying", s = "m" },
	Elemental = { p = "Elemental" },
	Felguard = { p = "Demon", s = "m" },
	Felhunter = { p = "Demon", s = "m" },
	Fox = { p = "Beast (cute)", s = "m" },
	["Gas Cloud"] = { p = "Inanimate", s = "f" },
	Ghoul = { p = "Undead", s = "m" },
	Giant = { p = "Default", s = "m" },
	Gorilla = { p = "Beast (ferocious)", s = "m" },
	Humanoid = { p = "Humanoid", s = "m" },
	Hyena = { p = "Beast (ferocious)", s = "f" },
	Imp = { p = "Demon", s = "m" },
	Mechanical = { p = "Mechanical" },
	Monkey = { p = "Beast (cute)", s = "m" },
	Moth = { p = "Flying", s = "f" },
	["Nether Ray"] = { p = "Flying", s = "m" },
	Raptor = { p = "Beast (ferocious)", s = "m" },
	Ravager = { p = "Beast (ferocious)", s = "m" },
	["Remote Control"] = { p = "Mechanical", s = "f" },
	Rhino = { p = "Beast (ferocious)" },
	Scorpid = { p = "Default" },
	Serpent = { p = "Default", s = "f" },
	["Shale Spider"] = { p = "Default" },
	Silithid = { p = "Default", s = "m" },
	Spider = { p = "Default", s = "f" },
	["Spirit Beast"] = { p = "Beast (ferocious)", s = "f" },
	Sporebat = { p = "Flying", s = "m" },
	Succubus = { p = "Demon", s = "f" },
	Tallstrider = { p = "Default", s = "m" },
	Totem = { p = "Inanimate" },
	Turtle = { p = "Default", s = "f" },
	Undead = { p = "Undead", s = "m" },
	Voidwalker = { p = "Demon", s = "m" },
	["Warp Stalker"] = { p = "Beast (ferocious)", s = "m" },
	Wasp = { p = "Flying", s = "f" },
	["Water Elemental"] = { p = "Elemental" },
	["Wind Serpent"] = { p = "Flying", s = "f" },
	Wolf = { p = "Beast (ferocious)", s = "m" },
	Worm = { p = "Default", s = "m" },
}

-- pet type (battle pets) -> personality
MylunesChampions.PPT["deDE"] = {
	[1] = { p = "Humanoid" }, -- Humanoid
	[2] = { p = "Flying" }, -- Dragonkin
	[3] = { p = "Flying" }, -- Flying
	[4] = { p = "Undead" }, -- Undead
	[5] = { p = "Critter" }, -- Critter
	[6] = { p = "Inanimate" }, -- Magic
	[7] = { p = "Elemental" }, -- Elemental
	[8] = { p = "Beast (cute)" }, -- Beast
	[9] = { p = "Aquatic" }, -- Aquatic
	[10] = { p = "Mechanical" }, -- Mechanical
}
