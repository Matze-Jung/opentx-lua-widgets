--[[ ** TELEMETRY SCREEN WIDGET **

  Draws a horizontal (L->R) bar from a given percent value.


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

        src: function or sensor-ID string/number
          - Data source in percent (0..100)

        lbl: string (optional)
          - Label text

        space: number (optional, default 0)
          - Divide bar with vert spaces in px

        bg: bool (optional, default false)
          - Show background

        m: table (optional, default [t=0, r=0, b=0, l=0])
           - Cell margin in px
             (top, right, bottom, left)
--]]

local function barWidget(zone, event, opts)
    local z = calcWidgetZone(zone, false, opts.m or false)
    local val = type(opts.src) == "function"
        and opts.src()
        or getValue(opts.src)

    if opts.lbl then
        lcd.drawFilledRectangle(z.x, z.y, z.w, 8)
        lcd.drawText(z.x + 1, z.y + 1, opts.lbl, SMLSIZE + INVERS)
        z.y = z.y + 9
        z.h = z.h - 8
    end

    local lnX = z.x
    local spc = opts.space or 0

    for i=1, z.w, 1 do
        if val > 100 / z.w * (lnX - z.x) then
            lnX = z.x + i + i * spc
            lcd.drawLine(lnX-1, z.y, lnX-1, z.y + z.h, SOLID, 0)
        else
            if opts.bg and lnX/2 == math.floor(lnX/2) and lnX < z.x + z.w then
                for j=0, z.h, 2 do
                    lcd.drawPoint(lnX + (val > 1 and spc or 0), z.y + j)
                end
            end
            lnX = lnX + 1
        end
    end
end

return { run=barWidget }
