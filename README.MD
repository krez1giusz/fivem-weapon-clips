<!-- PRZYKLADOWY CONFIG DODATKOWEGO MAGAZYNKA -->
Mags = {
    Types = {
        ["mag_pistol"] = {
            ammoRequired = 'ammo-pistol',
            maxAmmo = 30,
        },
        ['mag_rifle'] = {
            ammoRequired = 'nazwa-itemu-amunicji',
            maxAmmo = 5, <!-- ILOSC AMUNICJI KTORA MOZE BYC MAKSYMALNIE WRZUCONA DO MAGAZYNKA-->
        }
    
    }
}


<!-- POWYZSZY CONFIG TYCZY SIĘ PLIKU CONFIG.LUA W SKRYPCIE WE_MAGS -->

<!-- ABY ZDEFINIOWAC NOWY MAGAZYNEK DO DANEJ BRONI -->
<!-- ox_inventory/data/weapons.lua -->
<!-- odszukujesz dany typ broni przykladowo weapon_assaultrifle, oraz dopisujesz nazwę magazynku -->
    magName = 'mag_rifle'

<!-- PRZYKLAD -->
['WEAPON_ASSAULTRIFLE'] = {
	label = 'Assault Rifle',
	weight = 4500,
	durability = 0.03,
    magName = 'mag_rifle'
	ammoname = 'ammo-rifle2',
},

<!-- magName w pliku ox_inventory musi korespondowac do nazwy magazynku w pliku config.lua w skrypcie we_mags, inaczej nic nie zadziała!!!!! -->