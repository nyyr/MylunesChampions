----------------------------------------------
-- Module
----------------------------------------------
MylunesChampions = LibStub("AceAddon-3.0"):NewAddon("Mylune's Champions", 
	"AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0");	
MylunesChampions.G = {} -- general
MylunesChampions.C = {} -- companions
MylunesChampions.P = {} -- personalities
MylunesChampions.PCT = {} -- creature type personalities

----------------------------------------------
-- Localization
----------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("MylunesChampions", true)
local LG  = {} -- general
MylunesChampions.clientLocale = GetLocale()
MylunesChampions.emoteLocales = { "enUS", "deDE" }
MylunesChampions.BabbleCTL = LibStub("LibBabble-CreatureType-3.0"):GetLookupTable();
MylunesChampions.BabbleCTE = LibStub("LibBabble-CreatureType-3.0"):GetReverseLookupTable();

----------------------------------------------
-- Version
----------------------------------------------
local _, _, rev = string.find("$Rev$", "([0-9]+)")
MylunesChampions.version = "0.1 (r"..rev..")"
MylunesChampions.codename = "Rise of the Critters"
MylunesChampions.authors = "nyyr"

----------------------------------------------
-- Config options
----------------------------------------------
MylunesChampions.defaults = {
	profile = {
		enable = true,
		emoteReplyBackoff = 2, -- minimum time between emote replies
		autoEmoteBackoff = 60, -- minimum time between auto emotes
		randomEmoteBackoff = 300, -- minimum time between random emotes (shares CD with autoEmoteBackoff)
		emoteDelay = 0.5, -- defer emote for N seconds
		emoteLocale = nil,
		C = {}, -- companions
		P = {}, -- personalities
	},
}

----------------------------------------------
-- Debugging levels
--   0 Off
--   1 Warning
--   2 Info
--   3 Notice
----------------------------------------------
local d_warn = 1
local d_info = 2
local d_notice = 3
local debugLevel = d_notice

-- rate control
MylunesChampions.lastEmoteReply = GetTime()
MylunesChampions.lastAutoEmote = GetTime()
MylunesChampions.lastRandomEmote = GetTime()

-- defered emote message
MylunesChampions.lastEmoteMessage = nil
MylunesChampions.lastEmoteTimer = nil

MylunesChampions.playerName = UnitName("player")

local emoteColor = "|cFFFF8040"

