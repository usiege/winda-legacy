print("Hello, winda!")
-- print("Hello, |cFFFF0000winda|r!")
-- print("\124cFF00FF00Hello\124r, winda!")



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
