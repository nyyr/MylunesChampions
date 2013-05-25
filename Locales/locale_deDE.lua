local L = LibStub("AceLocale-3.0"):NewLocale("MylunesChampions", "deDE")
if not L then return end

L["DISABLED"] = "Deaktiviert."
L["ENABLED"] = "Aktiviert."
L["LOADED"] = "Geladen."
L["NO_COMPANION"] = "Ihr habt kein aktives Haustier."
L["NO_MOUNT"] = "Ihr habt kein aktives Reittier."
L["NO_PET"] = "Ihr habt keinen aktiven Begleiter."
L["UNSUPPORTED_LOCALE"] = "Mylune tut es schrecklich Leid, aber Eure Sprache wird nicht unterstützt :( Benutze 'enUS' als Voreinstellung."
L["SETTING_EMOTE_LOCALE"] = "Setze Emote-Sprache auf '%s'."
L["EMOTE_NOT_FOUND"] = "Das Emote %s wurde für die aktuelle Spracheinstellung nicht gefunden. Benutzt Satzzeichen für Eure eigenen Emotes!"

L["PERSONALITY_LOOP"] = "Persönlichkeitsschleife entdeckt: %s."
L["USEEMOTE_LOOP"] = "Emote-Schleife entdeckt: %s zeigt ebenfalls auf ein anderes Emote (%s)."

L["Version"] = true
L["Authors"] = "Autoren"

L["CFG_TITLE"] = "Mylunes Champions - Optionen"
L["CFG_GENERAL"] = "Allgemein"
L["CFG_EMOTES"] = "Emotes"
L["CFG_PERSONALITIES"] = "Persönlichkeiten"

L["CFG_ENABLE"] = "Aktiviert"
L["CFG_ENABLE_TT"] = "Umschalten, um Mylunes Champions zu aktivieren/deaktivieren."
L["CFG_EMOTE_LOCALE"] = "Emote-Sprache"
L["CFG_EMOTE_LOCALE_TT"] = "Ändert Emote-Sprache (Voreinstellung: Spielsprache oder enUS)."
L["CFG_AUTOEMOTEBACKOFF"] = "Auto-Emote Abstand"
L["CFG_AUTOEMOTEBACKOFF_TT"] = "Setzt 'Cooldown' von Auto-Emotes (Emotes, die von Events ausgelöst werden)."
L["CFG_RANDOMEMOTEBACKOFF"] = "Zufalls-Emote Abstand"
L["CFG_RANDOMEMOTEBACKOFF_TT"] = "Setzt den 'Cooldown' von zufälligen Emotes."

L["CFG_CHATCOMMANDS_HEADER"] = "Chat-Befehle"
L["CFG_CHATCOMMANDS"] = "/ce - Zufälliges Haustier-Emote (Companion-Emote)\n"..
	"/ce [Emote-Name] - Standard-Emote Eures Haustiers, z.B. '/ce cheer' (nur wenige werden bisher unterstützt).\n"..
	"/ce [Emote-Text] - Einmaliges Emote, z.B. '/ce springt ungeduldig auf und ab.'\n"..
	"\nEmotes für Eure Reittiere (/mte - Mount-Emote) und großen Begleiter (/pe - Pet-Emote) könnt Ihr entsprechend auslösen."

L["CFG_PERS_NEW"] = "Neu"
L["CFG_PERS_NEW_TT"] = "Erstellt eine neue Persönlichkeit."
L["CFG_PERS_IMPORT_CHINCHILLA"] = "Importiere Chinchilla"
L["CFG_PERS_IMPORT_CHINCHILLA_TT"] = "Importiert Emotes von Chinchilla Critter Emote. Das Addon muss installiert und aktiviert sein. Funktioniert nur für 'enUS'."
L["CFG_PERS_IMPORT_CHINCHILLA_WRONG_LOCALE"] = "Die aktuelle Sprache wird von Chinchilla Critter Emote nicht unterstützt."
L["CFG_PERS_IMPORT_CHINCHILLA_INACTIVE"] = "Das Addon Chinchilla Critter Emote ist nicht installiert oder nicht aktiv."
L["CFG_PERS_DELETE"] = "Löschen"
L["CFG_PERS_DELETE_TT"] = "Löscht diese Persönlichkeit. Mitgelieferte Persönlichkeiten können nicht gelöscht werden."
L["CFG_PERS_EXISTS"] = "Persönlichkeit mit diesem Namen existiert bereits."
L["CFG_PERS_CANNOT_RENAME"] = "Diese Persönlichkeit kann nicht umbenannt werden."
L["CFG_PERS_CANNOT_DELETE"] = "Diese Persönlichkeit kann nicht gelöscht werden."
L["CFG_PERS_NAME"] = "Bezeichnung"
L["CFG_PERS_NAME_TT"] = "Bezeichnung der Persönlichkeit."
L["CFG_PERS_BASE"] = "Basis-Persönlichkeit"
L["CFG_PERS_BASE_TT"] = "Erbt die Emotes einer anderen Persönlichkeit."
L["CFG_PERS_BASE_NONE"] = "Keine"

