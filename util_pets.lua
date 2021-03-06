----------------------------------------------
-- Localization
----------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("MylunesChampions", true)

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

----------------------------------------------
-- GetPetEmotes
----------------------------------------------
function MylunesChampions:GetPetEmotes(event, how)
	local p = self:GetPetPersonality()
	local g = self:GetPetSex()
	return self:GetEmotes(p, g, event, how)
end

----------------------------------------------
-- GetRandomPetEmote
----------------------------------------------
function MylunesChampions:GetRandomPetEmote()
	local s = nil
	
	-- afk
	if UnitIsAFK("player") then
		s = self:GetPetEmotes("EVENT_RANDOM", "afk")
	end
	-- in combat
	if (s == nil) and InCombatLockdown() then
		s = self:GetPetEmotes("EVENT_RANDOM", "incombat")
	end
	-- default
	if s == nil then
		s = self:GetPetEmotes("EVENT_RANDOM", "emotes")
	end

	if s then
		local t = GetTime()
		self.lastRandomEmote = t
		self.lastAutoEmote = t
		return MylunesChampions_RandomElement(s)
	end
	
	return nil
end

----------------------------------------------
-- GetRandomPetEmoteReply
----------------------------------------------
function MylunesChampions:GetRandomPetEmoteReply(emote, how)
	if not how then return nil end
	
	emote = string.gsub(emote, "^EMOTE_", "") -- normalize

	local s = self:GetPetEmotes("EMOTE_"..emote, how)
	if s then
		return MylunesChampions_RandomElement(s)
	else
		if how == "youAtPet" then
			return self:GetRandomPetEmoteReply(emote, "someoneAtPet")
		end
	end
	
	return nil
end

----------------------------------------------
-- GetRandomPetEvent
----------------------------------------------
function MylunesChampions:GetRandomPetEvent(event)
	event = string.gsub(event, "^EVENT_", "") -- normalize

	local s = self:GetPetEmotes("EVENT_"..event, "emotes")
	return MylunesChampions_RandomElement(s)
end

----------------------------------------------
-- PetEmote
----------------------------------------------
function MylunesChampions:PetEmote(msg)
	--self:Debug(d_notice, "PetEmote: " .. tostring(msg))
	
	local name, family = self:GetCurrentPet()
	if name then
		if not family then
			family = self.LG["PET"]
		else
			-- TODO: translate to emote locale
		end
		
		if msg == "" then
			-- random emote
			msg = self:GetRandomPetEmote()
			self:DoEmote(family .. " " .. name .. " " .. msg, noPossessive)
			
		elseif string.find(msg, "^(%a*)$") then
			msg = string.upper(msg)
			if self.LG["EMOTE_"..msg] then
				local pattern = nil
				local targetName = UnitName("target")
				if targetName and not (targetName == name) then
					pattern = self.LG["EMOTE_"..msg]["pattern_someoneAtTarget"]
				else
					pattern = self.LG["EMOTE_"..msg]["pattern_someoneNoTarget"]
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
-- GetPetPersonality
----------------------------------------------
function MylunesChampions:GetPetPersonality()
	if UnitExists("pet") then
		local name, family = self:GetCurrentPet()
		local pct = self.db.profile.PCT[self.db.profile.emoteLocale]
		if pct[name] then
			return pct[name].p
		elseif family and self.BabbleCTE[family] and pct[self.BabbleCTE[family]] then
			return pct[self.BabbleCTE[family]].p
		else
			return "Default"
		end
	else
		return nil
	end
end

----------------------------------------------
-- GetPetSex
----------------------------------------------
function MylunesChampions:GetPetSex()
	local creatureFamily = UnitCreatureFamily("pet")
	if creatureFamily and 
		self.BabbleCTE[creatureFamily] and 
		self.db.profile.PCT[self.db.profile.emoteLocale][self.BabbleCTE[creatureFamily]]
	then
		return self.db.profile.PCT[self.db.profile.emoteLocale][self.BabbleCTE[creatureFamily]].s
	end
	return nil
end
