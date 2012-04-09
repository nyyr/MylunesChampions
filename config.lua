
-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("MylunesChampions", true)
local LG = {} -- general

-- Ace config libs
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

-- Debugging levels
--   1 Warning
--   2 Info
--   3 Notice
--   4 Off
local debugLevels = {"warn", "info", "notice", "off"}
local d_warn = 1
local d_info = 2
local d_notice = 3

MylunesChampions.PersTable = { L["CFG_PERS_BASE_NONE"] }
local EmoteTable = { }
local EmoteIndex = 2
local CurrentEmote = ""
local EventTable = { }
local EventIndex = 1
local CurrentEvent = ""

local EmoteTable = {
	[1] = "(select)",
	[2] = "BYE",
	[3] = "CHEER",
	[4] = "CRY",
	[5] = "DANCE",
	[6] = "GREET",
	[7] = "HUG",
	[8] = "KISS",
	[9] = "TRAIN",
	[10] = "WAVE",
	[11] = "WELCOME",
	
	[100] = "--",
	
	[101] = "AGREE",
	[102] = "AMAZE",
	[103] = "ANGRY",
	[104] = "APOLOGIZE",
	[105] = "APPLAUD",
	
	[111] = "BARK",
	[112] = "BECKON",
	[113] = "BEG",
	[114] = "BURP",
	[115] = "BITE",
	[116] = "BLINK",
	[117] = "BLEED",
	[118] = "BORED",
	[119] = "BOW",
	
	[131] = "CHICKEN",
	[132] = "CHUCKLE",
	[133] = "CLAP",
	[134] = "COLD",
	[135] = "CONFUSED",
	[136] = "CONGRATULATE",
	[137] = "COUGH",
	[138] = "COWER",
	[139] = "CUDDLE",
	[140] = "CURIOUS",
	[141] = "CURTSEY",
	
	[150] = "DRINK",
	[151] = "EAT",
	[152] = "FLEE",
	[153] = "FOLLOW",
	[154] = "GOLFCLAP",
	[155] = "GRIN",
	[156] = "HUNGRY",
	[157] = "INSULT",
	
	[171] = "SCRATCH",
	[172] = "STARE",
	[173] = "TIRED",
	[174] = "THANK",
	[175] = "VICTORY",
	[176] = "YAWN",
}

local function MylunesChampions_TableFind(t, s)
	for i,n in ipairs(t) do
		if n == s then
			return i
		end
	end
	return nil
end

local function MylunesChampions_TableFindPairs(t, s)
	for i,n in pairs(t) do
		if n == s then
			return i
		end
	end
	return nil
end