----------------------------------------------
-- MylunesChampions_RandomElement
----------------------------------------------
local function MylunesChampions_RandomElement(mytable)
	if mytable and #(mytable) > 0 then
		local i = random(#(mytable))
		if string.len(mytable[i]) > 0 then
			return mytable[i]
		end
	end
	return nil
end

----------------------------------------------
-- MylunesChampions_Sub
----------------------------------------------
local function MylunesChampions_Sub(msg, targetName, someonesName)
	if targetName then
		msg = string.gsub(msg, "%%t", targetName)
	end
	if someonesName then
		msg = string.gsub(msg, "%%s", someonesName)
	end
	return msg
end

----------------------------------------------
-- MylunesChampions_LuaPat
----------------------------------------------
local function MylunesChampions_LuaPat(pattern)
	pattern = string.gsub(pattern, "%.", "%%.")
	pattern = string.gsub(pattern, "%%s", "(.*)")
	pattern = string.gsub(pattern, "%%t", "(.*)")
	return pattern
end

----------------------------------------------
-- ChatMessageFilter
----------------------------------------------
local function MylunesChampions_ChatMessageFilter(self, event, str, arg2, arg3, ...)
	--MylunesChampions:Debug(d_notice, tostring(event) .."(".. tostring(str) ..", ".. tostring(arg2) ..", ".. tostring(arg3) ..")")
	
	local t = GetTime()
	if t - MylunesChampions.lastEmoteReply > MylunesChampions.db.profile.emoteReplyBackoff then
		MylunesChampions.lastEmoteReply = t

		for n,e in pairs(L) do
			if type(e) == "table" and string.find(n, "^EMOTE_") then
				--MylunesChampions:Debug(d_notice, "Emote "..n.." ("..str..", "..tostring(string.find(str, MylunesChampions_LuaPat(e["pattern_someoneAtTarget"])))..")")
				if e["pattern_someoneNoTarget"] and string.find(str, MylunesChampions_LuaPat(e["pattern_someoneNoTarget"])) then
					local pattern = MylunesChampions_LuaPat(e["pattern_someoneNoTarget"])
					local someone = string.gsub(str, pattern, "%1")
					local companion = MylunesChampions:GetCurrentCompanion()
					if companion then
						local s = MylunesChampions:GetRandomCompanionEmoteReply(n, "someoneNoTarget")
						if s then
							MylunesChampions:CompanionEmote(MylunesChampions_Sub(s, nil, someone))
							break
						end
					end
					
					local pet = MylunesChampions:GetCurrentPet()
					if pet then
						local s = MylunesChampions:GetRandomPetEmoteReply(n, "someoneNoTarget")
						if s then
							MylunesChampions:PetEmote(MylunesChampions_Sub(s, nil, someone))
							break
						end
					end
					
					break
					
				elseif e["pattern_someoneAtYou"] and string.find(str, MylunesChampions_LuaPat(e["pattern_someoneAtYou"])) then
					local pattern = MylunesChampions_LuaPat(e["pattern_someoneAtYou"])
					local someone = string.gsub(str, pattern, "%1")
					local companion = MylunesChampions:GetCurrentCompanion()
					local how = nil
					if companion then
						local s = MylunesChampions:GetRandomCompanionEmoteReply(n, "someoneAtYou")
						if s then
							MylunesChampions:CompanionEmote(MylunesChampions_Sub(s, MylunesChampions.playerName, someone))
							break
						end
					end
					
					local pet = MylunesChampions:GetCurrentPet()
					if pet then
						local s = MylunesChampions:GetRandomPetEmoteReply(n, "someoneAtYou")
						if s then
							MylunesChampions:PetEmote(MylunesChampions_Sub(s, MylunesChampions.playerName, someone))
							break
						end
					end
					
					break
					
				elseif e["pattern_someoneAtTarget"] and string.find(str, MylunesChampions_LuaPat(e["pattern_someoneAtTarget"])) then
					local pattern = MylunesChampions_LuaPat(e["pattern_someoneAtTarget"])
					local someone = string.gsub(str, pattern, "%1")
					local targetName = string.gsub(str, pattern, "%2")
					
					local companion = MylunesChampions:GetCurrentCompanion()
					if companion then
						if targetName then
							if targetName == companion then
								local s = MylunesChampions:GetRandomCompanionEmoteReply(n, "someoneAtPet")
								if s then
									MylunesChampions:CompanionEmote(MylunesChampions_Sub(s, targetName, someone))
									break
								end
							end
						end
					end
					
					local pet = MylunesChampions:GetCurrentPet()
					if pet then
						if targetName then
							if targetName == pet then
								local s = MylunesChampions:GetRandomPetEmoteReply(n, "someoneAtPet")
								if s then
									MylunesChampions:PetEmote(MylunesChampions_Sub(s, targetName, someone))
									break
								end
							end
						end
					end
					
					break
					
				end
			end
		end
		
	end
	
	-- get rid of this annoying space
	if (string.find(str, "^'s ") and MylunesChampions.db.profile.emoteLocale == "enUS") or 
		(string.find(str, "^s ") and MylunesChampions.db.profile.emoteLocale == "deDE")
	then
		self:AddMessage(emoteColor..arg2..str.."|r")
		return true, arg2..str, arg2, arg3, ...

	elseif (string.find(str, "^(%a*) 's ") and MylunesChampions.db.profile.emoteLocale == "enUS") then
		str = string.gsub(str, "^(%a*) 's (.*)", "%1's %2")
		self:AddMessage(emoteColor..str.."|r")
		return true, str, arg2, arg3, ...
		
	elseif (string.find(str, "^(%a*) s ") and MylunesChampions.db.profile.emoteLocale == "deDE") then
		str = string.gsub(str, "^(%a*) s (.*)", "%1s %2")
		self:AddMessage(emoteColor..str.."|r")
		return true, str, arg2, arg3, ...
	end
	
	return false, str, arg2, arg3, ...
end

----------------------------------------------
-- Print debug message
----------------------------------------------
function MylunesChampions:Debug(level, msg, ...)
	if (level <= debugLevel) then
		self:Printf(msg, ...)
	end
end

----------------------------------------------
--- Init
----------------------------------------------
function MylunesChampions:OnInitialize()
	-- Load our database.
	self.defaults.profile.P = self.P -- personalities
	self.defaults.profile.C = self.C -- companions
	self.defaults.profile.PCT = self.PCT -- creature type personalities
	self.db = LibStub("AceDB-3.0"):New("MylunesChampionsDB", MylunesChampions.defaults, "profile")
	
	for i=1,GetNumCompanions("CRITTER") do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("CRITTER", i)
		--self:Debug(d_notice, creatureID .. " " .. creatureName .. " (" .. tostring(issummoned) .. ")")
		if not self.db.profile.C[creatureID] then
			self.db.profile.C[creatureID] = { n = creatureName, p = "Default" }
		elseif not (self.db.profile.C[creatureID].n == creatureName) then
			self.db.profile.C[creatureID].n = creatureName -- localized
		end
	end
	
	if not self.db.profile.emoteLocale then
		if not self.P[self.clientLocale] then
			self:Printf(L["UNSUPPORTED_LOCALE"])
			self.db.profile.emoteLocale = "enUS"
		else
			self.db.profile.emoteLocale = self.clientLocale
		end
	end
	LG = self.G[self.db.profile.emoteLocale]
	
	self:InitConfig()
	
	if self.db.profile.enable then
		self:Enable()
	end
	
	self:Debug(d_notice, L["LOADED"])
end

----------------------------------------------
-- OnEnable()
----------------------------------------------
function MylunesChampions:OnEnable()
	self:RegisterChatCommand("ce", "CompanionEmote")
	self:RegisterChatCommand("pe", "PetEmote")
	
	ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", MylunesChampions_ChatMessageFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", MylunesChampions_ChatMessageFilter)
	
	self:SecureHook("DoEmote", "OnDoEmote")
	
	self:RegisterEvent("UNIT_HEALTH")
	
	-- yes, autoEmoteBackoff, not randomEmoteBackoff
	self.randomEmoteTimer = self:ScheduleRepeatingTimer("OnRandomEmote", self.db.profile.autoEmoteBackoff)
	
	self:Debug(d_notice, L["ENABLED"])