L["CFG_PERS_EMOTE"] = "Emote"
L["CFG_PERS_USEEMOTE"] = "Benutze Text eines anderen Emote"
L["CFG_PERS_USEEMOTE_TT"] = "Falls ein anderes Emote ausgewählt ist, wird der hier eingegebene Text ignoriert."
L["CFG_PERS_EMOTE_TT"] = "Emotes für dieses Ereignis. Jedes Emote muss in einer neuen Zeile beginnen. Ihr könnt die folgenden Platzhalter verwenden:\n"..
	"%t: Name Eures Ziels oder des Emote-Ziels.\n"..
	"%s: Name des Spielers, der das ursprüngliche Emote ausgelöst hat.\n"..
	"Um das Emote auf seinen vererbten Wert zurückzusetzen, löscht einfach dieses Feld. "..
	"Um die vererbten Emotes zu überschreiben ohne ein anderes anzugeben, gebt die Buchstaben 'NA' (ohne Anführungszeichen) ein."
L["CFG_PERS_EMOTE_SOMEONEATPET"] = "Jemand (inkl. Euch) zu Eurem Begleiter/Haustier"
L["CFG_PERS_EMOTE_SOMEONEATYOU"] = "Jemand zu Euch"
L["CFG_PERS_EMOTE_YOUATPET"] = "Ihr zu Eurem Begleiter/Haustier"
L["CFG_PERS_EMOTE_YOUATTARGET"] = "Ihr zu Eurem Ziel"
L["CFG_PERS_EMOTE_YOUNOTARGET"] = "Ihr ohne Ziel"

L["CFG_PERS_EMOTE_DEFAULT"] = "Standard"
L["CFG_PERS_EMOTE_MALE"] = "Männliche Begleiter"
L["CFG_PERS_EMOTE_FEMALE"] = "Weibliche Begleiter"
L["CFG_PERS_EMOTE_MALE_MISTRESS"] = "Männliche Begleiter mit Frauchen"
L["CFG_PERS_EMOTE_FEMALE_MISTRESS"] = "Weibliche Begleiter mit Frauchen"
L["CFG_PERS_EMOTE_GENDERDESC"] = "Hinweis: Dieser Bereich kann leer gelassen werden, wenn geschlechtsspezifische Emotes nicht notwendig sind."

L["CFG_PERS_EVENT"] = "Event"
L["CFG_PERS_EVENT_EMOTES"] = "Emotes"

L["CFG_PERS_RANDOM_EMOTES_DEFAULT"] = "Standard"
L["CFG_PERS_RANDOM_EMOTES_AFK"] = "Wenn Spieler 'AFK' ist"
L["CFG_PERS_RANDOM_EMOTES_INCOMBAT"] = "Wenn Spieler im Kampf ist"

L["CFG_PETS"] = "Begleiter"
L["CFG_MOUNTS"] = "Reittiere"
L["CFG_COMPANIONS"] = "Haustiere"
L["CFG_COMPANION_PERS"] = "Persönlichkeit"
L["CFG_COMPANION_PERS_TT"] = "Persönlichkeit, die für dieses Haustier/diesen Begleiter verwendet werden soll."
L["CFG_COMPANION_SEX"] = "Geschlecht"
L["CFG_COMPANION_SEX_TT"] = "Geschlecht des Begleiters."
L["CFG_COMPANION_SEX_N"] = "sächlich/unbekannt"
L["CFG_COMPANION_SEX_M"] = "männlich"
L["CFG_COMPANION_SEX_F"] = "weiblich"

L["CFG_PETS_ADD"] = "Aktiven Begleiter hinzufügen"
L["CFG_PETS_ADD_TT"] = "Aktiven Begleiter hinzufügen"
L["CFG_PETS_REMOVE"] = "Diesen Begleiter entfernen"
L["CFG_PETS_REMOVE_TT"] = "Diesen Begleiter entfernen"
L["CFG_PETS_ADDED"] = "%s hinzugefügt."
L["CFG_PETS_REMOVED"] = "%s entfernt."

L["CFG_ENTRY_EXISTS"] = "Ein Eintrag mit diesem Namen existiert bereits."

L.EMOTE_BYE = {
	pattern_someoneAtTarget = "%s winkt %t zum Abschied. Lebt wohl!",
	pattern_someoneAtYou = "%s winkt Euch zum Abschied. Lebt wohl!",
	pattern_someoneNoTarget = "%s winkt allen zum Abschied. Lebt wohl!",
}
L.EMOTE_CHEER = {
	pattern_someoneAtTarget = "%s bejubelt %t",
	pattern_someoneAtYou = "%s bejubelt Euch.",
	pattern_someoneNoTarget = "%s jubelt!",
}
L.EMOTE_GREET = {
	pattern_someoneAtTarget = "%s begrüßt %t mit einem herzlichen Hallo!",
	pattern_someoneAtYou = "%s begrüßt Euch herzlich.",
	pattern_someoneNoTarget = "%s begrüßt alle herzlich.",
}
L.EMOTE_STARE = {
	pattern_someoneAtTarget = "%s starrt %t an.",
	pattern_someoneAtYou = "%s starrt Euch an.",
	pattern_someoneNoTarget = "%s starrt in die Ferne.",
}
L.EMOTE_WAVE = {
	pattern_someoneAtTarget = "%s winkt %t zu.",
	pattern_someoneAtYou = "%s winkt Euch zu.",
	pattern_someoneNoTarget = "%s winkt.",
}
