local layout = {
    {
        {
            id="value",
            opts={
                src=function() return getValue("gvar9") > 0 and getValue("gvar9") or 100 end,
                lbl="THR RNG",
                unit="%",
                style=MIDSIZE,
                m={r=12},
            }
        },
        {
            id="value",
            opts={
                src=function() local db = getRSSI() return db end,
                lbl="RSSI",
                unit="dB",
                min=alarm_low,
                style=SMLSIZE,
                m={t=6},
            }
        },
    },
    {
        {
            id="h-bar",
            opts={
                lbl="LQ",
                src=function()
                    local db, low, crit = getRSSI()
                    return (db - crit) * 100 / (91-crit)
                end,
                space=0,
                bg=true,
                m={r=-1,b=-2,l=-10},
            }
        },
        {
            id="value",
            opts={
                src=function() return getGraphRange and getGraphRange(5).min..' / '..getGraphRange(5).max or '?' end,
                lbl="min / max",
                unit="dB",
                style=SMLSIZE,
                m={t=6,r=-1},
            }
        },
    },
}

-- if nested inside a parent layout, set the second param of assert to a true value
local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout, 1)

return { init=w.init, run=w.run }