end

----------------------------------------------
-- OnDisable()
----------------------------------------------
function MylunesChampions:OnDisable()
	self:UnregisterChatCommand("ce")
	self:UnregisterChatCommand("pe")
	
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_EMOTE", MylunesChampions_ChatMessageFilter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_TEXT_EMOTE", MylunesChampions_ChatMessageFilter)
	
	self:Unhook("DoEmote")
	
	self:UnregisterEvent("UNIT_HEALTH")
	self:CancelTimer(self.randomEmoteTimer, true)
	
	self:Debug(d_notice, L["DISABLED"])
end

----------------------------------------------
-- OnConfigUpdate()
----------------------------------------------
function MylunesChampions:OnConfigUpdate()
	-- Enable
	if (self.db.profile.enable) then
		if not MylunesChampions:IsEnabled() then
			MylunesChampions:Enable()
		end
	else
		if MylunesChampions:IsEnabled() then
			MylunesChampions:Disable()
		end
	end
	
	-- Emote locale
	LG = self.G[self.db.profile.emoteLocale]
end

----------------------------------------------
-- OnDoEmote()
----------------------------------------------
function MylunesChampions:OnDoEmote(emote, target)
	--self:Debug(d_notice, "OnDoEmote("..tostring(emote)..", "..tostring(target)..")")
	
	local t = GetTime()
	if t - self.lastEmoteReply > self.db.profile.emoteReplyBackoff then
		self.lastEmoteReply = t
	
		local how = nil
		local targetName = UnitName("target")
		local companion = self:GetCurrentCompanion()
		local pet = self:GetCurrentPet()
		
		-- companion
		if companion then
			if targetName and not (targetName == MylunesChampions.playerName) then
				if targetName == companion then
					how = "youAtPet"
				elseif not pet or not (targetName == pet) then
					how = "youAtTarget"
				end
			else
				how = "youNoTarget"
			end
			
			local s = self:GetRandomCompanionEmoteReply(emote, how)
			if s then
				self:CompanionEmote(MylunesChampions_Sub(s, targetName, self.playerName))
				return
			end
		end
		
		-- combat pet
		if pet then
			if targetName then
				if targetName == pet then
					how = "youAtPet"
				else
					how = "youAtTarget"
				end
			else
				how = "youNoTarget"
			end
			
			local s = self:GetRandomPetEmoteReply(emote, how)
			if s then
				self:PetEmote(MylunesChampions_Sub(s, targetName, self.playerName))
				return
			end
		end
	end
