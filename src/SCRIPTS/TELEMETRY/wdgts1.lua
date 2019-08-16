local layout = {
    {
        { id="rssi" }
    },
    {
        { id="rssi2" }
    },
    -- {
    --     { id="batt" }
    -- },
    {
        { id="batt2" }
    },
    {
        { id="batt3", opts={src="tx-voltage", lbl="TX Bat", p={r=0}} }
    },
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
