--[[ ** TELEMETRY SCREEN WIDGET **

  Renders a vertical (B->T) RSSI bar indicator using getRSSI().


  PLATFORM
    X7, X9 and relatives

  SCALING
    vert: display height, fixed
    horiz: scalable

  PARAMETER
    zone: table [x, y, w, h]
      - Location on display in px
        (x-pos, y-pos, width, height)

    event: int
      - User event

    opts: table
      - Configurations

        m: table (optional, default [t=0, r=0, b=0, l=0])
           - Cell margin in px
             (top, right, bottom, left)
--]]

local function rssiWidget(zone, event, opts)
    local pxRng = 45

    local z = calcWidgetZone(zone, false, opts.m or false)
    local db, alarm_low, alarm_crit = getRSSI()
    local perc = math.floor(((db-alarm_crit) * 100 / (91-alarm_crit)) + 0.5)
    local format = 0

    if perc <= 0 then perc = 0 end

    if db <= alarm_low then
        format = format+BLINK
    end

    local wOfs = 1
    local i = pxRng
    while i > 0 and i > pxRng-math.floor(perc * (pxRng/100)) do
        local x1 = z.x+14-wOfs
        local y1 = z.y+2+i
        local x2 = z.x+16+wOfs
        local y2 = z.y+2+i

        lcd.drawLine(x1, y1, x2, y2, SOLID, 0)
        lcd.drawLine(x1+1, y1+1, x2-1, y2+1, SOLID, 0)

        i = i-4
        wOfs = wOfs + 1
    end
    lcd.drawText(z.x + 5, z.y + z.h - 11, db .. "dB", format)
end

return { run=rssiWidget }
