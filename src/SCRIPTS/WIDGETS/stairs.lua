--[[ ** TELEMETRY SCREEN WIDGET **

  Renders a horizontal (L->R) stair graph from a given percent value.


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

        stairs: number (optional, default 5)
          - Stair count

        space: number (optional, default 1)
          - Space between stairs/bars in px

        p: table (optional, default [t=0, r=2, b=0, l=0])
           - Padding between content and widget boundaries in px
             (top, right, bottom, left)
--]]

local function stairsWidget(zone, event, opts)
    local p = { t=0, r=2, b=0, l=0 }
    local stairs = opts.stairs or 5
    local space = opts.space or 1

    local z = calcWidgetZone(zone, p, opts.p or false)
    local val = type(opts.src) == "function"
        and opts.src()
        or getValue(opts.src)

    if opts.lbl then
        lcd.drawFilledRectangle(z.x, z.y, z.w, 8)
        lcd.drawText(z.x + 1, z.y + 1, opts.lbl, SMLSIZE + INVERS)
        z.y = z.y + 9
        z.h = z.h - 8
    end
--lcd.drawRectangle(z.x, z.y, z.w, z.h)
    local hUnit = math.floor(z.h / stairs)


    for i=1, stairs do
        local barW = math.ceil(z.w / stairs)
        local barH = z.h - ((i-1) * hUnit)
        local barY = z.y + z.h - barH
        local barX = z.x + ((stairs - i) * barW)


        if barX + barW > z.x + z.w then
            barW = (((barX - z.x + barW) - z.w) - barW) *-1
        end

        if val > 100 / z.w * (barX - z.x) then
            lcd.drawFilledRectangle(barX + space, barY, barW - space, barH)
        end
    end
end

return { run=stairsWidget }
