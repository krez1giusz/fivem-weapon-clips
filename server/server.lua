RegisterServerEvent('spawnmag', function(magtype, amunicja)
    exports.ox_inventory:AddItem(source, magtype, 1, { ammo = amunicja })

end)

RegisterServerEvent('ultrax:mags:updateMag', function(data,slot,magAmmo,ammoToTake,ammoType)
    local xPlayer = ESX.GetPlayerFromId(source)
    print('MAGAZYNEK: '..magAmmo)
    print('ZABIERAM: '..ammoToTake)
    xPlayer.removeInventoryItem(ammoType, ammoToTake)
    exports.ox_inventory:SetMetadata(source, data.slot, {ammo = magAmmo})
end)