local function altitudeWidget(zone)

    lcd.drawPixmap(zone.x+1, zone.y+2, "/SCRIPTS/WIDGETS/X9/BMP/hgt.bmp")

    local height = getValue("GAlt")
    if simModeOn == 1 then
        height = theight
    end

    lcd.drawNumber(zone.x+18, zone.y+7, height, LEFT)
    lcd.drawText(lcd.getLastPos(), zone.y+7, "m", 0)

    lcd.drawLine(zone.x, zone.h-1, zone.x+zone.w, zone.h-1, SOLID, GREY_DEFAULT)
end

return { run=altitudeWidget }
