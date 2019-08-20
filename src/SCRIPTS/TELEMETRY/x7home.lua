local layout = {
    {
        {
            id="stairs",
            opts={
                lbl="TX Batt",
                src=function()
                    local settings = getGeneralSettings()
                    return math.floor(((getValue("tx-voltage")-settings.battMin) * 100 / (settings.battMax-settings.battMin)) + 0.5)
                end,
                stairs=8,
                space=1,
                p={r=0,b=3}
            }
        },
        {
            id="stairs",
            opts={
                lbl="VFAS",
                src=function()
                    local settings = getGeneralSettings()
                    local min = 14
                    local max = 16.8
                    return math.floor(((getValue("VFAS")-min) * 100 / (max-min)) + 0.5)
                end,
                stairs=8,
                space=1,
                p={r=0,b=3}
            }
        },
        {
            id="value",
            opts={
                lbl="THR Timer",
                src=function() return getValue("timer1") end,
                unit="timer",
            }
        },
    },
    {
        {
            id="value",
            opts={
                lbl="Cell (2S)",
                src=function()
                    return getValue("tx-voltage") / 2 * 100
                end,
                unit="V",
                min=3.5,
                style=PREC2,
            }
        },
        {
            id="value",
            opts={
                lbl="Cells",
                src=function()
                    local cels = getValue("Cels")
                    if type(cels) == "number" then return 0 end
                    local sum = 0
                    for i=1, #cels do
                        sum = sum + cels[i]
                    end
                    return sum / #cels * 100
                end,
                unit="V",
                min=3.5,
                style=PREC2,
            }
        },
        {
            id="value",
            opts={
                src=function() return getValue("ls4") > 0 and "ARMED" or "" end,
                style=BLINK + MIDSIZE,
                p={t=4,l=1},
            }
        },
    },
    {
        { id="rssi" },
    },
}

local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
