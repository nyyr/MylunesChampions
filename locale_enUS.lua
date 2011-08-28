local L = LibStub("AceLocale-3.0"):NewLocale("MylunesChampions", "enUS", true)
if not L then return end

L["DISABLED"] = "Disabled."
L["ENABLED"] = "Enabled."
L["LOADED"] = "Loaded."
L["NO_COMPANION"] = "You do not have an active companion."
L["NO_PET"] = "You do not have an active pet."
L["UNSUPPORTED_LOCALE"] = "Mylune is afraid, but your client locale is not supported :( Using 'enUS' as default."
L["SETTING_EMOTE_LOCALE"] = "Setting emote locale to '%s'."
L["EMOTE_NOT_FOUND"] = "Emote %s not found for current emote locale (end your own emotes with a punctuation!)."

L["PERSONALITY_LOOP"] = "Personality loop detected: %s."

L["Version"] = true
L["Authors"] = true

L["CFG_TITLE"] = "Mylune's Champions - Options"
L["CFG_GENERAL"] = "General"
L["CFG_EMOTES"] = "Emotes"
L["CFG_PERSONALITIES"] = "Personalities"

L["CFG_ENABLE"] = "Enable"
L["CFG_ENABLE_TT"] = "Toggle to enable/disable Mylune's Champions."
L["CFG_EMOTE_LOCALE"] = "Emote Locale"
L["CFG_EMOTE_LOCALE_TT"] = "Set emote locale (defaults to client locale or enUS)."

L["CFG_PERS_NEW"] = "New"
L["CFG_PERS_NEW_TT"] = "Create a new personality."
L["CFG_PERS_DELETE"] = "Delete"
L["CFG_PERS_DELETE_TT"] = "Delete a personality. Predefined personalities cannot be deleted."
L["CFG_PERS_NAME"] = "Name"
L["CFG_PERS_NAME_TT"] = "Name of personality."
L["CFG_PERS_BASE"] = "Base personality"
L["CFG_PERS_BASE_TT"] = "Inherit emotes from another personality."
L["CFG_PERS_BASE_NONE"] = "None"

L["CFG_PERS_EMOTE_TT"] = "Emotes for this event. Each emote must begin with a new line (line break). You can use the following placeholders:\n"..
	"%t: Name of your target or target of emote.\n"..
	"%s: Name of player who sends the original emote ('someone').\n"..
	"To reset this emote to its inherited value, just erase this field. "..
	"To override any inherited emotes without giving other emotes, enter the letters 'NA' (without quotes)."
L["CFG_PERS_EMOTE_SOMEONEATPET"] = "Someone at your pet/companion"
L["CFG_PERS_EMOTE_SOMEONEATYOU"] = "Someone at you"
L["CFG_PERS_EMOTE_SOMEONENOTARGET"] = "Someone without a target"
L["CFG_PERS_EMOTE_YOUATPET"] = "You at your pet/companion"
L["CFG_PERS_EMOTE_YOUATTARGET"] = "You at target"
L["CFG_PERS_EMOTE_YOUNOTARGET"] = "You without a target"

L["CFG_PERS_EVENT_EMOTES"] = "Emotes"

L["CFG_PETS"] = "Combat Pets"
L["CFG_COMPANIONS"] = "Companions"
L["CFG_COMPANION_PERS"] = "Personality"
L["CFG_COMPANION_PERS_TT"] = "Personality to use for this companion/pet."

L["CFG_PETS_ADD"] = "Add current pet"
L["CFG_PETS_ADD_TT"] = "Add current pet"
L["CFG_PETS_REMOVE"] = "Remove selected pet"
L["CFG_PETS_REMOVE_TT"] = "Remove selected pet"

L.EMOTE_BYE = {
	pattern_someoneAtTarget = "%s waves goodbye to %t.  Farewell!",
	pattern_someoneAtYou = "%s waves goodbye to you.  Farewell!",
	pattern_someoneNoTarget = "%s waves goodbye.  Farewell!",
}
L.EMOTE_CHEER = {
	pattern_someoneAtTarget = "%s cheers at %t!",
	pattern_someoneAtYou = "%s cheers at you!",
	pattern_someoneNoTarget = "%s cheers.",
}
L.EMOTE_GREET = {
	pattern_someoneAtTarget = "%s greets %t with a hearty hello!",
	pattern_someoneAtYou = "%s greets you with a hearty hello!",
	pattern_someoneNoTarget = "%s greets everyone warmly.",
}
L.EMOTE_STARE = {
	pattern_someoneAtTarget = "%s stares %t down.",
	pattern_someoneAtYou = "%s stares you down.",
	pattern_someoneNoTarget = "%s stares off into the distance.",
}
L.EMOTE_WAVE = {
	pattern_someoneAtTarget = "%s waves at %t.",
	pattern_someoneAtYou = "%s waves at you.",
	pattern_someoneNoTarget = "%s waves.",
}

