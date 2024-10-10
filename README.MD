PRZYKLADOWY CONFIG DODATKOWEGO MAGAZYNKA
Mags = {
    Types = {
        ["mag_pistol"] = {
            ammoRequired = 'ammo-pistol',
            maxAmmo = 30,
        },
        ['mag_rifle'] = {
            ammoRequired = 'nazwa-itemu-amunicji',
            maxAmmo = 5, LOSC AMUNICJI KTORA MOZE BYC MAKSYMALNIE WRZUCONA DO MAGAZYNKA
        }
    
    }
}


POWYZSZY CONFIG TYCZY SIĘ PLIKU CONFIG.LUA W SKRYPCIE WE_MAGS

ABY ZDEFINIOWAC NOWY MAGAZYNEK DO DANEJ BRONI 
ox_inventory/data/weapons.lua
odszukujesz dany typ broni przykladowo weapon_assaultrifle, oraz dopisujesz nazwę magazynku 
    magName = 'mag_rifle'

PRZYKLAD 
['WEAPON_ASSAULTRIFLE'] = {
	label = 'Assault Rifle',
	weight = 4500,
	durability = 0.03,
    magName = 'mag_rifle'
	ammoname = 'ammo-rifle2',
},

magName w pliku ox_inventory musi korespondowac do nazwy magazynku w pliku config.lua w skrypcie we_mags, inaczej nic nie zadziała!!!!!



ox_inventory
reloadWeapon = function(slot, clipammo)
		print(slot,clipammo.. ' reloading')
		local ammoInCurrWeapon = GetAmmoInPedWeapon(playerPed, currentWeapon.hash)
		local maxAmmoInClip = GetMaxAmmoInClip(playerPed, currentWeapon.hash, true)
		local difference = (maxAmmoInClip - ammoInCurrWeapon)
		if clipammo >= difference then
			
			if cache.vehicle then
				SetAmmoInClip(playerPed, currentWeapon.hash, (difference+ammoInCurrWeapon))
			else
				AddAmmoToPed(playerPed, currentWeapon.hash, difference)
				Wait(100)
				MakePedReload(playerPed)
			end

			currentWeapon.metadata.ammo = (difference + ammoInCurrWeapon)
			TriggerServerEvent('ox_inventory:updateWeaponAmmo', slot, (clipammo - difference), (difference + ammoInCurrWeapon))
			--TriggerServerEvent('ox_inventory:updateWeapon', 'load', currentWeapon.metadata.ammo, false, currentWeapon.metadata.specialAmmo, slot)
			
			--makepedreload
			print('reload successful')
		else
			if clipammo ~= 0 then
				if cache.vehicle then
					SetAmmoInClip(playerPed, currentWeapon.hash, ammoInCurrWeapon + clipammo)
				else
					AddAmmoToPed(playerPed, currentWeapon.hash, clipammo)
					Wait(100)
					MakePedReload(playerPed)
				end
	
				currentWeapon.metadata.ammo = clipammo
				TriggerServerEvent('ox_inventory:updateWeaponAmmo', slot, clipammo - clipammo, (difference + ammoInCurrWeapon))
			else
				ESX.ShowNotification("Nie posiadasz magazynka w którym znajdowałyby się naboje...", 4000, 'error')
			end
		end
	end

	lib.addKeybind({
		name = 'reloadweapon',
		description = locale('reload_weapon'),
		defaultKey = 'r',
		onPressed = function(self)
			if not currentWeapon or not canUseItem(true) then return end


			local mags = Inventory.Search('slots', currentWeapon.mag)
			local count = 0
			
			for k,v in pairs(mags) do
				if v.metadata.ammo ~= nil and v.metadata.ammo > 0 then
					reloadWeapon(v.slot, v.metadata.ammo)
					return
				end
			end



		end
	})
