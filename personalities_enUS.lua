MylunesChampions.P["enUS"] = {

["Default"] = {
	INHERIT = "None",
	NAME = "Default",
	
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
	NAME = "Beast (cute)",
	
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
	NAME = "Beast (ferocious)",
	
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

}

-- creature type -> personality
MylunesChampions.PCT["enUS"] = {
	Bat = { p = "Default" },
	Bear = { p = "Beast (ferocious)" },
	Beast = { p = "Beast (ferocious)" },
	Beetle = { p = "Default" },
	["Bird of Prey"] = { p = "Default" },
	Boar = { p = "Beast (ferocious)" },
	["Carrion Bird"] = { p = "Default" },
	Cat = { p = "Beast (ferocious)" },
	Chimaera = { p = "Default" },
	["Core Hound"] = { p = "Beast (ferocious)" },
	Crab = { p = "Default" },
	Critter = { p = "Default" },
	Crocolisk = { p = "Beast (ferocious)" },
	Demon = { p = "Default" },
	Devilsaur = { p = "Beast (ferocious)" },
	Dog = { p = "Beast (ferocious)" },
	Doomguard = { p = "Default" },
	Dragonhawk = { p = "Default" },
	Dragonkin = { p = "Default" },
	Elemental = { p = "Default" },
	Felguard = { p = "Default" },
	Felhunter = { p = "Default" },
	Fox = { p = "Default" },
	["Gas Cloud"] = { p = "Default" },
	Ghoul = { p = "Default" },
	Giant = { p = "Default" },
	Gorilla = { p = "Beast (ferocious)" },
	Humanoid = { p = "Default" },
	Hyena = { p = "Default" },
	Imp = { p = "Default" },
	Mechanical = { p = "Default" },
	Monkey = { p = "Default" },
	Moth = { p = "Default" },
	["Nether Ray"] = { p = "Default" },
	Raptor = { p = "Beast (ferocious)" },
	Ravager = { p = "Default" },
	["Remote Control"] = { p = "Default" },
	Rhino = { p = "Beast (ferocious)" },
	Scorpid = { p = "Default" },
	Serpent = { p = "Default" },
	["Shale Spider"] = { p = "Default" },
	Silithid = { p = "Default" },
	Spider = { p = "Default" },
	["Spirit Beast"] = { p = "Beast (ferocious)" },
	Sporebat = { p = "Default" },
	Succubus = { p = "Default" },
	Tallstrider = { p = "Default" },
	Totem = { p = "Default" },
	Turtle = { p = "Default" },
	Undead = { p = "Default" },
	Voidwalker = { p = "Default" },
	["Warp Stalker"] = { p = "Default" },
	Wasp = { p = "Default" },
	["Water Elemental"] = { p = "Default" },
	["Wind Serpent"] = { p = "Default" },
	Wolf = { p = "Beast (ferocious)" },
	Worm = { p = "Default" },
}
