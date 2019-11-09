-- NOTE: Layout requires the opentx-lua-running-graphs package installed
--       and the graphs-script running. https://github.com/Matze-Jung/opentx-lua-running-graphs

local layout = {
    {
        {
            id="fmode",
            opts={
                lbl="F-Mode",
                style=MIDSIZE,
                m={r=7},
            }
        },
        {
            id="armcopt",
            opts={
                src=function() return getValue("sb") > 512 end,
                -- src=function() return getValue("ls4") > 0 end,
                -- notxt=true,
                m={t=-4,l=6},
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
                    return (db - crit) * 100 / (91-crit)
                end,
                stairs=16,
                space=0,
                m={r=0,b=7,l=-5},
            }
        },
        {
            id="graph", opts={
                uid=10,
                src="Tmp1",
                lbl="FC Temp",
                unit="\64C",
                speed=600,
                min=30,
                max=90,
                lblmin="30",
                lblmax="90",
                -- crit=80,
                m={t=-4,b=0,l=-22},
                p={t=1,l=11},
            }
        },
    },
}

local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
