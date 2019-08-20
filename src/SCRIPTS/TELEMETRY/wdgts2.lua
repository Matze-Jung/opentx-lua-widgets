-- NOTE: Layout requires the opentx-lua-running-graphs package installed
--       and the graphs-script running. https://github.com/Matze-Jung/opentx-lua-running-graphs

local rssi, alarm_low, alarm_crit = getRSSI()
local layout = {
    {
        { id="batt3", opts={src="tx-voltage", lbl="TX Bat"} },
    },
    {
        { id="../TELEMETRY/wdgts2_sub", opts={parent=1} }, -- to call a nested layout, set opts.parent to a true value
        { id="graph", opts={
                uid=5,
                src=function() local x = getRSSI() return x end,
                speed=100,
                min=alarm_crit,
                max=99,
                crit=alarm_low,
                p={t=6,l=1}
            }
        },
    },
}

local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
