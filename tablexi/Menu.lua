local MenuItem = require("tablexi.MenuItem")

local Menu = {items = {}}
Menu.__index = Menu

-------------------------------------
-- Initialize a new Menu.
-- @param items an optional Array of MenuItems.
-- @return a Menu.
-------------------------------------
local function new (_, items)
  items = items or {}
  local self = setmetatable({items = items}, Menu)
  return self
end
setmetatable(Menu, {__call = new})

-------------------------------------
-- Add a new item to the Menu from the passed values.
-- @param name a string item name.
-- @param price a number item price.
-- @return a MenuItem.
-------------------------------------
function Menu:add (name, price)
  local item = MenuItem(name, price)
  return self:add_item(item)
end

-------------------------------------
-- Add a new item to the Menu.
-- @param item a MenuItem.
-- @return a MenuItem.
-------------------------------------
function Menu:add_item (item)
  table.insert(self.items, item)
  return item
end

-------------------------------------
-- Get a copy of the current Menu without the passed item.
-- @param exclude_item a MenuItem.
-- @return a Menu.
-------------------------------------
function Menu:without (exclude_item)
  local new_menu = Menu()
  for _, item in ipairs(self.items) do
    if item ~= exclude_item then new_menu:add_item(item) end
  end

  return new_menu
end

return Menu
