
-- CreateThread(function()
--     exports.ox_inventory:displayMetadata('secretId', 'SEKRETNE ID XD ')
-- end)

RegisterNetEvent('ultrax:mags:useMag', function(data,slot)
	local itemName = data.name
	local itemSettings = Mags.Types[itemName]
	local ammoinMag = slot.metadata.ammo
	local ammoCount = exports.ox_inventory:Search('count', itemSettings.ammoRequired)

	if ammoCount <= 0 then
		ESX.ShowNotification("Nie posiadasz odpowiedniego typu amunicji...", 4000, 'error')
		return
	end

	print(1)
	if ammoinMag == nil then
		print(2)
		if ammoCount >= itemSettings.maxAmmo then
			if lib.progressBar({
				duration = 6000,
				label = 'Ładowanie magazynka...',
				canCancel = true,
				anim = {
					dict = 'cover@weapon@1h',
					clip = 'high_reload'
				},
		
			}) then TriggerServerEvent('ultrax:mags:updateMag',data,slot, itemSettings.maxAmmo, itemSettings.maxAmmo, itemSettings.ammoRequired)
			else return end
			print('ładuje magazynek do stanu: '..itemSettings.maxAmmo)
		else
			print('ładuje magazynek do stanu: '..ammoCount)
			if lib.progressBar({
				duration = 6000,
				label = 'Ładowanie magazynka...',
				canCancel = true,
				anim = {
					dict = 'cover@weapon@1h',
					clip = 'high_reload'
				},
		
			}) then TriggerServerEvent('ultrax:mags:updateMag',data,slot, ammoCount, ammoCount, itemSettings.ammoRequired)
			else return end
		end
	else
		print(3)
		local missingMagAmmo = (itemSettings.maxAmmo - ammoinMag)
		print('Cały magazynek to: '..(ammoinMag + missingMagAmmo))

		if ammoinMag >= itemSettings.maxAmmo then
			ESX.ShowNotification('Ten magazynek jest naładowany do pełna...', 4000, 'error')
			return
		end

		if ammoCount >= missingMagAmmo then
			print('ładuje magazynek do stanu: '..ammoinMag+missingMagAmmo)
			if lib.progressBar({
				duration = 6000,
				label = 'Ładowanie magazynka...',
				canCancel = true,
				anim = {
					dict = 'cover@weapon@1h',
					clip = 'high_reload'
				},
		
			}) then TriggerServerEvent('ultrax:mags:updateMag',data,slot, (ammoinMag+missingMagAmmo), missingMagAmmo, itemSettings.ammoRequired)
			else return end
		else
			print("Ładuje magazynek do stanu: "..(ammoinMag + ammoCount))
			if lib.progressBar({
				duration = 6000,
				label = 'Ładowanie magazynka...',
				canCancel = true,
				anim = {
					dict = 'cover@weapon@1h',
					clip = 'high_reload'
				},
		
			}) then TriggerServerEvent('ultrax:mags:updateMag',data,slot, (ammoinMag+ammoCount), ammoCount, itemSettings.ammoRequired)
			else return end
		end
	end


end)

