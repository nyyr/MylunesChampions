MylunesChampions.P["deDE"] = {

["Default"] = {
	INHERIT = "None",
	
	EMOTE_BYE = {
		someoneAtPet = "ist traurig, dass %s geht.",
		someoneAtYou = "ist traurig, dass %s geht.",
		someoneNoTarget = "ist traurig, dass %s geht.",
		youAtPet = "ist traurig.",
		youAtTarget = "ist traurig, dass %t geht.",
		youNoTarget = "ist traurig.",
	},
	EMOTE_CHEER = {
		someoneAtPet = [=[quiekt vor Freude.
schaut fragend.]=],
		youAtTarget = "ist voller Aufregung wegen %t.",
		youNoTarget = "ist aufgeregt.",
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
		someoneAtPet = [=[quiekt vor Freude.
schaut fragend.]=],
		someoneAtYou = "schaut %s aufgeregt an.",
		someoneNoTarget = "",
		youAtPet = [=[quiekt vor Freude.
schaut fragend.]=],
		youAtTarget = "schaut %t aufgeregt an.",
		youNoTarget = "ist aufgeregt.",
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

["Default (pet)"] = {
	INHERIT = "Default",
	
	EVENT_PET_LOWHEALTH = {
		emotes = "brüllt vor Schmerz.",
	},
	EVENT_PLAYER_LOWHEALTH = {
		emotes = [=[brüllt fürchterlich ob der Schmerzen seines Meisters!
gerät in einen Blutrausch wegen der Schmerzen seines Meisters!]=],
	},
	EVENT_TARGET_LOWHEALTH = {
		emotes = [=[wittert den nahen Tod seiner Beute und brüllt fürchterregend.
gerät in einen tödlichen Rausch wegen des ganzen Blutes, das aus den Wunden seiner Beute rinnt.]=],
	},
},

}
