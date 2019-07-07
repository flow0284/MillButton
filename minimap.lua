addon = LibStub("AceAddon-3.0"):NewAddon("MillButton", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("MillButton")
local MillButtonLDB = LibStub("LibDataBroker-1.1"):NewDataObject("MillButtonIcon", {
	type = "launcher",
	text = "MillButton",
	icon = "Interface\\Icons\\Ability_Miling",
	OnClick = function(_, button) 
		if button == "LeftButton" then
			if InterfaceOptionsFrame:IsVisible() then
				InterfaceOptionsFrame:Hide()
				-- Hide the UI panel behind blizz options.
				HideUIPanel(GameMenuFrame)
			else
			InterfaceOptionsFrame_OpenToCategory("MillButton")
			Options:SetScript("OnShow", nil)
			end
		end
		if button == "RightButton" then
			MillButtonSetup()
		end
	end,
	OnTooltipShow = function(tooltip)
		tooltip:SetText("MillButton")
		tooltip:AddLine(GetAddOnMetadata(ADDON, "Version"),1,1,1)
		tooltip:AddLine(" ")
		tooltip:AddLine(L["r_mouse1"]..": |cFFFFFFFF"..L["r_mouse2"].."|r")
		tooltip:AddLine(L["l_mouse1"]..": |cFFFFFFFF"..L["l_mouse2"].."|r")
		tooltip:Show()
	end
})

local icon = LibStub("LibDBIcon-1.0")

function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("MillButtonMinimap", {
		profile = {
			minimap = {
				hide = false,
			},
		},
	})
	icon:Register("MillButtonIcon", MillButtonLDB, self.db.profile.minimap)
	self:RegisterChatCommand("mbtnmmap", "ComMbtnMiniMapIcn")
end

function addon:ComMbtnMiniMapIcn()
	self.db.profile.minimap.hide = not self.db.profile.minimap.hide
	if self.db.profile.minimap.hide then
		icon:Hide("MillButtonIcon")
	else
		icon:Show("MillButtonIcon")
	end
end