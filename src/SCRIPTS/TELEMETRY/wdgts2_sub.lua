-- NOTE: Layout requires the opentx-lua-running-graphs package installed
--       and the graphs-script running. https://github.com/Matze-Jung/opentx-lua-running-graphs

local layout = {
    {
        {
            id="value",
            opts={
                src=function() return getValue("gvar9") > 0 and getValue("gvar9") or 100 end,
                lbl="THR RNG",
                unit="%",
                style=SMLSIZE,
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
                p={t=4,r=0},
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
                    return (db - crit) * 100 / (99-crit)
                end,
                space=0,
                bg=true,
            }
        },
        {
            id="value",
            opts={
                src=function() return getGraphAverage(5) end,
                lbl="Avrg",
                unit="dB",
                style=SMLSIZE,
                p={t=4,r=0},
            }
        },
    },
}

-- if nested inside a parent layout, set the second param of assert to a true value
local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout, 1)

return { init=w.init, run=w.run }
