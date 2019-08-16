local widgetWidthSingle = 32
local widgetWidthMulti = 0
local numSingleCols = 0
local numMultiCols  = 0
local widgets = {}
local layout, nested = ...

local lcd=LCD or lcd
local LCD_W = lcd.W or LCD_W
local LCD_H = lcd.H or LCD_H

function calcWidgetZone(z, t, t2)
    if not t then
        t = {t=0, r=0, b=0, l=0}
    end

    if t2 then
        for i, v in pairs(t2) do
            t[i] = v
        end
    end

    z.x = t.l+z.x
    z.y = t.t+z.y
    z.w = z.w-t.l-t.r
    z.h = z.h-t.t-t.b

    return z
end

local function run(event, zone)
    if #widgets == 0 then return end

    if not nested then lcd.clear() end

    local x = 0
    local y = 0
    local lcdW = LCD_W

    if zone then
        x = zone.x + x
        y = zone.y + y
        lcdW = zone.w
    end

    widgetWidthMulti = (lcdW - (numSingleCols * widgetWidthSingle)) / numMultiCols

    if numSingleCols == #widgets then
        widgetWidthSingle = math.floor((lcdW / #widgets) + .5)
    end

    for col=1, #widgets do
        local h = math.floor((LCD_H / #widgets[col]) + .5)

        if zone then
            h = math.floor((zone.h / #widgets[col]) + .5)
        end

        local w = #widgets[col] == 1
            and widgetWidthSingle
            or widgetWidthMulti

        for row=1, #widgets[col] do
            local wdgt = widgets[col][row]
--lcd.drawRectangle(x, y, w, h)

            if wdgt.opts.parent then
                wdgt.func.run(event, {x=x, y=y, w=w , h=h})
            else
                wdgt.func.run({x=x, y=y, w=w , h=h}, event, wdgt.opts)
            end

            y = y+h
        end

        y = 0
        x = x + w
    end
end

local function init()
    for col=1, #layout, 1
    do
        if (#layout[col] == 1) then
            numSingleCols = numSingleCols + 1
        else
            numMultiCols = numMultiCols + 1
        end

        widgets[col] = {}
        for row=1, #layout[col], 1 do
            local c = layout[col][row]
            local w = { run=function()end }
            if c.id then
                w.opts = c.opts or {}
                w.func = assert(loadScript("/SCRIPTS/WIDGETS/"..(c.id)..".lua"))(event)

                -- initalize widget
                if w.func.init then w.func.init() end
            end
            widgets[col][row] = w
        end
    end
end

return { init=init, run=run }
