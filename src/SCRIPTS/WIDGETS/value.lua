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

        p: table (optional, default [t=0, r=2, b=0, l=0])
           - Padding between content and widget boundaries in px
             (top, right, bottom, left)
--]]

local function valueWidget(zone, event, opts)
    local p = { t=0, r=2, b=0, l=0 }
    local format = opts.style or 0

    local z = calcWidgetZone(zone, p, opts.p or false)
    local val = type(opts.src) == "function"
        and opts.src()
        or getValue(opts.src)
    local tOfs = 0

    if (opts.min and opts.min >= val) or (opts.max and opts.max <= val) then
        format = format + BLINK
    end

    if opts.unit == "%" and opts.max and opts.min then
        val = (val + opts.max) * 100 / (opts.max-opts.min)
        if val < 0 then val = 0 end
        if val > 100 then val = 100 end
    end

    if opts.lbl then
        tOfs = 10
        lcd.drawFilledRectangle(z.x, z.y, z.w, 8)
        lcd.drawText(z.x + 1, z.y + 1, opts.lbl, SMLSIZE + INVERS)
    end

    if opts.unit and opts.unit == "timer" then
        lcd.drawTimer(z.x + 1, z.y + tOfs, val, format)
    else
        if type(val) == "string" then
            lcd.drawText(z.x + 1, z.y + tOfs, val, format)
        else
            lcd.drawNumber(z.x + 1, z.y + tOfs, val, format)
        end
        lcd.drawText(lcd.getLastPos() + 1, z.y + tOfs, opts.unit or "", format)
    end
end

return { run=valueWidget }
