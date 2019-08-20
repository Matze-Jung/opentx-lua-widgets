-- NOTE: Layout requires the opentx-lua-running-graphs package installed
--       and the graphs-script running. https://github.com/Matze-Jung/opentx-lua-running-graphs

local layout = {
    {
        {
            id="graph",
            opts={
                uid=7,
                src="thr",
                lbl="THR",
                unit="%",
                speed=35,
                min=-1000,
                max=1000,
                lblmax="max",
                lblmin="min",
                p={l=18}
            }
        },
        {
            id="graph",
            opts={
                uid=8,
                src=function() return getGraphAverage(7) end,
                lbl="THR AVRG",
                unit="%",
                speed=70,
                min=-1000,
                max=1000,
                lblmax="max",
                lblmin="min",
                p={l=18}
            }
        },
    },
}

local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
