-- esc菜单
function G:OnLogin()
	local gui = CreateFrame("Button", "GameMenuFrameWDui", GameMenuFrame, "GameMenuButtonTemplate, BackdropTemplate")
	gui:SetText(L["NDui Console"])
	--gui:SetPoint("TOP", GameMenuButtonAddons, "BOTTOM", 0, -21)
	gui:SetPoint("TOP", GameMenuFrame, "TOP", 0, -35)
	GameMenuFrame:HookScript("OnShow", function(self)
		GameMenuButtonHelp:SetPoint("TOP", gui, "BOTTOM", 0, -5)
		self:SetHeight(self:GetHeight() + gui:GetHeight() + 22)
	end)

	gui:SetScript("OnClick", function()
		if InCombatLockdown() then UIErrorsFrame:AddMessage(DB.InfoColor..ERR_NOT_IN_COMBAT) return end
		OpenGUI()
		HideUIPanel(GameMenuFrame)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
	end)

	if C.db["Skins"]["BlizzardSkins"] then B.Reskin(gui) end
end


-- 系统插件菜单
local eventFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
	eventFrame:SetScript("OnEvent", function(self, event, loadedAddon)
		if loadedAddon ~= addonName then return end
        SlashCmdList.BugSack = function(msg)
			msg = msg:lower()
			if msg == "show" then
				addon:OpenSack()
			else
				InterfaceOptionsFrame_OpenToCategory(addonName)
				InterfaceOptionsFrame_OpenToCategory(addonName)
			end
		end
		SLASH_BugSack1 = "/bugsack"

		-- self:SetScript("OnEvent", nil)
	end)
	eventFrame:RegisterEvent("ADDON_LOADED")
	addon.frame = eventFrame
end


local addonName, addon = ...
local frame = addon.frame
frame.name = addonName
frame:Hide()

frame:SetScript("OnShow", function(frame)

	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(addonName)


	frame:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame)