end

----------------------------------------------
-- OnRandomEmote()
----------------------------------------------
function MylunesChampions:OnRandomEmote()
	local t = GetTime()
	local last = self.lastRandomEmote
	if self.lastAutoEmote > self.lastRandomEmote then
		last = self.lastAutoEmote
	end
	
	if t - last > self.db.profile.randomEmoteBackoff then
		local s = self:GetRandomCompanionEmote()
		if s then
			self:CompanionEmote(s)
			self.lastRandomEmote = t
			self.lastAutoEmote = t
		end
	end
end

----------------------------------------------
-- GetRawEmotes - Returns raw emote string (incl. inherited emotes)
----------------------------------------------
function MylunesChampions:GetRawEmotes(pers, emote, how, visited_personalities)
	--self:Debug(d_notice, "GetRawEmotes(%s, %s, %s)", tostring(pers), tostring(emote), tostring(how))
	if not pers or not emote or not how then return nil end
	if not visited_personalities then visited_personalities = {} end
	
	local p = self.db.profile.P[self.db.profile.emoteLocale][pers]
	if p[emote] and p[emote][how] then
		if p[emote][how] == "" then
			return nil -- override (N/A)
		else
			return p[emote][how]
		end
		
	elseif p["INHERIT"] and not (p["INHERIT"] == "None") and not (p["INHERIT"] == "") then
		-- check for loops
		for i,n in ipairs(visited_personalities) do
			if n == pers then
				local path = ""
				for j,n in ipairs(visited_personalities) do
					path = path .. " / " .. n
				end
				path = path .. " / " .. pers
				self:Printf(L["PERSONALITY_LOOP"], path)
				return nil
			end
		end
		-- descend
		table.insert(visited_personalities, pers)
		return self:GetRawEmotes(p["INHERIT"], emote, how, visited_personalities)
	end
	
	return nil
end

----------------------------------------------
-- SetRawEmotes - Set raw emote string
----------------------------------------------
function MylunesChampions:SetRawEmotes(pers, emote, how, value)
	local p = self.db.profile.P[self.db.profile.emoteLocale][pers]
	local pd = self.defaults.profile.P[self.db.profile.emoteLocale][pers]
	if value == nil then -- erase/reset
		if p[emote] then
			p[emote][how] = nil
		end
	elseif value == "" then -- override with empty value (N/A)
		if not p[emote] then
			p[emote] = {}
		end
		p[emote][how] = ""
	else -- new value
		if not p[emote] then
			p[emote] = {}
		end
		p[emote][how] = value
	end
end

----------------------------------------------
-- GetRandomCompanionEmote
----------------------------------------------
function MylunesChampions:GetRandomCompanionEmote()
	local p = self:GetCompanionPersonality()
	local s = nil
	
	-- afk
	if UnitIsAFK("player") then
		s = self:GetRawEmotes(p, "EVENT_RANDOM", "afk")
	end
	-- in combat
	if (not s) and InCombatLockdown() then
		s = self:GetRawEmotes(p, "EVENT_RANDOM", "incombat")
	end
	-- default
	if not s then
		s = self:GetRawEmotes(p, "EVENT_RANDOM", "emotes")
	end

	if s then
		local t = GetTime()
		self.lastRandomEmote = t
		self.lastAutoEmote = t
		local e = { strsplit("\n", s) }
		return MylunesChampions_RandomElement(e)
	end
	
	return nil
