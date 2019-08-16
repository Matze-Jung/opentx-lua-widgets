local rssi, alarm_low, alarm_crit = getRSSI()
local layout = {
    {
        { id="batt3", opts={src="tx-voltage", lbl="TX Bat"} }
    },
    -- {
    --     { id="batt3", opts={src="tx-voltage", lbl="txV"} }
    -- },
    {
        -- set opts.parent to a true value, if it should call a nested/sub widget
        { id="../TELEMETRY/wdgts2_sub", opts={parent=1} },
        { id="graph",
            opts={
                uid=5,
                src=function() local x = getRSSI() return x end,
                speed=100,
                min=alarm_crit,
                max=99,
                crit=alarm_low,
                -- lblmax=99,
                -- lblmin=alarm_crit,
                p={t=6,l=1}
            }
        },
    }
}
local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
