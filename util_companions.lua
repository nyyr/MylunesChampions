----------------------------------------------
-- Localization
----------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("MylunesChampions", true)

----------------------------------------------
-- GetCompanionEmotes
----------------------------------------------
function MylunesChampions:GetCompanionEmotes(event, how)
	local p = self:GetCompanionPersonality()
	local g = self:GetCompanionSex()
	return self:GetEmotes(p, g, event, how)
end

----------------------------------------------
-- GetRandomCompanionEmote
----------------------------------------------
function MylunesChampions:GetRandomCompanionEmote()
	local s = nil
	
	-- afk
	if UnitIsAFK("player") then
		s = self:GetCompanionEmotes("EVENT_RANDOM", "afk")
	end
	-- in combat
	if (s == nil) and InCombatLockdown() then
		s = self:GetCompanionEmotes("EVENT_RANDOM", "incombat")
	end
	-- default
	if s == nil then
		s = self:GetCompanionEmotes("EVENT_RANDOM", "emotes")
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
-- GetRandomCompanionEmoteReply
----------------------------------------------
function MylunesChampions:GetRandomCompanionEmoteReply(emote, how)
	if not how then return nil end
	
	emote = string.gsub(emote, "^EMOTE_", "") -- normalize
	
	local s = self:GetCompanionEmotes("EMOTE_"..emote, how)
	if s then
		return MylunesChampions_RandomElement(s)
	else
		if how == "youAtPet" then
			return self:GetRandomCompanionEmoteReply(emote, "someoneAtPet")
		end
	end
	
	return nil
end

----------------------------------------------
-- GetRandomCompanionEvent
----------------------------------------------
function MylunesChampions:GetRandomCompanionEvent(event)
	event = string.gsub(event, "^EVENT_", "") -- normalize

	local s = self:GetCompanionEmotes("EVENT_"..event, "emotes")
	return MylunesChampions_RandomElement(s)
end

----------------------------------------------
-- CompanionEmote
----------------------------------------------
function MylunesChampions:CompanionEmote(msg)
	--self:Debug(d_notice, "CompanionEmote: " .. tostring(msg))
	
	local name, id = self:GetCurrentCompanion()
	if name then
		local preface = self.LG["COMPANION"] .. " " .. name .. " "
		local noPossessive = nil
		if id == 52894 then -- Ohgan'aka ;)
			preface = "'aka "
			noPossessive = true
		end
	
		if msg == "" then
			-- random emote
			msg = self:GetRandomCompanionEmote()
			self:DoEmote(preface .. msg, noPossessive)
			
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
					self:DoEmote(preface .. msg, noPossessive)
				end
			else
				self:Printf(L["EMOTE_NOT_FOUND"], msg)
			end
			
		else
			self:DoEmote(preface .. msg, noPossessive)
		end
	else
		self:Printf(L["NO_COMPANION"])
	end
end

----------------------------------------------
-- GetCurrentCompanion
-- TODO: cache current companion
-- returns creatureName, creatureID
----------------------------------------------
function MylunesChampions:GetCurrentCompanion()
	local petID = C_PetJournal.GetSummonedPetID()
	local speciesID, customName, level, xp, maxXp, displayID, petName, petIcon, petType, creatureID, 
		sourceText, description, isWild, canBattle, tradable, unique = C_PetJournal.GetPetInfoByPetID(petID)

	return petName, creatureID
--[[
	for i=1,GetNumCompanions("CRITTER") do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("CRITTER", i)
		--self:Debug(d_notice, creatureID .. " " .. creatureName .. " (" .. tostring(issummoned) .. ")")
		if self.db.profile.C[creatureID] == nil then
			self.db.profile.C[creatureID] = { n = creatureName, p = "Default" }
			self:Debug(d_info, "Added companion with ID "..tostring(creatureID).." ("..tostring(creatureName)..").")
		end
		if issummoned then
			return creatureName, creatureID
		end
	end
	return nil, nil
]]
end

----------------------------------------------
-- GetCompanionPersonality
----------------------------------------------
function MylunesChampions:GetCompanionPersonality()
	local n, id = self:GetCurrentCompanion()
	if n then
		if self.db.profile.C[id] then
			return self.db.profile.C[id].p
		else
			return "Default"
		end
	end
	return nil
end

----------------------------------------------
-- GetCompanionSex
----------------------------------------------
function MylunesChampions:GetCompanionSex()
	local _, id = self:GetCurrentCompanion()
	if id and self.db.profile.C[id] and self.db.profile.C[id].s then
		return self.db.profile.C[id].s
	end
	return nil
end
