--[[ ** TELEMETRY SCREEN WIDGET **

  Draws a picto quadcopter and animates it when armed.

  Inspired by Andrew Farley's Taranis-XLite-Q7-Lua-Dashboard [https://github.com/AndrewFarley/Taranis-XLite-Q7-Lua-Dashboard]


  PLATFORM
    X7, X9 and relatives

  SCALING
    vert: scalable, min 30px
    horiz: scalable, min 30px

  PARAMETER
    zone: table [x, y, w, h]
      - Location on display in px
        (x-pos, y-pos, width, height)

    event: int
      - User event

    opts: table
      - Configurations

        src: function returns boolean
          - true if armed

        notxt: boolean (default false)
          - hide blinking `armed` text

        p: table (optional, default [t=1, r=0, b=0, l=1])
           - Padding between content and widget boundaries in px
             (top, right, bottom, left)
--]]

local animTick = 0
local armed = false

local function drawPropellor(_x, _y, invert)
    local inc = animTick
    if invert == true then
        inc = (inc - 3) * -1
        inc = inc + 3
        if inc > 3 then
            inc = inc - 4
        end
    end

    lcd.drawRectangle(_x + 4, _y + 4, 3, 3, SOLID)

    -- Animated Quadcopter propellors
    if (not armed and not invert) or (armed and inc == 0) then
        lcd.drawLine(_x + 1, _y + 9, _x + 9, _y + 1, SOLID, FORCE)
        lcd.drawLine(_x + 1, _y + 10, _x + 8, _y + 1, SOLID, FORCE)
    elseif armed and inc == 1 then
        lcd.drawLine(_x, _y + 5, _x + 9, _y + 5, SOLID, FORCE)
        lcd.drawLine(_x, _y + 4, _x + 9, _y + 6, SOLID, FORCE)
    elseif (not armed and invert) or (armed and inc == 2) then
        lcd.drawLine(_x + 1, _y + 1, _x + 9, _y + 9, SOLID, FORCE)
        lcd.drawLine(_x + 1, _y + 2, _x + 10, _y + 9, SOLID, FORCE)
    elseif armed and inc == 3 then
        lcd.drawLine(_x + 5, _y, _x + 5, _y + 10, SOLID, FORCE)
        lcd.drawLine(_x + 6, _y, _x + 4, _y + 10, SOLID, FORCE)
    end
end

local function drawQuadcopter(_x, _y, opts)

    -- Top left to bottom right
    lcd.drawLine(_x + 5, _y + 5, _x + 23, _y + 23, SOLID, FORCE)
    lcd.drawLine(_x + 5, _y + 6, _x + 22, _y + 23, SOLID, FORCE)
    lcd.drawLine(_x + 6, _y + 5, _x + 23, _y + 22, SOLID, FORCE)

    -- Bottom left to top right
    lcd.drawLine(_x + 5, _y + 23, _x + 23, _y + 5, SOLID, FORCE)
    lcd.drawLine(_x + 5, _y + 22, _x + 22, _y + 5, SOLID, FORCE)
    lcd.drawLine(_x + 6, _y + 23, _x + 23, _y + 6, SOLID, FORCE)

    -- Middle of Quad
    lcd.drawFilledRectangle(_x + 12, _y + 8, 5, 13, SOLID)
    lcd.drawFilledRectangle(_x + 11, _y + 11, 7, 7, SOLID)
    lcd.drawPoint(_x + 13, _y + 11)
    lcd.drawPoint(_x + 13, _y + 17)
    lcd.drawPoint(_x + 15, _y + 11)
    lcd.drawPoint(_x + 15, _y + 17)

    if armed and not opts.notxt then
       lcd.drawText(_x + 2, _y + 11, "armed", SMLSIZE + BLINK)
    end

    -- Top-left
    drawPropellor(_x, _y, false)
    -- Bottom-Right
    drawPropellor(_x + 18, _y + 18, false)
    -- Top-Right
    drawPropellor(_x + 18, _y, true)
    -- Bottom-left
    drawPropellor(_x , _y + 18, true)
end

local function armWidget(zone, event, opts)
    local p = { t=1, r=0, b=0, l=1 }

    local z = calcWidgetZone(zone, p, opts.p or false)
    armed = type(opts.src) == "function"
        and opts.src()
        or false

    animTick = math.fmod(math.ceil(math.fmod(getTime() / 100, 2) * 10), 4)

    drawQuadcopter(z.x, z.y, opts)
end

return { run=armWidget }
