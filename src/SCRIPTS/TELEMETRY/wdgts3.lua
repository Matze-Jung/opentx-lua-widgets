local layout = {
    {
        {
            id="h-bar",
            opts={
                lbl="TX Batt",
                src=function()
                    local settings = getGeneralSettings()
                    return math.floor(((getValue("tx-voltage")-settings.battMin) * 100 / (settings.battMax-settings.battMin)) + 0.5)
                end,
                space=1,
                bg=true,
                m={b=3},
            }
        },
        {
            id="stairs",
            opts={
                lbl="VFAS",
                src=function()
                    local min = 14
                    local max = 16.8
                    return math.floor(((getValue("VFAS")-min) * 100 / (max-min)) + 0.5)
                end,
                stairs=8,
                space=1,
                m={b=2},
            }
        },
        {
            id="value",
            opts={
                lbl="Mem used",
                src=function() return MEMORY or 0 end,
                unit="B",
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
                min=350,
                style=PREC2+MIDSIZE,
                m={l=2},
            }
        },
        {
            id="value",
            opts={
                lbl="Cell ("..(type(getValue("Cels")) == "table" and #(getValue("Cels")) or "?").."S)",
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
                min=350,
                style=PREC2+MIDSIZE,
                m={l=2},
            }
        },
        {
            id="value",
            opts={
                lbl="THR Timer",
                src=function() return getValue("timer1") end,
                unit="timer",
                style=MIDSIZE,
                m={l=2},
            }
        },
    },
    {
        { id="rssi" },
    },
}

local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
