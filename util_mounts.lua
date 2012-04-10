----------------------------------------------
-- Localization
----------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("MylunesChampions", true)

----------------------------------------------
-- GetMountEmotes
----------------------------------------------
function MylunesChampions:GetMountEmotes(event, how)
	local p = self:GetMountPersonality()
	local g = self:GetMountSex()
	return self:GetEmotes(p, g, event, how)
end

----------------------------------------------
-- GetRandomMountEmote
----------------------------------------------
function MylunesChampions:GetRandomMountEmote()
	local s = nil
	
	-- afk
	if UnitIsAFK("player") then
		s = self:GetMountEmotes("EVENT_RANDOM", "afk")
	end
	-- in combat
	if (s == nil) and InCombatLockdown() then
		s = self:GetMountEmotes("EVENT_RANDOM", "incombat")
	end
	-- default
	if s == nil then
		s = self:GetMountEmotes("EVENT_RANDOM", "emotes")
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
-- GetRandomMountEmote
----------------------------------------------
function MylunesChampions:GetRandomMountEmote()
	local s = nil
	
	-- afk
	if UnitIsAFK("player") then
		s = self:GetMountEmotes("EVENT_RANDOM", "afk")
	end
	-- in combat
	if (s == nil) and InCombatLockdown() then
		s = self:GetMountEmotes("EVENT_RANDOM", "incombat")
	end
	-- default
	if s == nil then
		s = self:GetMountEmotes("EVENT_RANDOM", "emotes")
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
-- GetRandomMountEmoteReply
----------------------------------------------
function MylunesChampions:GetRandomMountEmoteReply(emote, how)
	if not how then return nil end
	
	emote = string.gsub(emote, "^EMOTE_", "") -- normalize
	
	local s = self:GetMountEmotes("EMOTE_"..emote, how)
	return MylunesChampions_RandomElement(s)
end

----------------------------------------------
-- GetRandomMountEvent
----------------------------------------------
function MylunesChampions:GetRandomMountEvent(event)
	event = string.gsub(event, "^EVENT_", "") -- normalize

	local s = self:GetMountEmotes("EVENT_"..event, "emotes")
	return MylunesChampions_RandomElement(s)
end

----------------------------------------------
-- MountEmote
----------------------------------------------
function MylunesChampions:MountEmote(msg)
	local name, id = self:GetCurrentMount()
	if name then
		local preface = self.LG["MOUNT"] .. " " .. name .. " "
		local noPossessive = nil
	
		if msg == "" then
			-- random emote
			msg = self:GetRandomMountEmote()
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
		self:Printf(L["NO_MOUNT"])
	end
end

----------------------------------------------
-- GetCurrentMount
-- TODO: cache current mount
-- returns creatureName, creatureID
----------------------------------------------
function MylunesChampions:GetCurrentMount()
	if IsMounted() then
		for i=1,GetNumCompanions("MOUNT") do
			local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("MOUNT", i)
			--self:Debug(d_notice, creatureID .. " " .. creatureName .. " (" .. tostring(issummoned) .. ")")
			if self.db.profile.M[creatureID] == nil then
				self.db.profile.M[creatureID] = { n = creatureName, p = "Default" }
				self:Debug(d_info, "Added mount with ID "..tostring(creatureID).." ("..tostring(creatureName)..").")
			end
			if issummoned then
				return creatureName, creatureID
			end
		end
	end
	return nil, nil
end

----------------------------------------------
-- GetMountPersonality
----------------------------------------------
function MylunesChampions:GetMountPersonality()
	local n, id = self:GetCurrentMount()
	if n then
		if self.db.profile.M[id] then
			return self.db.profile.M[id].p
		else
			return "Default"
		end
	end
	return nil
end

----------------------------------------------
-- GetMountSex
----------------------------------------------
function MylunesChampions:GetMountSex()
	local _, id = self:GetCurrentMount()
	if id and self.db.profile.M[id] and self.db.profile.M[id].s then
		return self.db.profile.M[id].s
	end
	return nil
end
