-- local rssi, alarm_low, alarm_crit = getRSSI()
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
                p={r=0,b=3} --???
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
                p={r=0,b=3} --???
            }
        },
        -- {
        --     id="value",
        --     opts={
        --         lbl="Model",
        --         src=function() local m = model.getInfo() return m.name end,
        --     }
        -- },
        -- {
        --     id="value",
        --     opts={
        --         lbl="VFAS",
        --         src="VFAS",
        --         unit="V",
        --         min=14,
        --     }
        -- },
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
        -- {
        --     id="value",
        --     opts={
        --         lbl="F-Mode",
        --         src=function()
        --             return getValue("gvar8") > 0 and getValue("gvar8") or "N/A"
        --         end,
        --         unit="",
        --     }
        -- },
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
        { id="rssi" }
    },
    -- {
    --     { id="rssi", opts={p={l=0}} }
    -- },
    -- {
    --     { id="graph", opts={uid=5, src="thr", lbl="THR", unit="%", speed=50, min=-1000, max=1000, lblmax="max", lblmin="min", p={r=18}} },
    --     { id="graph", opts={uid=6, src=function() return getGraphAverage(5) end, lbl="THR AVRG", unit="%", speed=50, min=-1000, max=1000, lblmax="max", lblmin="min", p={r=18}} },
    --     --[[,"../TELEMETRY/graph3"--]]
    -- },
    -- {"fm", "gps", "timer"},
    -- {"distance", "altitude", "speed"},
--    {"batt"},
    -- {"rssi"},
}
local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
