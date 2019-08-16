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

        lbl: string (optional)
          - Label text

        max: number (only optional, if 'src' is default)
          - Largest value

        min: number (only optional, if 'src' is default)
          - Smallest value

        p: table (optional, default [t=0, r=2, b=0, l=0])
           - Padding between content and widget boundaries in px
             (top, right, bottom, left)
--]]

local function batteryWidget(zone, event, opts)
    local src = opts.src or "tx-voltage"
    local p = { t=0, r=2, b=0, l=0 }

    local settings = getGeneralSettings()
    local maxV = opts.max or settings.battMax
    local minV = opts.min or settings.battMin
    local format = PREC1 + LEFT
    local cellV = getValue(src)
    local perc =  math.floor(((cellV-minV) * 100 / (maxV-minV)) + 0.5)
    local z = calcWidgetZone(zone, p, opts.p or false)

    if perc <= 0 then perc = 0 end

    if cellV <= minV then
        format = format+BLINK
    end

    if opts.lbl then
        lcd.drawFilledRectangle(z.x, z.y, z.w, 8)
        lcd.drawText(z.x + 1, z.y + 1, opts.lbl, SMLSIZE + INVERS)
    end

    lcd.drawFilledRectangle(z.x+12, z.y+10, 7, 1, 0)
    lcd.drawRectangle(z.x+8, z.y+11, 15, 41)
    lcd.drawRectangle(z.x+9, z.y+12, 13, 39)

    local i = 36
    while i > 0 and i > 36-math.floor(perc * .36) do
        lcd.drawLine(z.x+11, z.y+12+i, z.x+19, z.y+12+i, SOLID, 0)
        i = i-2
    end
    lcd.drawNumber(z.x+7, z.y+54, cellV*10, format)
    lcd.drawText(lcd.getLastPos(), z.y+54, "V", format)
end

return { run=batteryWidget }
