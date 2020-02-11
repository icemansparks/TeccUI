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


-----------------------------------------------------------
------------------- small QoL functions -------------------
-----------------------------------------------------------

--message('Hello World!')


local soundChannels = tonumber(GetCVar("Sound_NumChannels")) or 24--if set to 24, may return nil, Defaults usually do
--If this messes with your fps, stop raiding with a toaster. It's only fix for addon sound ducking.
if soundChannels > 48 then
	SetCVar("Sound_NumChannels", 48)
end
