--[[ ** TELEMETRY SCREEN WIDGET **

  Outputs a string representing the actual flight mode.

  NOTE: This is a wrapper function using valueWidget() [WIDGETS/value.lua].
        Define source and flightmodes below.


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

      lbl: string (optional)
        - Label text

      style: int (optional, default 0)
        - Text Attributes: 0, DBLSIZE, MIDSIZE, SMLSIZE, INVERS, BLINK, XXLSIZE, LEFT
          All att values can be combined together using the + character. ie BLINK + DBLSIZE

      m: table (optional, default [t=0, r=2, b=0, l=0])
         - Cell margin in px
           (top, right, bottom, left)
--]]

local valueWidget = assert(loadScript("/SCRIPTS/WIDGETS/value.lua"))()

local function flightModeWidget(zone, event, opts)
    local _opts = {}

    for i, opt in pairs(opts) do
        _opts[i] = opt
    end

    local val = getValue("sa") -- switchname, global variable or other source

    _opts.src = function() -- returns the string
        if val < -512 then
            return "Turtle"
        elseif val > -51 and val < 51 then
            return "Acro"
        elseif val > 512 then
            return "Horizon"
        end
        return "-"
    end

   valueWidget.run(zone, event, _opts)
end

return { run=flightModeWidget }
