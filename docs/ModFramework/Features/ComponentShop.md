# ModFramework - Component shop management

#### [Back to overview](../Overview.md)
---

## Managing placement
The framework Takes control of the placement for all shop components as long as these items either be found in the game_obj_component_shop or are created by the framework.

This ensures that mods don't have to track where to place shop components. They will be sorted and arranged as needed.

In the event that there are more items in a section than can fit the framework will produce page buttons to toggle between pages of components in that section.

The sections that are managed are:
- Additional (containing cabins and motors)
- Mechs (containing mechs and armor)
- Weapons (containing weapons)
- Support (containing city components, rocket/nuke, robot engineer and lure)
- Reactors (containing reactors, injectors, pistons, kernels, safeties, magnets and solenoids)

## Adding weapon indicators
Modded weapons by default don't get a weapon type indicator on the shop listing. The framework ensures these are added. 

It also fixes this for weapons not made by the framework.

## Fix for modded production sprites
The game cannot hold the references to modded sprites between save and loading. The framework will ensure the items that are currently in production are repopulated with the correct sprites.

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)
