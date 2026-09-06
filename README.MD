# FiveM Weapon Clips

A configurable weapon-magazine system for FiveM servers using ESX,
ox_inventory, and ox_lib.

The resource represents magazines as inventory items with their current
ammunition stored in item metadata. Players can refill partially loaded
magazines and use them when reloading compatible weapons.

## Features

- Reusable magazine inventory items
- Ammunition stored in ox_inventory metadata
- Configurable magazine capacities
- Configurable ammunition types
- Full and partial magazine refilling
- Loading progress bar and animation
- Server-side ammunition removal
- Server-side magazine metadata updates
- Support for multiple magazine types
- Weapon-to-magazine assignment

## Requirements

- FiveM server
- ESX Legacy
- ox_lib
- ox_inventory
- Modified weapon reload integration

## Configuration

Magazine types are defined in `config.lua`:

```lua
Mags = {
    Types = {
        ['mag_pistol'] = {
            ammoRequired = 'ammo-pistol',
            maxAmmo = 12,
        },
        ['mag_45'] = {
            ammoRequired = 'ammo-45',
            maxAmmo = 12,
        }
    }
}
```

Each magazine requires:

- a unique inventory item name,
- the ammunition item used to fill it,
- its maximum ammunition capacity.

## ox_inventory items

Magazine items must be added to ox_inventory and connected to:

```text
ultrax:mags:useMag
```

Example item:

```lua
['mag_pistol'] = {
    label = 'Pistol Magazine',
    weight = 250,
    stack = false,
    close = true,
    client = {
        event = 'ultrax:mags:useMag'
    }
}
```

Magazines should not stack because every item stores its own ammunition count
in metadata.

## Weapon configuration

Assign a magazine type to a weapon in:

```text
ox_inventory/data/weapons.lua
```

Example:

```lua
['WEAPON_PISTOL'] = {
    label = 'Pistol',
    weight = 1130,
    durability = 0.1,
    ammoname = 'ammo-pistol',
    magName = 'mag_pistol'
}
```

The `magName` value must match a magazine defined in `config.lua`.

## Metadata

The current magazine ammunition is stored as:

```lua
{
    ammo = 8
}
```

When the magazine is filled, the server:

1. verifies the selected magazine,
2. removes the required ammunition items,
3. updates the magazine metadata,
4. synchronizes the inventory state.

## Reload integration

The repository includes an example modification for ox_inventory's weapon
reload flow.

The integration searches for a compatible loaded magazine, transfers the
required amount into the current weapon, and updates the remaining magazine
ammunition.

Because this changes ox_inventory internals, the provided implementation
should be reviewed and adapted to the installed ox_inventory version.

## Project structure

```text
fivem-weapon-clips/
├── client/
│   └── client.lua
├── server/
│   └── server.lua
├── config.lua
├── fxmanifest.lua
└── README.MD
```

## Security note

Inventory slots, ammunition quantities, magazine types, and item ownership
should be validated server-side before using the resource on a public server.

## Status

Legacy project preserved as part of my early FiveM development work. It
requires an adapted ox_inventory reload integration and should be treated as
a technical concept rather than a drop-in resource.
