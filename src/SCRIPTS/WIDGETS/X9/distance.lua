local function distWidget(zone)

    lcd.drawPixmap(zone.x+1, zone.y+2, "/SCRIPTS/WIDGETS/X9/BMP/dist.bmp")

    local dist = getValue("Dist")
    if simModeOn == 1 then
        dist = tdist
    end

    lcd.drawNumber(zone.x+18, zone.y+7, dist, LEFT)
    lcd.drawText(lcd.getLastPos(), zone.y+7, "m", 0)

    lcd.drawLine(zone.x, zone.y-1, zone.x+zone.w, zone.y-1, SOLID, GREY_DEFAULT)
end

return { run=distWidget }