end

----------------------------------------------
-- GetRandomCompanionEmoteReply
----------------------------------------------
function MylunesChampions:GetRandomCompanionEmoteReply(emote, how)
	emote = string.gsub(emote, "^EMOTE_", "") -- normalize
	
	local s = self:GetRawEmotes(self:GetCompanionPersonality(), "EMOTE_"..emote, how)
	if s then
		local e = { strsplit("\n", s) }
		return MylunesChampions_RandomElement(e)
	else
		if how == "youAtPet" then
			return self:GetRandomCompanionEmoteReply(emote, "someoneAtPet")
		end
	end
end

----------------------------------------------
-- GetRandomPetEmoteReply
----------------------------------------------
function MylunesChampions:GetRandomPetEmoteReply(emote, how)
	emote = string.gsub(emote, "^EMOTE_", "") -- normalize

	local s = self:GetRawEmotes(self:GetPetPersonality(), "EMOTE_"..emote, how)
	if s then
		local e = { strsplit("\n", s) }
		return MylunesChampions_RandomElement(e)
	else
		if how == "youAtPet" then
			return self:GetRandomPetEmoteReply(emote, "someoneAtPet")
		end
	end
end

----------------------------------------------
-- GetRandomCompanionEvent
----------------------------------------------
function MylunesChampions:GetRandomCompanionEvent(event)
	event = string.gsub(event, "^EVENT_", "") -- normalize

	local s = self:GetRawEmotes(self:GetCompanionPersonality(), "EVENT_"..event, "emotes")
	if s then
		local e = { strsplit("\n", s) }
		return MylunesChampions_RandomElement(e)
	end
	
	return nil
end

----------------------------------------------
-- GetRandomPetEvent
----------------------------------------------
function MylunesChampions:GetRandomPetEvent(event)
	event = string.gsub(event, "^EVENT_", "") -- normalize

	local s = self:GetRawEmotes(self:GetPetPersonality(), "EVENT_"..event, "emotes")
	if s then
		local e = { strsplit("\n", s) }
		return MylunesChampions_RandomElement(e)
	end
	
	return nil
end

----------------------------------------------
-- CompanionEmote
----------------------------------------------
function MylunesChampions:CompanionEmote(msg)
	--self:Debug(d_notice, "CompanionEmote: " .. tostring(msg))
	
	local name = self:GetCurrentCompanion()
	if name then
		if msg == "" then
			-- random emote
			msg = self:GetRandomCompanionEmote()
			self:DoEmote(LG["COMPANION"] .. " " .. name .. " " .. msg)
			
		elseif string.find(msg, "^(%a*)$") then
			msg = string.upper(msg)
			if LG["EMOTE_"..msg] then
				local pattern = nil
				local targetName = UnitName("target")
				if targetName and not (targetName == name) then
					pattern = LG["EMOTE_"..msg]["pattern_someoneAtTarget"]
				else
					pattern = LG["EMOTE_"..msg]["pattern_someoneNoTarget"]
				end
				if pattern then
					msg = MylunesChampions_Sub(string.gsub(pattern, "^%%s ", ""), targetName, name)
					self:DoEmote(LG["COMPANION"] .. " " .. name .. " " .. msg)
				end
			else
				self:Printf(L["EMOTE_NOT_FOUND"], msg)
			end
			
		else
			self:DoEmote(LG["COMPANION"] .. " " .. name .. " " .. msg)
		end
	else
		self:Printf(L["NO_COMPANION"])
	end
end

