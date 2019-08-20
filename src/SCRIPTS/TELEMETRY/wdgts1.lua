local layout = {
    {
        { id="rssi" },
    },
    {
        { id="rssi2" },
    },
    {
        { id="batt2" },
    },
    {
        { id="batt3", opts={src="tx-voltage", lbl="TX Bat", p={r=0}} },
    },
}

local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
