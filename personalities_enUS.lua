MylunesChampions.P["enUS"] = {

["Default"] = {
	INHERIT = "None",
	
	EMOTE_BYE = {
		someoneAtPet = "is sad that %s leaves.",
		someoneAtYou = "is sad that %s leaves.",
		someoneNoTarget = "is sad that %s leaves.",
		youAtPet = "is sad.",
		youAtTarget = "is sad that %t leaves.",
		youNoTarget = "is sad.",
	},
	EMOTE_CHEER = {
	},
	EMOTE_GREET = {
		someoneAtPet = [=[sniffs at %s.
is happy to see %s.]=],
		someoneAtYou = "sniffs at %s.",
		someoneNoTarget = "sniffs at %s.",
		youAtPet = "is happy to see its master.",
		youAtTarget = "sniffs at %t.",
	},
	EMOTE_STARE = {
		someoneAtPet = [=[stares back.  Staring contest, yay!
slowly backs off.]=],
	},
	EMOTE_WAVE = {
		someoneAtPet = "looks questioningly.",
		youAtPet = "looks questioningly.",
	},
	EVENT_PET_LOWHEALTH = {
		emotes = "",
	},
	EVENT_PLAYER_LOWHEALTH = {
		emotes = [=[tries to taunt the enemy.  Rwarrr!
tries to save its master.  Rwarrr!]=],
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

["Default (m)"] = {
	INHERIT = "Default",
	
	EMOTE_GREET = {
		youAtPet = "is happy to see his master.",
	},
},

["Default (f)"] = {
	INHERIT = "Default",
	
	EMOTE_GREET = {
		youAtPet = "is happy to see her master.",
	},
},

["Beast (cute)"] = {
	INHERIT = "Default",
	
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

["Beast (cute, m)"] = {
	INHERIT = "Beast (cute)",
},

["Beast (cute, f)"] = {
	INHERIT = "Beast (cute)",
},

["Beast (ferocious)"] = {
	INHERIT = "Default",
	
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
		emotes = [=[roars fiercely because of its master's pain!
goes into a frenzy because of its master's pain!]=],
	},
	EVENT_TARGET_LOWHEALTH = {
		emotes = [=[scents the close death of its prey and roars fiercely.
goes into a murderous frenzy because of all the blood that sheds from the wounds of its prey.]=],
	},
},

["Beast (ferocious, m)"] = {
	INHERIT = "Beast (ferocious)",
},

["Beast (ferocious, f)"] = {
	INHERIT = "Beast (ferocious)",
},

}

-- creature type -> personality
MylunesChampions.PCT["enUS"] = {
	Bat = "Default",
	Bear = "Beast (ferocious)",
	Beast = "Beast (ferocious)",
	Beetle = "Default",
	["Bird of Prey"] = "Default",
	Boar = "Beast (ferocious)",
	["Carrion Bird"] = "Default",
	Cat = "Beast (ferocious)",
	Chimaera = "Default",
	["Core Hound"] = "Beast (ferocious)",
	Crab = "Default",
	Critter = "Default",
	Crocolisk = "Beast (ferocious)",
	Demon = "Default",
	Devilsaur = "Beast (ferocious)",
	Dog = "Beast (ferocious)",
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
	Gorilla = "Beast (ferocious)",
	Humanoid = "Default",
	Hyena = "Default",
	Imp = "Default",
	Mechanical = "Default",
	Monkey = "Default",
	Moth = "Default",
	["Nether Ray"] = "Default",
	Raptor = "Beast (ferocious)",
	Ravager = "Default",
	["Remote Control"] = "Default",
	Rhino = "Beast (ferocious)",
	Scorpid = "Default",
	Serpent = "Default",
	["Shale Spider"] = "Default",
	Silithid = "Default",
	Spider = "Default",
	["Spirit Beast"] = "Beast (ferocious)",
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
	Wolf = "Beast (ferocious)",
	Worm = "Default",
}
