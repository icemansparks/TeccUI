-----------------------------------------------------------
-------------------- basic slash commands -----------------
-----------------------------------------------------------

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

SLASH_FRAMESTK1 = "/fs"
SlashCmdList.FRAMESTK = function()
	LoadAddOn('Blizzard_DebugTools')
	FrameStackTooltip_Toggle()
end

SLASH_TIMER1 = "/timer"
SlashCmdList.TIMER = function()
	Stopwatch_StartCountdown(0, 0, 0)
	Stopwatch_Play()
end

SLASH_TIMERTHIRTY1 = "/timer30"
SlashCmdList.TIMERTHIRTY = function()
	Stopwatch_StartCountdown(0, 0, 30)
	Stopwatch_Play()
end



for i = 1, NUM_CHAT_WINDOWS do
	_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
end


-- Shaman Coloring
RAID_CLASS_COLORS["SHAMAN"] = {r = 050 / 255, g = 111 / 255, b = 255 / 255, colorStr = "ff326fff"}

-----------------------------------------------------------
------------------- small QoL functions -------------------
-----------------------------------------------------------

local soundChannels = tonumber(GetCVar("Sound_NumChannels")) or 24--if set to 24, may return nil, Defaults usually do
--If this messes with your fps, stop raiding with a toaster. It's only fix for addon sound ducking.
if soundChannels > 48 then
	SetCVar("Sound_NumChannels", 48)
end


--- raid member alpha


local opacity = 0.3 -- Set the visibility, 0 being invisible



local t={}
for i=1,8 do
  t[i] = {}
  for j=1,5 do
     t[i][j] = string.format("CompactRaidGroup%dMember%d", i,j)
  end
end

local r={}
for i=1,40 do
  r[i] = string.format("CompactRaidFrame%d", i) 
end

local raidtimer = 0
local raid_frame = CreateFrame("Frame")
local x,y,z,w
local function raid_update(self, elapsed)
  raidtimer = raidtimer + elapsed
  if ( raidtimer > 0.1 ) then
    raidtimer = 0
    if w then
      
      --Keep Groups Together Unchecked
      for i=1,w do
        x = _G[r[i]]
        if x then
          if x:GetAlpha()<0.8 then
            y=opacity
          else
            y=1
          end
          z= select(1,x:GetRegions()):GetAlpha()
          if z then
            if abs(y - z) > 0.2 then
              --print(y)print(select(1,x:GetRegions()):GetAlpha())
              select(1,x:GetRegions()):SetAlpha(y) -- Background
              select(7,x:GetRegions()):SetAlpha(y) -- Name Text
              select(1,x:GetChildren()):SetAlpha(y) -- Health Bar
              select(2,x:GetChildren()):SetAlpha(y) -- Mana Bar
            end
          end
        end
      end
      
      --Keep Groups Together Checked
      for i=1,8 do
        for j=1,5 do
          x = _G[t[i][j]]
          
          if x then
            if x:GetAlpha()<0.8 then
              y=opacity
            else
              y=1
            end
            z= select(1,x:GetRegions()):GetAlpha()
            if z then
              if abs(y - z) > 0.2 then
                --print(y)print(select(1,x:GetRegions()):GetAlpha())
                select(1,x:GetRegions()):SetAlpha(y) -- Background
                select(7,x:GetRegions()):SetAlpha(y) -- Name Text
                select(1,x:GetChildren()):SetAlpha(y) -- Health Bar
                select(2,x:GetChildren()):SetAlpha(y) -- Mana Bar
              end
            end
          end
          
        end
      end
    else
      --print("Blizz_Raid_Fader Disabled")
      raid_frame:SetScript("OnUpdate", nil)
    end
  end
end


local begin_frame = CreateFrame("Frame")
local function begin()
  w=UnitInRaid("player")
  if w then
    --print("Blizz_Raid_Fader Loaded")
    raid_frame:SetScript("OnUpdate", raid_update)
  else
    raid_frame:SetScript("OnUpdate", nil)
  end
end

begin_frame:SetScript("OnEvent", begin)
begin_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
--begin_frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
begin_frame:RegisterEvent("GROUP_ROSTER_UPDATE")
begin_frame:RegisterEvent("RAID_ROSTER_UPDATE")
