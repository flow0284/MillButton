local L = LibStub("AceLocale-3.0"):GetLocale("MillButton")
local mill = CreateFrame("Button","MillButton",UIParent,"SecureActionButtonTemplate")
mill:SetAttribute("type","macro")
local item_herb = GetItemSubClassInfo(LE_ITEM_CLASS_TRADEGOODS, 9) --Simple way to get ingame localized ItemType "Herb" through Auctionshouseframe translation
msn = 51005
mill_spell = GetSpellInfo(msn) --SpellID for Milling


local function findherb()
	for bag=0,4 do	--search only in our bags for herbs 0=default bag 1 to 4 additional bagslots
		for slot=1,GetContainerNumSlots(bag) do			--start at slot 1
			local itemID = GetContainerItemID(bag, slot)
			local _, count = GetContainerItemInfo(bag, slot)
			if itemID then
				local itemName, itemLink, _, _, _, _, itemType = GetItemInfo(itemID)
				for i = 1, #MillButtonExpansions do
					if (MillButtonDB[itemID]) and count >= 5 then
						return bag, slot
					end
				end
				for i = 1, #MillButtonExpansions do
					if itemType==item_herb and MillButtonDB[itemID]==false and MillButtonSettings.extended==true then
					local itemName, itemLink, _, _, _, _, itemType = GetItemInfo(itemID)
						DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00MillButton: |r"..count.."x "..itemLink.." "..L["skipped"])
					end
				end
			end
		end
	end
end

function MillButtonSetup()
	local bag, slot = findherb()
	if (not bag or not slot) or LootFrame:IsVisible() or CastingBarFrame:IsVisible() or UnitCastingInfo("player") then
	-- do nothing if no herb, if looting or casting
		MillButton:SetAttribute("macrotext","")
		if not bag then
			DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00MillButton: |r"..L["error"])
		end
	else
		MillButton:SetAttribute("macrotext","/"..L["macro_cast"].." "..mill_spell.."\n/"..L["macro_use"].." "..bag.." "..slot)
	end
end
