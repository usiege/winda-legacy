print("|cFF00FF00Hello|r, |cFFFF0000winda|r!")

-- 创建一个可以显示的框
local f = CreateFrame("Frame", "WindaGUI", UIParent, "BackdropTemplate")
f:SetWidth(200)
f:SetHeight(200)
f:SetFrameLevel(1)
f:SetPoint("CENTER", 0, 0)
f:SetFrameStrata("HIGH")
f:SetBackdrop({
    bgFile = "Interface/AddOns/winda/winda256.png", 
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = false,
    tileEdge = false,
    tileSize = 0,
    edgeSize = 1,
    insets = { left = 1, right = 1, top = 1, bottom = 1 }
})
f:SetBackdropBorderColor(0, 0, 0, 1)

-- 默认情况下是显示的状态
f:Hide()
-- 显示
--f:Show()

-- 在f上创建一个可以显示的取消按钮
-- 使点击时关闭这个窗口
local cf = CreateFrame("Button", nil, f)
cf:SetPoint("TOPRIGHT", -5, -5)
cf:SetWidth(20); cf:SetHeight(20)
cf:SetFrameStrata("HIGH")
cf:SetFrameLevel(2)
local texture = cf:CreateTexture(nil, "BACKGROUND")
texture:SetTexture("Interface/AddOns/winda/cancel.png")
texture:SetAllPoints()
cf:RegisterForClicks("AnyUp", "AnyDown")
cf:SetScript("OnClick", function (self, button, down)
    -- 点击隐藏大窗口
    if down then
        f:Hide()
    end
end)

-- 宏命令
SLASH_WINDA1 = "/wd"
SLASH_WINDA2 = "/winda"
SlashCmdList["WINDA"] = function()
    -- print("|cFFFF0000Hello, |r\124cFF00FF00winda!\124r")
    if f:IsShown() then
        f:Hide()
        print("窗口消失")
    else
        f:Show()
        print("窗口出现")
    end
end

SLASH_RELOADUI1 = "/rl"
SlashCmdList["RELOADUI"] = function (msg)
    ReloadUI()
end



-- 小地图按钮
local mf = CreateFrame("Button", "MiniMapButton", Minimap)
mf:SetWidth(32)
mf:SetHeight(32)
mf:SetFrameStrata("LOW")
mf:Raise()
mf:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, 0)
mf:SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot-Depress")
mf:SetHighlightTexture("Interface\\buttons\\iconborder-glowring")

-- 创建小地图上的图标
local icon = mf:CreateTexture(nil, "BACKGROUND")
icon:SetWidth(32)
icon:SetHeight(32)
icon:SetPoint("CENTER", mf, "CENTER", 0, 0)
icon:SetTexture("Interface\\Icons\\INV_Misc_Coin_08")
mf.icon = icon

-- 按钮上的提示
mf:SetScript("OnEnter", function()
    GameTooltip:SetOwner(mf, "ANCHOR_LEFT")
    GameTooltip:AddLine("|cff1eff00左键:|r 隐藏/显示")
    GameTooltip:Show()
end)
mf:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- 按钮点击
mf:SetScript("OnClick", function()
    if f:IsShown() then
        f:Hide()
        print("窗口消失")
    else
        f:Show()
        print("窗口出现")
    end
end)


-- 添加一个系统菜单按钮
-- 在添加之前，我们应该知道这个按钮需要添加到哪
-- 添加到系统菜单 GameMenuFrame 上
local gui = CreateFrame("Button", "WindaGUIButton", GameMenuFrame,
"GameMenuButtonTemplate, BackdropTemplate")
gui:SetText("winda 控制台")
gui:SetPoint("TOP", GameMenuFrame, "TOP", 0, -35)
GameMenuFrame:HookScript("OnShow", function(self)
    GameMenuButtonHelp:SetPoint("TOP", gui, "BOTTOM", 0, -5)
    self:SetHeight(self:GetHeight() + gui:GetHeight() + 22)
end)
-- 再来添加点击该按钮的事件
-- 点击显示窗口f
-- 并隐藏掉系统菜单
gui:SetScript("OnClick", function ()
    print("打开winda系统菜单")
    f:Show()
    HideUIPanel(GameMenuFrame)
end)

-- 在设置选项菜单的插件标签下添加一个winda文字显示
-- 这次的父窗口叫做 InterfaceOptionsFramePanelContainer
local sf = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
sf:SetScript("OnEvent", function (self, event, loadedAddon)
    if loadedAddon ~= "winda" then return end
end)
sf:RegisterEvent("ADDON_LOADED")
sf:SetScript("OnShow", function (sf)
    -- 显示标题
    local title = sf:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("winda".." v"..tostring(GetAddOnMetadata("winda", "Version")))
    
    -- 只在显示时加载
    sf:SetScript("OnShow", nil)
end)
sf.name = "winda"
sf:Hide()
InterfaceOptions_AddCategory(sf)

