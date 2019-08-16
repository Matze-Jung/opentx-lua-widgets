local function headingWidget(zone)

    lcd.drawPixmap(zone.x+1, zone.y+2, "/SCRIPTS/WIDGETS/X9/BMP/compass.bmp")

    local heading = getValue("Hdg")

    lcd.drawNumber(zone.x+18, zone.y+7, heading, LEFT)
    lcd.drawText(lcd.getLastPos(), zone.y+7, "dg", 0)

    lcd.drawLine(zone.x, zone.y-1, zone.x+zone.w, zone.y-1, SOLID, GREY_DEFAULT)
end

return { run=headingWidget }
