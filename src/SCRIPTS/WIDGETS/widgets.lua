local widgetWidthSingle = 32

local widgetWidthMulti = 0
local numSingleCols = 0
local numMultiCols  = 0
local widgets = {}
local layout, nested = ...

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

            if wdgt.opts then
                if type(wdgt.func) ~= "table" then
                    if wdgt.func then
                        lcd.drawText(x+w/2-4, y+h/2-4, "id?", SMLSIZE+BLINK)
                    else
                        lcd.drawRectangle(x, y, w, h)
                    end
                else
                    if wdgt.opts.parent then
                        wdgt.func.run(event, {x=x, y=y, w=w , h=h})
                    else
                        wdgt.func.run({x=x, y=y, w=w , h=h}, event, wdgt.opts)
                    end
                end
            end

            y = y+h
        end

        y = (zone and zone.y) or 0
        x = x + w
    end
end

local function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then
        io.close(f)
        return true
    end

    return
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
                local wdgtFile = "/SCRIPTS/WIDGETS/"..(c.id)..".lua"

                w.opts = c.opts or {}
                w.func = false

                if c.id ~= "" then
                    if file_exists(wdgtFile) then
                        w.func = assert(loadScript(wdgtFile))(event)

                        -- initalize widget
                        if w.func and w.func.init then w.func.init() end
                    else
                        w.func = true
                    end
                end

            end
            widgets[col][row] = w
        end
    end
end

return { init=init, run=run }
