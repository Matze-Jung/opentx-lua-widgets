local function speedWidget(zone)

    lcd.drawPixmap(zone.x+1, zone.y+2, "/SCRIPTS/WIDGETS/X9/BMP/speed.bmp")

    local speed = getValue("GSpd") * 3.6

    lcd.drawNumber(zone.x+18, zone.y+7, speed, LEFT)
    lcd.drawText(lcd.getLastPos(), zone.y+7, "kmh", 0)

    lcd.drawLine(zone.x, zone.y-1, zone.x+zone.w, zone.y-1, SOLID, GREY_DEFAULT)
end

return { run=speedWidget }
