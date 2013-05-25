MylunesChampions.P["enUS"] = {

["Default"] = {
	INHERIT = nil,
	AUTHORS = "nyyr",
	
	EMOTE_BYE = {
		someoneAtPet = "is sad that %s leaves.",
		someoneAtYou = "is sad that %s leaves.",
		youAtPet = "is sad.",
		youAtTarget = "is sad that %t leaves.",
		youNoTarget = "is sad.",
	},
	EMOTE_CHEER = {
	},
	EMOTE_GREET = {
		someoneAtPet = "sniffs at %s.\nis happy to see %s.",
		someoneAtYou = "sniffs at %s.",
		youAtPet = "is happy to see its master.",
		youAtTarget = "sniffs at %t.",
		
		m_youAtPet = "is happy to see his master.",
		f_youAtPet = "is happy to see her master.",
		mm_youAtPet = "is happy to see his mistress.",
		fm_youAtPet = "is happy to see her mistress.",
	},
	EMOTE_STARE = {
		someoneAtPet = "stares back.  Staring contest, yay!\nslowly backs off.",
	},
	EMOTE_WAVE = {
		someoneAtPet = "looks questioningly.",
		youAtPet = "looks questioningly.",
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
		emotes = "tries to taunt the enemy.  Rwarrr!\ntries to save its master.  Rwarrr!",
	},
	EVENT_TARGET_LOWHEALTH = {
		emotes = "",
	},
	EVENT_RANDOM = {
		emotes = "is bored.\ndemands for some action!\nis taking a nap.",
		incombat = "is annoyed by all this noise.  Silence!\nhides behind its master.",
		afk = "pokes its master.\ntries to get some treats out of its master's bag.",
	},
	
},

["Beast (cute)"] = {
	INHERIT = "Default",
	AUTHORS = "nyyr",
	
	EMOTE_CHEER = {
		someoneAtPet = "is excited and squeaks.",
		someoneAtYou = "is excited about %s.",
		youAtPet = "is excited and squeaks.",
		youAtTarget = "is excited about %t.",
		youNoTarget = "is excited.",
	},
	EMOTE_WAVE = {
		someoneAtPet = "is excited and squeaks.",
		someoneAtYou = "is excited about %s.",
		youAtPet = "is excited and squeaks.",
		youAtTarget = "is excited about %t.",
		youNoTarget = "is excited.",
	},
},

["Beast (ferocious)"] = {
	INHERIT = "Default",
	AUTHORS = "nyyr",
	
	["EMOTE_WAVE"] = {
		["someoneAtPet"] = "growls at %s.",
	},
	["EMOTE_CHEER"] = {
		["youAtPet"] = "looks questioningly.",
		["someoneAtPet"] = "growls at %s.",
	},
	["EMOTE_GREET"] = {
		["someoneAtPet"] = "sniffs at %s.\ngrowls at %s.",
	},
	["EMOTE_STARE"] = {
		["youAtPet"] = "looks questioningly.",
		["someoneAtPet"] = "growls at %s.",
	},
	
	EVENT_PET_LOWHEALTH = {
		emotes = "roars in agony.",
	},
	EVENT_PLAYER_LOWHEALTH = {
		emotes = "roars fiercely because of its master's pain!\ngoes into a frenzy because of its master's pain!",
	},
	EVENT_TARGET_LOWHEALTH = {
		emotes = "scents the close death of its prey and roars fiercely.\ngoes into a murderous frenzy because of all the blood that sheds from the wounds of its prey.",
	},
},

["Humanoid"] = {
	INHERIT = "Default",
	AUTHORS = "nyyr, Hanouneh",
	
	["EVENT_RANDOM"] = {
		["incombat"] = "is annoyed by all this noise.  Silence!\nhides behind its master.\ngoes shopping until the battle is over.\nroars: 'Chaaaarge!!'",
	},
},

["Demon"] = {
	INHERIT = "Default",
},

["Flying"] = {
	INHERIT = "Default",
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
	INHERIT = "Default",
},

}

-- creature type (combat pets) -> personality
MylunesChampions.PCT["enUS"] = {
	Bat = { p = "Flying" },
	Bear = { p = "Beast (ferocious)" },
	Beast = { p = "Beast (ferocious)" },
	Beetle = { p = "Critter" },
	["Bird of Prey"] = { p = "Flying" },
	Boar = { p = "Beast (ferocious)" },
	["Carrion Bird"] = { p = "Flying" },
	Cat = { p = "Beast (ferocious)" },
	Chimaera = { p = "Flying" },
	["Core Hound"] = { p = "Beast (ferocious)" },
	Crab = { p = "Default" },
	Critter = { p = "Critter" },
	Crocolisk = { p = "Beast (ferocious)" },
	Demon = { p = "Demon" },
	Devilsaur = { p = "Beast (ferocious)" },
	Dog = { p = "Beast (ferocious)" },
	Doomguard = { p = "Demon" },
	Dragonhawk = { p = "Flying" },
	Dragonkin = { p = "Flying" },
	Elemental = { p = "Elemental" },
	Felguard = { p = "Demon" },
	Felhunter = { p = "Demon" },
	Fox = { p = "Beast (cute)" },
	["Gas Cloud"] = { p = "Inanimate" },
	Ghoul = { p = "Undead" },
	Giant = { p = "Default" },
	Gorilla = { p = "Beast (ferocious)" },
	Humanoid = { p = "Humanoid" },
	Hyena = { p = "Beast (ferocious)" },
	Imp = { p = "Demon" },
	Mechanical = { p = "Mechanical" },
	Monkey = { p = "Beast (cute)" },
	Moth = { p = "Flying" },
	["Nether Ray"] = { p = "Flying" },
	Raptor = { p = "Beast (ferocious)" },
	Ravager = { p = "Beast (ferocious)" },
	["Remote Control"] = { p = "Mechanical" },
	Rhino = { p = "Beast (ferocious)" },
	Scorpid = { p = "Default" },
	Serpent = { p = "Default" },
	["Shale Spider"] = { p = "Default" },
	Silithid = { p = "Default" },
	Spider = { p = "Critter" },
	["Spirit Beast"] = { p = "Beast (ferocious)" },
	Sporebat = { p = "Flying" },
	Succubus = { p = "Demon" },
	Tallstrider = { p = "Default" },
	Totem = { p = "Inanimate" },
	Turtle = { p = "Default" },
	Undead = { p = "Undead" },
	Voidwalker = { p = "Undead" },
	["Warp Stalker"] = { p = "Beast (ferocious)" },
	Wasp = { p = "Flying" },
	["Water Elemental"] = { p = "Elemental" },
	["Wind Serpent"] = { p = "Flying" },
	Wolf = { p = "Beast (ferocious)" },
	Worm = { p = "Default" },
}

-- pet type (battle pets) -> personality
MylunesChampions.PPT["enUS"] = {
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
