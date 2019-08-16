local function fmWidget(zone)

    lcd.drawPixmap(zone.x+1, zone.y+2, "/SCRIPTS/WIDGETS/X9/BMP/fm.bmp")

    local mode  = " ?"
    local style = MIDSIZE

    if getValue("RSSI") <= 20 then
        mode = "N/A"
        style = style + BLINK
    elseif getValue("ch8") > 0 then
        mode = "COFF"
        style = style + BLINK + INVERS
    elseif getValue("ch7") > 0 then
        mode = "RTH"
    elseif getValue("ch5") < 0 then
        mode = "POS"
    elseif getValue("ch5") == 0 then
        mode = "STA"
    elseif getValue("ch5") > 0 then
        mode = "ALT"
    end

    lcd.drawText(zone.x+20, zone.y+4, mode, style)

    lcd.drawLine(zone.x, zone.y-1, zone.x+zone.w, zone.y-1, SOLID, GREY_DEFAULT)
end

return { run=fmWidget }