----------------------------------------------
-- PetEmote
----------------------------------------------
function MylunesChampions:PetEmote(msg)
	--self:Debug(d_notice, "PetEmote: " .. tostring(msg))
	
	local name, family = self:GetCurrentPet()
	if name then
		if not family then
			family = LG["PET"]
		else
			-- TODO: translate to emote locale
		end
		if string.find(msg, "^(%a*)$") then
			msg = string.upper(msg)
			if LG["EMOTE_"..msg] then
				local pattern = nil
				local targetName = UnitName("target")
				if targetName and not (targetName == name) then
					pattern = LG["EMOTE_"..msg]["pattern_someoneAtTarget"]
				else
					pattern = LG["EMOTE_"..msg]["pattern_someoneNoTarget"]
				end
				if pattern then
					msg = MylunesChampions_Sub(string.gsub(pattern, "^%%s ", ""), targetName, name)
					self:DoEmote(family .. " " .. name .. " " .. msg)
				end
			else
				self:Printf(L["EMOTE_NOT_FOUND"], msg)
			end
		else
			self:DoEmote(family .. " " .. name .. " " .. msg)
		end
	else
		self:Printf(L["NO_PET"])
	end
end

----------------------------------------------
-- DoEmote
----------------------------------------------
function MylunesChampions:DoEmote(emoteText)
	self.lastEmoteMessage = LG["POSSESSIVE"] .. " " .. emoteText
	if not self.lastEmoteTimer then
		self.lastEmoteTimer = self:ScheduleTimer("DisplayLastEmote", self.db.profile.emoteDelay)
	end
end

----------------------------------------------
-- DisplayLastEmote
----------------------------------------------
function MylunesChampions:DisplayLastEmote()
	if self.lastEmoteMessage then
		SendChatMessage(self.lastEmoteMessage, "EMOTE")
		self.lastEmoteMessage = nil
		self.lastEmoteTimer = nil
	end
end

----------------------------------------------
-- GetCurrentCompanion
-- TODO: cache current companion
-- returns creatureName, creatureID
----------------------------------------------
function MylunesChampions:GetCurrentCompanion()
	for i=1,GetNumCompanions("CRITTER") do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("CRITTER", i)
		--self:Debug(d_notice, creatureID .. " " .. creatureName .. " (" .. tostring(issummoned) .. ")")
		if issummoned then
			return creatureName, creatureID
		end
	end
	return nil, nil
end

----------------------------------------------
-- GetCurrentPet
-- returns petName, creatureFamily
----------------------------------------------
function MylunesChampions:GetCurrentPet()
	local petName = UnitName("pet")
	if petName then
		local creatureFamily = UnitCreatureFamily("pet")
		return petName, creatureFamily
	end
	return nil, nil
end

----------------------------------------------
-- GetCompanionPersonality
----------------------------------------------
function MylunesChampions:GetCompanionPersonality()
	local n, id = self:GetCurrentCompanion()
	if self.db.profile.C[id] then
		return self.db.profile.C[id].p
	end
	return "Default"
end

----------------------------------------------
-- GetCompanionPersonality
-- TODO: named pets
----------------------------------------------
function MylunesChampions:GetPetPersonality()
	local creatureFamily = UnitCreatureFamily("pet")
	if creatureFamily then
		return self.db.profile.PCT[self.db.profile.emoteLocale][self.BabbleCTE[creatureFamily]]
	end
	return "Default"
end

----------------------------------------------
-- UNIT_HEALTH
----------------------------------------------
function MylunesChampions:UNIT_HEALTH(event, unit)
	--self:Debug(d_notice, "UNIT_HEALTH("..unit..")")
	
	local t = GetTime()
	if t - self.lastAutoEmote > self.db.profile.autoEmoteBackoff then
		
		if InCombatLockdown() then
		
			-- low health
			if (unit == "player" or unit == "pet" or unit == "target") and (UnitHealth(unit) / UnitHealthMax(unit) < 0.3) then
				self.lastAutoEmote = t
				
				local n, _ = self:GetCurrentCompanion()
				if n then
					local s = self:GetRandomCompanionEvent(string.upper(unit) .. "_LOWHEALTH")
					if s then
						self:CompanionEmote(MylunesChampions_Sub(s, UnitName("target")))
					end
				end
				
				local n, _ = self:GetCurrentPet()
				if n then
					local s = self:GetRandomPetEvent(string.upper(unit) .. "_LOWHEALTH")
					if s then
						self:PetEmote(MylunesChampions_Sub(s, UnitName("target")))
					end
				end
			end
			
		end
		
	end
	
end
