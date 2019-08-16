local layout = {
    {
        {   id="stairs",
            opts={
                lbl="TX Bat",
                src=function()
                    local settings = getGeneralSettings()
                    return (getValue("tx-voltage") - settings.battMin) * 100 / (settings.battMax-settings.battMin)
                end,
                stairs=10,
                space=2
            }
        }
    },
    {
        -- set opts.parent to a true value, if it should call a nested/sub widget
        { id="../TELEMETRY/wdgts3_sub", opts={parent=1} },
        {
            id="stairs",
            opts={
                src=function()
                    local settings = getGeneralSettings()
                    return (getValue("tx-voltage") - settings.battMin) * 100 / (settings.battMax-settings.battMin)
                end,
                stairs=20,
                space=2,
                p={t=4,r=0,b=0}
            }
        },
    }
}
local w = assert(loadScript("/SCRIPTS/WIDGETS/widgets.lua"))(layout)

return { init=w.init, run=w.run }
