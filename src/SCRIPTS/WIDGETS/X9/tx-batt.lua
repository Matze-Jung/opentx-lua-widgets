local function batteryWidget(zone, event)
    local cellV = getValue("tx-voltage")
    local settings = getGeneralSettings()
    local maxV = settings.battMax
    local minV = settings.battMin
    local cellRange = maxV - minV
    local availV = 0
    local z = zone

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
        lcd.drawLine(z.x+12, z.y+10+i, z.x+18, z.y+10+i, SOLID, GREY_DEFAULT)
        i = i-2
    end

    local style = PREC2 + LEFT
    if (cellV < minV) then
        style = style + BLINK
    end
    lcd.drawNumber(z.x+5, z.y+53, cellV*100, style)
    lcd.drawText(lcd.getLastPos(), z.y+53, "V", 0)
end

return { run=batteryWidget }
