
---@class ModRegistration dataset containing the mod registration info
---@field LoadOrderId number the load order id of the mod
---@field Name string the name of the mod, equal to the folder name of the mod
---@field Path string the filepath to the mod folder

---@class ModdedComponent dataset containing relevant passthrough info for components
---@field ComponentType ComponentType the type of component
---@field Index number the index of the component
---@field Sprite number the index of the component sprite, used to fix production sprites on game load
---@field Name string the name of the component
---@field ComponentSize ComponentSize the size of the component when constructing it.
---@field IsResearched boolean set to true if its pre researched, else false.
---@field CanBeConstructed boolean set to true if it can be constructed in the component shop, false otherwise
---@field ShopComponent ModdedShopComponent? the shop component to construct new items, or nil for an non constructable item
---@field GiveFreeItem boolean set to true to return a free copy when triggered as an unlock
---@field BlueLength number the range of a blue weapon
---@field WeaponDescription string the description text for a weapon component, empty string otherwise.

---@class ModdedShopComponent
---@field Index number the assigned index for the modded shop component

---@class ModdedComponentSearchCriteria
---@field Name string the name of the component
---@field ComponentType ComponentType the type of component