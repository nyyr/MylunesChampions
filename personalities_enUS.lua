MylunesChampions.P["enUS"] = {

["Default"] = {
	INHERIT = "None",
	
	EMOTE_BYE = {
		someoneAtPet = "is sad that %s leaves.",
		someoneAtYou = "is sad that %t leaves.",
		someoneNoTarget = "is sad that %s leaves.",
		youAtPet = "is sad.",
		youAtTarget = "is sad that %t leaves.",
		youNoTarget = "is sad.",
	},
	EMOTE_CHEER = {
		someoneAtPet = [=[is excited and squeaks.
looks questioningly.]=],
		youAtTarget = "is excited about %t.",
		youNoTarget = "is excited.",
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
		someoneAtPet = [=[is excited and squeaks.
looks questioningly.]=],
		someoneAtYou = "is excited about %s.",
		someoneNoTarget = "",
		youAtPet = [=[is excited and squeaks.
looks questioningly.]=],
		youAtTarget = "is excited about %t.",
		youNoTarget = "is excited.",
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
},

["Default (pet)"] = {
	INHERIT = "Default",
	
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

}
