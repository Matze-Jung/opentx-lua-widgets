-- X9 layout based on https://github.com/lynix/opentx-telemetry <lynix47@gmail.com>
local layout = {
    { {id="X9/tx-batt"} },
    { {id="X9/mode"}, {id="X9/gps"}, {id="X9/timer"} },
    { {id="X9/distance"}, {id="X9/altitude"}, {id="X9/speed"} },
    { {id="X9/rssi"} },
}
local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
