local function rssiWidget(zone, event)
    local db, alarm_low, alarm_crit = getRSSI()
    local perc = 0
    local pixmap = "00"

    if db > alarm_crit then
        perc = (math.log(db-28, 10) - 1) / (math.log(72, 10) - 1) * 100
    end

    if perc >= 99 then
        pixmap = "10"
    else
        for i=1, 10 do
            if perc >= i*10 and perc < i*10+10 then
                pixmap = "0"..i
                break
            end
        end
    end

    lcd.drawPixmap(zone.x+4, zone.y+1, "/SCRIPTS/WIDGETS/X9/BMP/RSSIh"..pixmap..".bmp")
    lcd.drawText(zone.x+6, zone.y+54, db .. "dB", 0)
end

return { run=rssiWidget }