local function MylunesChampions_RawGetter(info)
	local s = MylunesChampions:GetRawEmotes(info[#info-2], info[#info-1], info[#info])
	if s then
		return s
	else
		return "NA"
	end
end

local function MylunesChampions_RawSetter(info, v)
	s = strtrim(v)
	if s == "" then	
		s = nil -- erase
	elseif s == "NA" then
		s = "" -- override with empty value (N/A)
	end
	MylunesChampions:SetRawEmotes(info[#info-2], info[#info-1], info[#info], s)
end

local function MylunesChampions_RawEmoteGetter(info)
	local s = MylunesChampions:GetRawEmotes(info[#info-2], CurrentEmote, info[#info])
	if s then
		return s
	else
		return "NA"
	end
end

local function MylunesChampions_RawEmoteSetter(info, v)
	s = strtrim(v)
	if s == "" then	
		s = nil -- erase
	elseif s == "NA" then
		s = "" -- override with empty value (N/A)
	end
	MylunesChampions:SetRawEmotes(info[#info-2], CurrentEmote, info[#info], s)
end

local function MylunesChampions_RawEventGetter(info)
	local s = MylunesChampions:GetRawEmotes(info[#info-2], CurrentEvent, info[#info])
	if s then
		return s
	else
		return "NA"
	end
end

local function MylunesChampions_RawEventSetter(info, v)
	s = strtrim(v)
	if s == "" then	
		s = nil -- erase
	elseif s == "NA" then
		s = "" -- override with empty value (N/A)
	end
	MylunesChampions:SetRawEmotes(info[#info-2], CurrentEvent, info[#info], s)
end

----------------------------------------------
-- Core options
----------------------------------------------
MylunesChampions.configOptionsTableCore = {
	type = "group",
	name = L["CFG_TITLE"],
	args = {
		info1 = {
			type		= "description",
			name		= L["Version"].." "..MylunesChampions.version..": \""..MylunesChampions.codename.."\"",
			order		= 0,
		},
		info2 = {
			type		= "description",
			name		= L["Authors"]..": "..MylunesChampions.authors,
			order		= 1,
		},
		header = {
			type		= "header",
			name		= L["CFG_GENERAL"],
			order		= 2,
		},
		-- Enable
		enable = {
			type		= "toggle",
			name		= L["CFG_ENABLE"],
			desc		= L["CFG_ENABLE_TT"],
			order		= 10,
			get			= function ()
				return MylunesChampions.db.profile.enable
			end,
			set			= function (info, v)
				MylunesChampions.db.profile.enable = v
				MylunesChampions:OnConfigUpdate()
			end,
		},
		-- Emote locale
		emoteLocale = {
			type		= "select",
			name		= L["CFG_EMOTE_LOCALE"],
			desc		= L["CFG_EMOTE_LOCALE_TT"],
			values		= MylunesChampions.emoteLocales,
			order		= 11,
			get			= function ()
				return MylunesChampions_TableFind(MylunesChampions.emoteLocales,
					MylunesChampions.db.profile.emoteLocale)
			end,
			set			= function (info, v)
				MylunesChampions.db.profile.emoteLocale = MylunesChampions.emoteLocales[v]
				MylunesChampions.LP = MylunesChampions.db.profile.P[MylunesChampions.db.profile.emoteLocale]
				MylunesChampions:Printf(L["SETTING_EMOTE_LOCALE"], MylunesChampions.db.profile.emoteLocale)
				MylunesChampions:OnConfigUpdate()
				MylunesChampions:RebuildConfig()
				AceConfigRegistry:NotifyChange("MylunesChampions_Personalities")
			end,
		},
		autoEmoteBackoff = {
			type		= "range",
			name		= L["CFG_AUTOEMOTEBACKOFF"],
			desc		= L["CFG_AUTOEMOTEBACKOFF_TT"],
			min			= 60,
			max			= 600,
			step		= 10,
			order		= 21,
			get			= function ()
				return MylunesChampions.db.profile.autoEmoteBackoff
			end,
			set			= function (info, v)
				MylunesChampions.db.profile.autoEmoteBackoff = v
			end,
		},
		randomEmoteBackoff = {
			type		= "range",
			name		= L["CFG_RANDOMEMOTEBACKOFF"],
			desc		= L["CFG_RANDOMEMOTEBACKOFF_TT"],
			min			= 60,
			max			= 600,
			step		= 10,
			order		= 22,
			get			= function ()
				return MylunesChampions.db.profile.randomEmoteBackoff
			end,
			set			= function (info, v)
				MylunesChampions.db.profile.randomEmoteBackoff = v
				MylunesChampions:CancelTimer(MylunesChampions.randomEmoteTimer, true)
				-- yes, autoEmoteBackoff, not randomEmoteBackoff
				MylunesChampions.randomEmoteTimer = 
					MylunesChampions:ScheduleRepeatingTimer("OnRandomEmote", MylunesChampions.db.profile.autoEmoteBackoff)
			end,
		},
		headerChatCommands = {
			type		= "header",
			name		= L["CFG_CHATCOMMANDS_HEADER"],
			order		= 101,
		},
		chatCommands = {
			type		= "description",
			name		= L["CFG_CHATCOMMANDS"],
			order		= 102,
		},
	},
}

----------------------------------------------
-- Personalities options
----------------------------------------------
MylunesChampions.configOptionsTablePersonalities = {
	type = "group",
	name = L["CFG_PERSONALITIES"],
	args = {},
}

local configOptionsTablePersonalitiesButtons = {
	new = {
		type 	= "execute",
		name 	= L["CFG_PERS_NEW"],
		desc	= L["CFG_PERS_NEW_TT"],
		order	= 1,
		func	= function ()
			local p = MylunesChampions.LP
			if p["<new>"] then
				MylunesChampions:Printf(L["CFG_PERS_EXISTS"])
			else
				p["<new>"] = { INHERIT = nil }
				MylunesChampions:RebuildConfig()
				AceConfigRegistry:NotifyChange("MylunesChampions_Personalities")
			end
		end,
	},
	importChinchillaCritterEmote = {
		type 	= "execute",
		name 	= L["CFG_PERS_IMPORT_CHINCHILLA"],
		desc	= L["CFG_PERS_IMPORT_CHINCHILLA_TT"],
		order	= 2,
		func	= function ()
			if (MylunesChampions.db.profile.emoteLocale == "enUS") then
				MylunesChampions:ImportChinchillaCritterEmote()
				MylunesChampions:RebuildConfig()
				AceConfigRegistry:NotifyChange("MylunesChampions_Personalities")
			else
				MylunesChampions:Printf(L["CFG_PERS_IMPORT_CHINCHILLA_WRONG_LOCALE"])
			end
		end,
	},
}

local configOptionsPersonalityTemplate = {
	type		= "group",
	name		= "<new>",
	order		= 10,
	args		= {
		delete = {
			type 	= "execute",
			name 	= L["CFG_PERS_DELETE"],
			desc	= L["CFG_PERS_DELETE_TT"],
			order	= 0,
			func	= function (info)
				if MylunesChampions.defaults.profile.P[MylunesChampions.db.profile.emoteLocale][info[#info-1]] then
					MylunesChampions:Printf(L["CFG_PERS_CANNOT_DELETE"])
				else
					MylunesChampions.LP[info[#info-1]] = nil
					MylunesChampions:RebuildConfig()
					AceConfigRegistry:NotifyChange("MylunesChampions_Personalities")
				end
			end,
		},
		authors = {
			type	= "description",
			name	= L["Authors"]..": N/A",
			order	= 1,
		},
		name = {
			type	= "input",
			name	= L["CFG_PERS_NAME"],
			desc	= L["CFG_PERS_NAME_TT"],
			order	= 2,
			get		= function (info)
				return info[#info-1]
			end,
			set		= function (info, v)
				if not (v == info[#info-1]) then
					if MylunesChampions.defaults.profile.P[MylunesChampions.db.profile.emoteLocale][info[#info-1]] then
						MylunesChampions:Printf(L["CFG_PERS_CANNOT_RENAME"])
					else
						local p = MylunesChampions.LP
						if p[v] == nil then
							p[v] = p[info[#info-1]]
							p[info[#info-1]] = nil
							MylunesChampions:RebuildConfig()
							AceConfigRegistry:NotifyChange("MylunesChampions_Personalities")
						else
							MylunesChampions:Printf(L["CFG_PERS_EXISTS"])
						end
					end
				end
			end,
		},
		base = {
			type	= "select",
			name	= L["CFG_PERS_BASE"],
			desc	= L["CFG_PERS_BASE_TT"],
			values	= { L["CFG_PERS_BASE_NONE"] },
			order	= 3,
			get		= function (info)
				local i = MylunesChampions_TableFind(MylunesChampions.PersTable, 
					MylunesChampions.LP[info[#info-1]]["INHERIT"])
				if not i then
					return 1
				else
					return i
				end
			end,
			set		= function (info, v)
				local p = MylunesChampions.LP
				if v > 1 then
					if not (p[MylunesChampions.PersTable[v]]) then
						MylunesChampions:Printf("ERR: Personality "..MylunesChampions.PersTable[v].." not found.")
					else
						p[info[#info-1]]["INHERIT"] = MylunesChampions.PersTable[v]
					end
				else
					p[info[#info-1]]["INHERIT"] = nil
				end
			end,
		},
	},
}	

----------------------------------------------
-- Emote options
----------------------------------------------
local configOptionsEmoteTemplate = {
	type		= "group",
	name		= "Emote Template",
	order		= 10,
	args		= {
		emote = {
			type	= "select",
			name	= L["CFG_PERS_EMOTE"],
			desc	= L["CFG_PERS_EMOTE"],
			values	= EmoteTable,
			order	= 1,
			get		= function (info)
				return EmoteIndex
			end,
			set		= function (info, v)
				if not ((v == 100) or (v == 1)) then -- (select) and separator
					EmoteIndex = v
					CurrentEmote = "EMOTE_"..EmoteTable[EmoteIndex]
				end
			end,
		},
		useEmote = {
			type	= "select",
			name	= L["CFG_PERS_USEEMOTE"],
			desc	= L["CFG_PERS_USEEMOTE_TT"],
			values	= EmoteTable,
			order	= 2,
			get		= function (info)
				local s = MylunesChampions:GetRawEmotes(info[#info-2], CurrentEmote, info[#info])
				if s and not (s == "") then
					local i = MylunesChampions_TableFindPairs(EmoteTable, s)
					if i then
						return i
					end
				end
				return 1
			end,
			set		= function (info, v)
				if not (v == 100) then -- separator
					if v == 1 then
						MylunesChampions:SetRawEmotes(info[#info-2], CurrentEmote, info[#info], nil)
					else
						MylunesChampions:SetRawEmotes(info[#info-2], CurrentEmote, info[#info], EmoteTable[v])
					end
				end
			end,
		},
		header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_DEFAULT"],
			order		= 10,
		},
		someoneAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 12,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		someoneAtYou = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATYOU"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 13,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		youAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 14,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		youAtTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 15,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		youNoTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUNOTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 16,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		m_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_MALE"],
			order		= 20,
		},
		m_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 21,
		},
		m_someoneAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 22,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		m_someoneAtYou = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATYOU"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 23,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		m_youAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 24,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		m_youAtTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 25,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		m_youNoTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUNOTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 26,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		f_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_FEMALE"],
			order		= 30,
		},
		f_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 31,
		},
		f_someoneAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 32,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		f_someoneAtYou = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATYOU"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 33,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		f_youAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 34,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		f_youAtTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 35,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		f_youNoTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUNOTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 36,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		mm_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_MALE_MISTRESS"],
			order		= 40,
		},
		mm_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 41,
		},
		mm_someoneAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 42,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		mm_someoneAtYou = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATYOU"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 43,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		mm_youAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 44,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		mm_youAtTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 45,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		mm_youNoTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUNOTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 46,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		fm_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_FEMALE_MISTRESS"],
			order		= 50,
		},
		fm_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 51,
		},
		fm_someoneAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 52,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		fm_someoneAtYou = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_SOMEONEATYOU"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 53,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		fm_youAtPet = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATPET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 54,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		fm_youAtTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUATTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 55,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
		fm_youNoTarget = {
			type		= "input",
			name		= L["CFG_PERS_EMOTE_YOUNOTARGET"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 56,
			get			= MylunesChampions_RawEmoteGetter,
			set			= MylunesChampions_RawEmoteSetter,
		},
	},
}

----------------------------------------------
-- Event options
----------------------------------------------
local configOptionsEventTemplate = {
	type		= "group",
	name		= "Event Template",
	order		= 20,
	args		= {
		event = {
			type	= "select",
			name	= L["CFG_PERS_EVENT"],
			desc	= L["CFG_PERS_EVENT"],
			values	= EventTable,
			order	= 1,
			get		= function (info)
				return EventIndex
			end,
			set		= function (info, v)
				EventIndex = v
				CurrentEvent = EventTable[EventIndex]
			end,
		},
		header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_DEFAULT"],
			order		= 10,
		},
		emotes = {
			type		= "input",
			name		= L["CFG_PERS_EVENT_EMOTES"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 11,
			get			= MylunesChampions_RawEventGetter,
			set			= MylunesChampions_RawEventSetter,
		},
		m_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_MALE"],
			order		= 20,
		},
		m_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 21,
		},
		m_emotes = {
			type		= "input",
			name		= L["CFG_PERS_EVENT_EMOTES"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 22,
			get			= MylunesChampions_RawEventGetter,
			set			= MylunesChampions_RawEventSetter,
		},
		f_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_FEMALE"],
			order		= 30,
		},
		f_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 31,
		},
		f_emotes = {
			type		= "input",
			name		= L["CFG_PERS_EVENT_EMOTES"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 32,
			get			= MylunesChampions_RawEventGetter,
			set			= MylunesChampions_RawEventSetter,
		},
		mm_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_MALE_MISTRESS"],
			order		= 40,
		},
		mm_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 41,
		},
		mm_emotes = {
			type		= "input",
			name		= L["CFG_PERS_EVENT_EMOTES"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 42,
			get			= MylunesChampions_RawEventGetter,
			set			= MylunesChampions_RawEventSetter,
		},
		fm_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_FEMALE_MISTRESS"],
			order		= 50,
		},
		fm_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 51,
		},
		fm_emotes = {
			type		= "input",
			name		= L["CFG_PERS_EVENT_EMOTES"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 52,
			get			= MylunesChampions_RawEventGetter,
			set			= MylunesChampions_RawEventSetter,
		},
	},
}

----------------------------------------------
-- Random event options
----------------------------------------------
local configOptionsRandomTemplate = {
	type		= "group",
	name		= "Event Template",
	order		= 30,
	args		= {
		header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_DEFAULT"],
			order		= 0,
		},
		emotes = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_DEFAULT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 1,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		afk = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_AFK"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 2,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		incombat = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_INCOMBAT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 3,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		m_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_MALE"],
			order		= 10,
		},
		m_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 11,
		},
		m_emotes = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_DEFAULT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 12,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		m_afk = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_AFK"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 13,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		m_incombat = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_INCOMBAT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 14,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		f_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_FEMALE"],
			order		= 20,
		},
		f_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 21,
		},
		f_emotes = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_DEFAULT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 22,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		f_afk = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_AFK"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 23,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		f_incombat = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_INCOMBAT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 24,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		mm_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_MALE_MISTRESS"],
			order		= 30,
		},
		mm_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 31,
		},
		mm_emotes = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_DEFAULT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 32,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		mm_afk = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_AFK"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 33,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		mm_incombat = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_INCOMBAT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 34,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		fm_header = {
			type		= "header",
			name		= L["CFG_PERS_EMOTE_FEMALE_MISTRESS"],
			order		= 40,
		},
		fm_description = {
			type		= "description",
			name		= L["CFG_PERS_EMOTE_GENDERDESC"],
			order		= 41,
		},
		fm_emotes = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_DEFAULT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 42,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		fm_afk = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_AFK"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 43,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
		fm_incombat = {
			type		= "input",
			name		= L["CFG_PERS_RANDOM_EMOTES_INCOMBAT"],
			desc		= L["CFG_PERS_EMOTE_TT"],
			multiline	= true,
			order		= 44,
			get			= MylunesChampions_RawGetter,
			set			= MylunesChampions_RawSetter,
		},
	},
}

----------------------------------------------
-- Companions options
----------------------------------------------
MylunesChampions.configOptionsTableCompanions = {
	type = "group",
	name = L["CFG_COMPANIONS"],
	args = {},
}

local configOptionsCompanionTemplate = {
	type		= "group",
	name		= "Companion Template",
	order		= 20,
	args		= {
		name = {
			type	= "header",
			name	= "Companion name",
			order	= 1,
		},
		personality = {
			type	= "select",
			name	= L["CFG_COMPANION_PERS"],
			desc	= L["CFG_COMPANION_PERS_TT"],
			values	= { },
			order	= 2,
			get		= function (info)
				local i = MylunesChampions_TableFind(MylunesChampions.PersTable, 
					MylunesChampions.db.profile.C[tonumber(info[#info-1])].p)
				if not i then
					return 1
				else
					return i
				end
			end,
			set		= function (info, v)
				if v == 1 then
					MylunesChampions.db.profile.C[tonumber(info[#info-1])].p = ""
				else
					MylunesChampions.db.profile.C[tonumber(info[#info-1])].p = MylunesChampions.PersTable[v]
				end
			end,
		},
		sex = {
			type	= "select",
			name	= L["CFG_COMPANION_SEX"],
			desc	= L["CFG_COMPANION_SEX_TT"],
			values	= { L["CFG_COMPANION_SEX_N"], L["CFG_COMPANION_SEX_M"], L["CFG_COMPANION_SEX_F"] },
			order	= 3,
			get		= function (info)
				local s = MylunesChampions.db.profile.C[tonumber(info[#info-1])].s
				if (s == "m") then
					return 2
				elseif (s == "f") then
					return 3
				else
					return 1
				end
			end,
			set		= function (info, v)
				if v == 2 then
					MylunesChampions.db.profile.C[tonumber(info[#info-1])].s = "m"
				elseif v == 3 then
					MylunesChampions.db.profile.C[tonumber(info[#info-1])].s = "f"
				else
					MylunesChampions.db.profile.C[tonumber(info[#info-1])].s = nil
				end
			end,
		},
	}
}

----------------------------------------------
-- Mount options
----------------------------------------------
MylunesChampions.configOptionsTableMounts = {
	type = "group",
	name = L["CFG_MOUNTS"],
	args = {},
}

local configOptionsMountTemplate = {
	type		= "group",
	name		= "Mount Template",
	order		= 20,
	args		= {
		name = {
			type	= "header",
			name	= "Mount name",
			order	= 1,
		},
		personality = {
			type	= "select",
			name	= L["CFG_COMPANION_PERS"],
			desc	= L["CFG_COMPANION_PERS_TT"],
			values	= { },
			order	= 2,
			get		= function (info)
				local i = MylunesChampions_TableFind(MylunesChampions.PersTable, 
					MylunesChampions.db.profile.M[tonumber(info[#info-1])].p)
				if not i then
					return 1
				else
					return i
				end
			end,
			set		= function (info, v)
				if v == 1 then
					MylunesChampions.db.profile.M[tonumber(info[#info-1])].p = ""
				else
					MylunesChampions.db.profile.M[tonumber(info[#info-1])].p = MylunesChampions.PersTable[v]
				end
			end,
		},
		sex = {
			type	= "select",
			name	= L["CFG_COMPANION_SEX"],
			desc	= L["CFG_COMPANION_SEX_TT"],
			values	= { L["CFG_COMPANION_SEX_N"], L["CFG_COMPANION_SEX_M"], L["CFG_COMPANION_SEX_F"] },
			order	= 3,
			get		= function (info)
				local s = MylunesChampions.db.profile.M[tonumber(info[#info-1])].s
				if (s == "m") then
					return 2
				elseif (s == "f") then
					return 3
				else
					return 1
				end
			end,
			set		= function (info, v)
				if v == 2 then
					MylunesChampions.db.profile.M[tonumber(info[#info-1])].s = "m"
				elseif v == 3 then
					MylunesChampions.db.profile.M[tonumber(info[#info-1])].s = "f"
				else
					MylunesChampions.db.profile.M[tonumber(info[#info-1])].s = nil
				end
			end,
		},
	}
}

----------------------------------------------
-- Pets options
----------------------------------------------
MylunesChampions.configOptionsTablePets = {
	type = "group",
	name = L["CFG_PETS"],
	args = {},
}

local configOptionsTablePetsButtons = {
	addPet = {
		type 	= "execute",
		name 	= L["CFG_PETS_ADD"],
		desc	= L["CFG_PETS_ADD_TT"],
		order	= 1,
		func	= function ()
			local pet = MylunesChampions:GetCurrentPet()
			if pet then
				local pct = MylunesChampions.db.profile.PCT[MylunesChampions.db.profile.emoteLocale]
				if pct[pet] then
					MylunesChampions:Printf(L["CFG_ENTRY_EXISTS"])
				else
					pct[pet] = { p = "Default" }
					MylunesChampions:RebuildConfig()
					MylunesChampions:Printf(L["CFG_PETS_ADDED"], pet)
				end
			else
				MylunesChampions:Printf(L["NO_PET"])
			end
		end,
	},
}

local configOptionsPetTemplate = {
	type		= "group",
	name		= "Pet Template",
	order		= 20,
	args		= {
		name = {
			type	= "header",
			name	= "Pet name",
			order	= 1,
		},
		personality = {
			type	= "select",
			name	= L["CFG_COMPANION_PERS"],
			desc	= L["CFG_COMPANION_PERS_TT"],
			values	= { },
			order	= 2,
			get		= function (info)
				local i = MylunesChampions_TableFind(MylunesChampions.PersTable, 
					MylunesChampions.db.profile.PCT[MylunesChampions.db.profile.emoteLocale][info[#info-1]].p)
				if not i then
					return 1
				else
					return i
				end
			end,
			set		= function (info, v)
				if v == 1 then
					MylunesChampions.db.profile.PCT[MylunesChampions.db.profile.emoteLocale][info[#info-1]].p = ""
				else
					MylunesChampions.db.profile.PCT[MylunesChampions.db.profile.emoteLocale][info[#info-1]].p = MylunesChampions.PersTable[v]
				end
			end,
		},
		sex = {
			type	= "select",
			name	= L["CFG_COMPANION_SEX"],
			desc	= L["CFG_COMPANION_SEX_TT"],
			values	= { L["CFG_COMPANION_SEX_N"], L["CFG_COMPANION_SEX_M"], L["CFG_COMPANION_SEX_F"] },
			order	= 3,
			get		= function (info)
				local s = MylunesChampions.db.profile.PCT[MylunesChampions.db.profile.emoteLocale][info[#info-1]].s
				if (s == "m") then
					return 2
				elseif (s == "f") then
					return 3
				else
					return 1
				end
			end,
			set		= function (info, v)
				if v == 2 then
					MylunesChampions.db.profile.PCT[MylunesChampions.db.profile.emoteLocale][info[#info-1]].s = "m"
				elseif v == 3 then
					MylunesChampions.db.profile.PCT[MylunesChampions.db.profile.emoteLocale][info[#info-1]].s = "f"
				else
					MylunesChampions.db.profile.PCT[MylunesChampions.db.profile.emoteLocale][info[#info-1]].s = nil
				end
			end,
		},
		removePet = {
			type 	= "execute",
			name 	= L["CFG_PETS_REMOVE"],
			desc	= L["CFG_PETS_REMOVE_TT"],
			order	= 20,
			func	= function (info)
				local pet = info[#info-1]
				MylunesChampions.db.profile.PCT[MylunesChampions.db.profile.emoteLocale][pet] = nil
				MylunesChampions:RebuildConfig()
				MylunesChampions:Printf(L["CFG_PETS_REMOVED"], pet)
			end,
		},
	},
}

----------------------------------------------
-- Copies a table
----------------------------------------------
local function MylunesChampions_TableDeepCopy(t)
	local nt = {}
	for k,v in pairs(t) do
		if type(v) == "table" then
			local nv = MylunesChampions_TableDeepCopy(v)
			nt[k] = nv
		else
			nt[k] = v
		end
	end
	return nt
end

----------------------------------------------
-- Set width of config elements to full width
----------------------------------------------
local function MylunesChampions_AdjustConfig(group)
	if group.args == nil then return end
	-- adjust controls to full width	
	for k,v in pairs(group.args) do
		v["width"] = "full"
		if not (v.args == nil) then
			MylunesChampions_AdjustConfig(v)
		end
	end
end

----------------------------------------------
-- Initialize configuration options
----------------------------------------------
function MylunesChampions:InitConfig()	
	-- Set up core config options
	MylunesChampions_AdjustConfig(self.configOptionsTableCore)
	AceConfig:RegisterOptionsTable("MylunesChampions_Core", self.configOptionsTableCore)
	self.configFrameCore = AceConfigDialog:AddToBlizOptions("MylunesChampions_Core", "Mylune's Champions")
	
	-- Set up emote config options
	
	MylunesChampions_AdjustConfig(configOptionsPersonalityTemplate)
	MylunesChampions_AdjustConfig(configOptionsEmoteTemplate)
	MylunesChampions_AdjustConfig(configOptionsEventTemplate)
	MylunesChampions_AdjustConfig(configOptionsRandomTemplate)
	
	-- Initialize emote table
	CurrentEmote = "EMOTE_"..EmoteTable[EmoteIndex]
	
	-- Initialize event table
	local LPDef = self.defaults.profile.P["enUS"]["Default"]
	for e,t in pairs(LPDef) do
		if (not (e == "EVENT_RANDOM")) and string.find(e, "^EVENT_") then
			table.insert(EventTable, e)
		end
	end
	table.sort(EventTable)
	CurrentEvent = EventTable[1]
	
	self:RebuildConfig()
	
	-- Personalities
	AceConfig:RegisterOptionsTable("MylunesChampions_Personalities", self.configOptionsTablePersonalities)
	self.configFrameEmotes = AceConfigDialog:AddToBlizOptions("MylunesChampions_Personalities", L["CFG_PERSONALITIES"], "Mylune's Champions")
	
	-- Companions
	AceConfig:RegisterOptionsTable("MylunesChampions_Companions", self.configOptionsTableCompanions)
	self.configFrameEmotes = AceConfigDialog:AddToBlizOptions("MylunesChampions_Companions", L["CFG_COMPANIONS"], "Mylune's Champions")
	
	-- Mounts
	AceConfig:RegisterOptionsTable("MylunesChampions_Mounts", self.configOptionsTableMounts)
	self.configFrameEmotes = AceConfigDialog:AddToBlizOptions("MylunesChampions_Mounts", L["CFG_MOUNTS"], "Mylune's Champions")
	
	-- Pets
	AceConfig:RegisterOptionsTable("MylunesChampions_Pets", self.configOptionsTablePets)
	self.configFrameEmotes = AceConfigDialog:AddToBlizOptions("MylunesChampions_Pets", L["CFG_PETS"], "Mylune's Champions")
end

----------------------------------------------
-- Initialize configuration options
----------------------------------------------
function MylunesChampions:RebuildConfig()
	self.PersTable = { }
	LG = self.G[self.db.profile.emoteLocale]
	
	local LP = self.LP
	local LPDef = self.defaults.profile.P[self.db.profile.emoteLocale]["Default"]
	
	self.configOptionsTablePersonalities.name = L["CFG_PERSONALITIES"] .. " (" .. self.db.profile.emoteLocale .. ")"
	self.configOptionsTablePersonalities.args = {}
	for n,b in pairs(configOptionsTablePersonalitiesButtons) do
		self.configOptionsTablePersonalities.args[n] = b
	end

	for n,e in pairs(LP) do
		self.configOptionsTablePersonalities.args[n] = MylunesChampions_TableDeepCopy(configOptionsPersonalityTemplate)
		self.configOptionsTablePersonalities.args[n].name = n
		
		table.insert(self.PersTable, n)
		self.configOptionsTablePersonalities.args[n].args.base.values = self.PersTable -- reference
		
		local t = MylunesChampions_TableDeepCopy(configOptionsEmoteTemplate)
		t.name = "Emotes"
		self.configOptionsTablePersonalities.args[n].args["Emotes"] = t
		
		t = MylunesChampions_TableDeepCopy(configOptionsEventTemplate)
		t.name = "Events"
		self.configOptionsTablePersonalities.args[n].args["Events"] = t
		
		for en,s in pairs(LPDef) do
			if en == "INHERIT" then
				-- nothing
			elseif en == "AUTHORS" then
				self.configOptionsTablePersonalities.args[n].args["authors"].name = L["Authors"]..": "..tostring(LP[n]["AUTHORS"])
			elseif en == "EVENT_RANDOM" then
				local t = MylunesChampions_TableDeepCopy(configOptionsRandomTemplate)
				t.name = string.gsub(en, "^EVENT_", "Event ")
				self.configOptionsTablePersonalities.args[n].args[en] = t
			end
		end
	end
	table.sort(self.PersTable)
	table.insert(self.PersTable, 1, L["CFG_PERS_BASE_NONE"])
	
	-- companions
	self.configOptionsTableCompanions.args = {}
	for id,c in pairs(self.db.profile.C) do
		local t = MylunesChampions_TableDeepCopy(configOptionsCompanionTemplate)
		t.name = c.n
		t.args.name.name = c.n
		t.args.personality.values = self.PersTable -- reference
		self.configOptionsTableCompanions.args[tostring(id)] = t
	end
	
	-- mounts
	self.configOptionsTableMounts.args = {}
	for id,c in pairs(self.db.profile.M) do
		local t = MylunesChampions_TableDeepCopy(configOptionsMountTemplate)
		t.name = c.n
		t.args.name.name = c.n
		t.args.personality.values = self.PersTable -- reference
		self.configOptionsTableMounts.args[tostring(id)] = t
	end
	
	-- pets
	self.configOptionsTablePets.name = L["CFG_PETS"] .. " (" .. self.db.profile.emoteLocale .. ")"
	self.configOptionsTablePets.args = {}
	for b,t in pairs(configOptionsTablePetsButtons) do
		self.configOptionsTablePets.args[b] = t
	end
	for n,c in pairs(self.db.profile.PCT[self.db.profile.emoteLocale]) do
		local t = MylunesChampions_TableDeepCopy(configOptionsPetTemplate)
		t.name = self.BabbleCTL[n]
		if not t.name then
			t.name = n
		end
		t.args.name.name = t.name
		t.args.personality.values = self.PersTable -- reference
		if MylunesChampions.PCT[self.db.profile.emoteLocale][t.args.name.name] then
			t.args.removePet = nil
		end
		self.configOptionsTablePets.args[n] = t
	end
end

----------------------------------------------
-- Initialize configuration options
----------------------------------------------
function MylunesChampions:ImportChinchillaCritterEmote()
	if not CritterEmote_ResponseDb then
		self:Printf(L["CFG_PERS_IMPORT_CHINCHILLA_INACTIVE"])
		return
	end
	
	local p = MylunesChampions.db.profile.P["enUS"]
	for e,t in pairs(CritterEmote_ResponseDb) do
		-- check whether we support the emote
		if p["Default"]["EMOTE_"..e] then
			for pers,emotes in pairs(t) do
				local emotes_str = ""
				for i,emote in ipairs(emotes) do
					emotes_str = emotes_str..emote.."\n"
				end
				if p["Chinchilla "..pers] == nil then
					p["Chinchilla "..pers] = { AUTHORS = "seegeen00", }
				end
				p["Chinchilla "..pers]["EMOTE_"..e] = {
					["someoneAtPet"] = emotes_str, -- also counts as youAtPet
					["someoneAtYou"] = emotes_str,
					["youNoTarget"] = emotes_str,
				}
			end
		elseif (e == "Random") then
			-- random emotes
			for pers,emotes in pairs(t) do
				local emotes_str = ""
				local last = ""
				for i,emote in ipairs(emotes) do
					if not (last == emote) then -- filter duplicates
						emotes_str = emotes_str..emote.."\n"
					end
					last = emote
				end
				if p["Chinchilla "..pers] == nil then
					p["Chinchilla "..pers] = { AUTHORS = "seegeen00", }
				end
				p["Chinchilla "..pers]["EVENT_RANDOM"] = {
					["emotes"] = emotes_str,
				}
			end
		end
	end
end
