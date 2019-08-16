local function gpsWidget(zone)

    local sats = getValue("Sats")
    local fix  = getValue("Fix")

    local fixImg = "/SCRIPTS/WIDGETS/X9/BMP/sat0.bmp"
    if fix == 2 then fixImg = "/SCRIPTS/WIDGETS/X9/BMP/sat1.bmp"
    elseif fix == 3 then fixImg = "/SCRIPTS/WIDGETS/X9/BMP/sat2.bmp"
    elseif fix == 4 then fixImg = "/SCRIPTS/WIDGETS/X9/BMP/sat3.bmp"
    end

    local satImg = "/SCRIPTS/WIDGETS/X9/BMP/gps_0.bmp"
    if sats > 5 then satImg = "/SCRIPTS/WIDGETS/X9/BMP/gps_6.bmp"
    elseif sats > 4 then satImg = "/SCRIPTS/WIDGETS/X9/BMP/gps_5.bmp"
    elseif sats > 3 then satImg = "/SCRIPTS/WIDGETS/X9/BMP/gps_4.bmp"
    elseif sats > 2 then satImg = "/SCRIPTS/WIDGETS/X9/BMP/gps_3.bmp"
    elseif sats > 1 then satImg = "/SCRIPTS/WIDGETS/X9/BMP/gps_2.bmp"
    elseif sats > 0 then satImg = "/SCRIPTS/WIDGETS/X9/BMP/gps_1.bmp"
    end

    lcd.drawPixmap(zone.x+1, zone.y+1, fixImg)
    lcd.drawPixmap(zone.x+13, zone.y+3, satImg)
    lcd.drawNumber(zone.x+19, zone.y+1, sats, SMLSIZE)

    lcd.drawLine(zone.x, zone.y-1, zone.x+zone.w, zone.y-1, SOLID, GREY_DEFAULT)
end

return { run=gpsWidget }
