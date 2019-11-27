--[[ ** TELEMETRY SCREEN WIDGET **

  Draws a string/number/timer from a given source.


  PLATFORM
    X7, X9 and relatives

  SCALING
    vert: scalable
    horiz: scalable

  PARAMETER
    zone: table [x, y, w, h]
      - Location on display in px
        (x-pos, y-pos, width, height)

    event: int
      - User event

    opts: table
      - Configurations

        src: function or sensor-ID string/number (optional, default "tx-voltage")
          - Data source

        lbl: string (optional)
          - Label text

        unit: string (optional)
          - Unit sign drawn behind the value
          - Set to "timer", to display as timer (00:00)
          - Set to "%", to output percent of 'src', calculated with 'min' and 'max'

        style: int (optional, default 0)
          - Text Attributes: 0, DBLSIZE, MIDSIZE, SMLSIZE, INVERS, BLINK, XXLSIZE, LEFT
            All att values can be combined together using the + character. ie BLINK + DBLSIZE

        max: number (only optional, if 'unit' is not "%")
          - Largest value

        min: number (only optional, if 'unit' is not "%")
          - Smallest value

        m: table (optional, default [t=0, r=0, b=0, l=0])
           - Cell margin in px
             (top, right, bottom, left)
--]]

local function valueWidget(zone, event, opts)
    local formatNum = opts.style or 0
    local format = bit32.btest(formatNum, PREC1) and bit32.bxor(formatNum, PREC1) or formatNum
    local z = calcWidgetZone(zone, false, opts.m or false)
    local val = type(opts.src) == "function"
        and opts.src()
        or getValue(opts.src)

    if (opts.min and opts.min >= val) or (opts.max and opts.max <= val) then
        if not bit32.btest(format, BLINK) then
          format = format + BLINK
          formatNum = formatNum + BLINK
        end
    end

    if opts.unit == "%" and opts.max and opts.min then
        val = (val + opts.max) * 100 / (opts.max-opts.min)
        if val < 0 then val = 0 end
        if val > 100 then val = 100 end
    end

    if opts.lbl then
        lcd.drawFilledRectangle(z.x, z.y, z.w, 8)
        lcd.drawText(z.x + 1, z.y + 1, opts.lbl, SMLSIZE + INVERS)
        z.y = z.y + 9
        z.h = z.h - 8
    end

    if opts.unit and opts.unit == "timer" then
        lcd.drawTimer(z.x + 1, z.y, val, format)
    else
        if type(val) == "string" then
            lcd.drawText(z.x + 1, z.y, val, format)
        else
            lcd.drawNumber(z.x + 1, z.y, val, formatNum)
        end
        lcd.drawText(lcd.getLastPos() + 1, z.y, opts.unit or "", format)
    end
end

return { run=valueWidget }
