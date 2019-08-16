local function timerWidget(zone)

    lcd.drawPixmap(zone.x+1, zone.y+3, "/SCRIPTS/WIDGETS/X9/BMP/timer_1.bmp")
    lcd.drawTimer(zone.x+18, zone.y+8, getValue(196), 0)

    lcd.drawLine(zone.x, zone.y-1, zone.x+zone.w, zone.y-1, SOLID, GREY_DEFAULT)
end

return { run=timerWidget }
