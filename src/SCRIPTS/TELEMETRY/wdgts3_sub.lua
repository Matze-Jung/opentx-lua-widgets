local layout = {
    {
        {
            id="stairs",
            opts={
                lbl="RSSI",
                src=function()
                    local db, low, crit = getRSSI()
                    return (db - crit) * 100 / (99-crit)
                end,
                stairs=8,
                space=1,
                p={b=-2}
            }
        },
        {
            id="stairs",
            opts={
                lbl="RSSI",
                src=function()
                    local db, low, crit = getRSSI()
                    return (db - crit) * 100 / (99-crit)
                end,
                stairs=6,
                space=1,
                p={t=4,r=0,b=-4}
            }
        },
    },
    {
        {
            id="stairs",
            opts={
                lbl="RSSI",
                src=function()
                    local db, low, crit = getRSSI()
                    return (db - crit) * 100 / (99-crit)
                end,
                stairs=5,
                space=1,
                p={r=0,b=-2}
            }
        },
        {
            id="stairs",
            opts={
                lbl="RSSI",
                src=function()
                    local db, low, crit = getRSSI()
                    return (db - crit) * 100 / (99-crit)
                end,
                stairs=7,
                space=1,
                p={t=4,r=0,b=-4}
            }
        },
    },
}
-- set the second param to a true value, if this is nested inside a parent widget
local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout, 1)

return { init=w.init, run=w.run }
