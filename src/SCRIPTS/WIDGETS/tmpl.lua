--[[ ** TELEMETRY SCREEN WIDGET **

  Template to create a new widget.


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
          - Data source

        m: table (optional, default [t=0, r=0, b=0, l=0])
           - Cell margin in px
             (top, right, bottom, left)
--]]

local function tmplWidget(zone, event, opts)
    local m = { t=0, r=0, b=0, l=0 }

    local z = calcWidgetZone(zone, m, opts.m or false)
    local val = type(opts.src) == "function"
        and opts.src()
        or getValue(opts.src)

    -- ...
end

return { run=tmplWidget }
