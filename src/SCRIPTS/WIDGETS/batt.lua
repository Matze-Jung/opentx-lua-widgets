--[[ ** TELEMETRY SCREEN WIDGET **

  Renders a vertical (B->T) battery picto from a given source.


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

        src: sensor-ID string/number (optional, default "tx-voltage")
          - Data source

        max: number (only optional, if 'src' is default)
          - Largest value

        min: number (only optional, if 'src' is default)
          - Smallest value

        m: table (optional, default [t=0, r=0, b=0, l=0])
           - Cell margin in px
             (top, right, bottom, left)
--]]

local function batteryWidget(zone, event, opts)
    local src = opts.src or "tx-voltage"

    local settings = getGeneralSettings()
    local maxV = opts.max or settings.battMax
    local minV = opts.min or settings.battMin
    local cellRange = maxV - minV
    local availV = 0
    local z = calcWidgetZone(zone, m, opts.m or false)
    local cellV = getValue(src)

    lcd.drawFilledRectangle(z.x+13, z.y+7, 5, 2, 0)
    lcd.drawRectangle(z.x+10, z.y+9, 11, 40)

    if cellV > maxV then
        availV = cellRange
    elseif cellV > minV then
        availV = cellV - minV
    end
    local availPerc = math.floor(availV / cellRange * 100)

    local myPxHeight = math.floor(availPerc * 0.37)
    local myPxY = 11 + 37 - myPxHeight
    if availPerc > 0 then
        lcd.drawFilledRectangle(z.x+11, myPxY, 9, myPxHeight, 0)
    end

    local i = 36
    while (i > 0) do
        lcd.drawLine(z.x+12, z.y+10+i, z.x+18, z.y+10+i, SOLID, INVERS)
        i = i-2
    end

    local style = 0
    if (cellV < minV) then
        style = style + BLINK
    end
    lcd.drawText(z.x+7, z.y+54, string.format("%.1f", cellV) .. "V", style)
end

return { run=batteryWidget }
