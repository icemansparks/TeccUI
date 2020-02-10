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
