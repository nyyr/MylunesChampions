----------------------------------------------
-- Module
----------------------------------------------
MylunesChampions = LibStub("AceAddon-3.0"):NewAddon("Mylune's Champions", 
	"AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0");	
MylunesChampions.G = {} -- general
MylunesChampions.C = {} -- companions
MylunesChampions.M = {} -- mounts
MylunesChampions.P = {} -- personalities
MylunesChampions.PCT = {} -- creature type personalities

----------------------------------------------
-- Localization
----------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("MylunesChampions", true)
MylunesChampions.LG  = {} -- general
MylunesChampions.clientLocale = GetLocale()
MylunesChampions.emoteLocales = { "enUS", "deDE" }
MylunesChampions.BabbleCTL = LibStub("LibBabble-CreatureType-3.0"):GetUnstrictLookupTable();
MylunesChampions.BabbleCTE = LibStub("LibBabble-CreatureType-3.0"):GetReverseLookupTable();

----------------------------------------------
-- Version
----------------------------------------------
local _, _, rev = string.find("$Rev$", "([0-9]+)")
MylunesChampions.version = "0.5 (r"..rev..")"
MylunesChampions.codename = "Rise of the Critters"
MylunesChampions.authors = "nyyr"

----------------------------------------------
-- Config options
----------------------------------------------
MylunesChampions.defaults = {
	profile = {
		enable = true,
		emoteReplyBackoff = 2, -- minimum time between emote replies
		autoEmoteBackoff = 120, -- minimum time between auto emotes (emotes on events)
		randomEmoteBackoff = 300, -- minimum time between random emotes (idle emotes, shares CD with autoEmoteBackoff)
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
MylunesChampions.playerMistress = ""
if UnitSex("player") == 3 then
	MylunesChampions.playerMistress = "m" -- player character is female
end

local emoteColor = "|cFFFF8040"

MylunesChampions.LP = nil -- localized personality

----------------------------------------------
-- MylunesChampions_RandomElement
-- Returns a random element from a table or from a
-- newline-separated string-list.
----------------------------------------------
function MylunesChampions_RandomElement(emotes)
	if not emotes then return nil end
	if type(emotes) == "string" then
		emotes = { strsplit("\n", emotes) }
	end
	if emotes and #(emotes) > 0 then
		local i = random(#(emotes))
		if string.len(emotes[i]) > 0 then
			return emotes[i]
		end
	end
	return nil
end

----------------------------------------------
-- MylunesChampions_Sub
----------------------------------------------
function MylunesChampions_Sub(msg, targetName, someonesName)
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
	pattern = "^"..pattern.."$"
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
				if e["pattern_someoneAtYou"] and string.find(str, MylunesChampions_LuaPat(e["pattern_someoneAtYou"])) then
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
		(string.find(str, "^s ") and MylunesChampions.db.profile.emoteLocale == "deDE") or
		(string.find(str, "^'aka "))
	then
		-- own emotes
		self:AddMessage(emoteColor..arg2..str.."|r")
		return true, arg2..str, arg2, arg3, ...

	elseif (string.find(str, "^(%a*) 's ") and MylunesChampions.db.profile.emoteLocale == "enUS") then
		-- emotes from other players
		str = string.gsub(str, "^(%a*) 's (.*)", "%1's %2")
		self:AddMessage(emoteColor..str.."|r")
		return true, str, arg2, arg3, ...
		
	elseif (string.find(str, "^(%a*) s ") and MylunesChampions.db.profile.emoteLocale == "deDE") then
		-- emotes from other players
		str = string.gsub(str, "^(%a*) s (.*)", "%1s %2")
		self:AddMessage(emoteColor..str.."|r")
		return true, str, arg2, arg3, ...
		
	elseif (string.find(str, "^(%a*) 'aka ")) then
		-- emotes from other players
		str = string.gsub(str, "^(%a*) 'aka (.*)", "%1'aka %2")
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
	self.defaults.profile.M = self.M -- mounts
	self.defaults.profile.PCT = self.PCT -- creature type personalities
	self.db = LibStub("AceDB-3.0"):New("MylunesChampionsDB", MylunesChampions.defaults, "profile")
	
	for i=1,GetNumCompanions("CRITTER") do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("CRITTER", i)
		if not self.db.profile.C[creatureID] then
			self.db.profile.C[creatureID] = { n = creatureName, p = "Default" }
		elseif not (self.db.profile.C[creatureID].n == creatureName) then
			self.db.profile.C[creatureID].n = creatureName -- localized
		end
	end
	
	for i=1,GetNumCompanions("MOUNT") do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("MOUNT", i)
		if not self.db.profile.M[creatureID] then
			self.db.profile.M[creatureID] = { n = creatureName, p = "Default" }
		elseif not (self.db.profile.M[creatureID].n == creatureName) then
			self.db.profile.M[creatureID].n = creatureName -- localized
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
	MylunesChampions.LG = self.G[self.db.profile.emoteLocale]
	MylunesChampions.LP = self.db.profile.P[self.db.profile.emoteLocale]
	
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
	self:RegisterChatCommand("mte", "MountEmote")
	
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
	self:UnregisterChatCommand("mte")
	
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
	self.LG = self.G[self.db.profile.emoteLocale]
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
		local mount = self:GetCurrentMount()
		local pet = self:GetCurrentPet()
		local results = {}
		
		-- companion
		if companion then
			if targetName and not (targetName == MylunesChampions.playerName) then
				if targetName == companion then
					how = "youAtPet"
				elseif not (targetName == pet) then
					how = "youAtTarget"
					-- else prefere pet emote
				end
			else
				how = "youNoTarget"
			end
			
			local s = self:GetRandomCompanionEmoteReply(emote, how)
			if s then
				results["COMPANION"] = MylunesChampions_Sub(s, targetName, self.playerName)
			end
		end
		how = nil
		
		-- mount
		if mount then
			if targetName and not (targetName == MylunesChampions.playerName) then
				if (not (targetName == pet)) and not (targetName == companion) then
					how = "youAtTarget"
					-- else prefere pet/companion emotes
				end
			else
				how = "youNoTarget"
			end
			
			local s = self:GetRandomMountEmoteReply(emote, how)
			if s then
				results["MOUNT"] = MylunesChampions_Sub(s, targetName, self.playerName)
			end
		end
		how = nil
		
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
				results["PET"] = MylunesChampions_Sub(s, targetName, self.playerName)
			end
		end
		
		self:DoAnyEmote(results)
	end
end

----------------------------------------------
-- OnRandomEmote()
----------------------------------------------
function MylunesChampions:OnRandomEmote()
	local t = GetTime()
	local last = self.lastRandomEmote
	--if self.lastAutoEmote > self.lastRandomEmote then
		--last = self.lastAutoEmote
	--end
	
	if t - last > self.db.profile.randomEmoteBackoff then
		local companion = self:GetCurrentCompanion()
		local mount = self:GetCurrentMount()
		local pet = self:GetCurrentPet()
		local results = {}
		
		if companion then
			local s = self:GetRandomCompanionEmote()
			if s then
				results["COMPANION"] = s
			end
		end
		
		if mount then
			local s = self:GetRandomMountEmote()
			if s then
				results["MOUNT"] = s
			end
		end
		
		if pet then
			local s = self:GetRandomPetEmote()
			if s then
				results["PET"] = s
			end
		end
		
		if self:DoAnyEmote(results) then
			self.lastRandomEmote = t
		end
	end
end

----------------------------------------------
-- DoAnyEmote - do any of the possible emotes
----------------------------------------------
function MylunesChampions:DoAnyEmote(results)
	if not results then return nil end
	
	local n = 0
	local r = {}
	for k,v in pairs(results) do
		table.insert(r, k)
		n = n + 1
	end
	if n == 0 then return nil end
	
	local i = random(n)
	
	if r[i] == "COMPANION" then
		self:CompanionEmote(results[r[i]])
		return 1
	elseif r[i] == "MOUNT" then
		self:MountEmote(results[r[i]])
		return 1
	elseif r[i] == "PET" then
		self:PetEmote(results[r[i]])
		return 1
	else
		self:Debug(d_warn, "Error in DoAnyEmote()")
	end
	
	return nil
end

----------------------------------------------
-- GetEmotes
----------------------------------------------
function MylunesChampions:GetEmotes(pers, sex, event, how)
	local s = nil
	
	if sex then
		s = self:GetRawEmotes(pers, event, sex..MylunesChampions.playerMistress.."_"..how)
		if not s then
			s = self:GetRawEmotes(pers, event, sex.."_"..how)
			if not s then
				s = self:GetRawEmotes(pers, event, how)
			end
		end
	else
		s = self:GetRawEmotes(pers, event, how)
	end
	
	return s
end

----------------------------------------------
-- GetRawEmotes - Returns raw emote string (incl. inherited emotes)
--   pers - Personality string
--   emote - Emote string (including EMOTE_)
--   how - someoneAtYou, someoneAtPet, youAtSomeone, youAtPet, youNoTarget, useEmote, emote, afk, incombat
--   visited_personality - Internal: Loop detection
--   useEmote - Internal: Loop detection
----------------------------------------------
function MylunesChampions:GetRawEmotes(pers, emote, how, visited_personalities, useEmote)
	--self:Debug(d_notice, "GetRawEmotes(%s, %s, %s)", tostring(pers), tostring(emote), tostring(how))
	if not pers or not emote or not how then return nil end
	if not visited_personalities then visited_personalities = {} end
	
	local p = self.LP[pers]
	if not p then return end
	
	if p[emote] and p[emote]["useEmote"] and not (p[emote]["useEmote"] == "") and not (how == "useEmote") then
		local usedEmote = "EMOTE_"..p[emote]["useEmote"]
		--self:Debug(d_notice, "Emote "..emote.." uses "..usedEmote)
		if not useEmote then
			return self:GetRawEmotes(pers, usedEmote, how, visited_personalities, true)
		else
			self:Printf(L["USEEMOTE_LOOP"], emote, usedEmote)
			return nil
		end
		
	elseif p[emote] and p[emote][how] then
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
		return self:GetRawEmotes(p["INHERIT"], emote, how, visited_personalities, useEmote)
	end
	
	return nil
end

----------------------------------------------
-- SetRawEmotes - Set raw emote string
----------------------------------------------
function MylunesChampions:SetRawEmotes(pers, emote, how, value)
	local p = self.LP[pers]
	--local pd = self.defaults.profile.P[self.db.profile.emoteLocale][pers]
	
	if how == "useEmote" and not (value == nil) then
		local usedEmote = "EMOTE_"..value
		if p[usedEmote] and p[usedEmote]["useEmote"] then
			self:Printf(L["USEEMOTE_LOOP"], value, p[usedEmote]["useEmote"])
			return
		end
	end
	
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
-- DoEmote
----------------------------------------------
function MylunesChampions:DoEmote(emoteText, noPossessive)
	if noPossessive then
		self.lastEmoteMessage = emoteText
	else
		self.lastEmoteMessage = self.LG["POSSESSIVE"] .. " " .. emoteText
	end
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
-- UNIT_HEALTH
----------------------------------------------
function MylunesChampions:UNIT_HEALTH(event, unit)
	--self:Debug(d_notice, "UNIT_HEALTH("..unit..")")
	
	local t = GetTime()
	if t - self.lastAutoEmote > self.db.profile.autoEmoteBackoff then
		
		if InCombatLockdown() then
		
			-- low health
			if (unit == "player" or unit == "pet" or unit == "target") and (UnitHealth(unit) / UnitHealthMax(unit) < 0.3) then
			
				local n, _ = self:GetCurrentCompanion()
				if n then
					local s = self:GetRandomCompanionEvent(string.upper(unit) .. "_LOWHEALTH")
					if s then
						self.lastAutoEmote = t
						self:CompanionEmote(MylunesChampions_Sub(s, UnitName("target")))
					end
				end
				
				local n, _ = self:GetCurrentPet()
				if n then
					local s = self:GetRandomPetEvent(string.upper(unit) .. "_LOWHEALTH")
					if s then
						self.lastAutoEmote = t
						self:PetEmote(MylunesChampions_Sub(s, UnitName("target")))
					end
				end
				
			end
			
		end
		
	end
	
end
