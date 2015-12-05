local MenuCombination = {}
MenuCombination.__index = MenuCombination

-------------------------------------
-- Initialize a new MenuCombination.
-- @return a MenuCombination.
-------------------------------------
local function new ()
  local self = setmetatable({counts = {}}, MenuCombination)
  return self
end
setmetatable(MenuCombination, {__call = new})

-------------------------------------
-- Add an item and its corresponding count to the combination.
-- @param item a MenuItem.
-- @param count a number.
-------------------------------------
function MenuCombination:add_item(item, count)
  self.counts[item] = count
end

-------------------------------------
-- Get a string depiction of the items in the combination.
-- @return a string.
-------------------------------------
function MenuCombination:to_string ()
  local output = ""
  for item, count in pairs(self.counts) do
    output = output .. string.format("%s\tx %d\t($%.02f)\n", item.name, count, item.price / 100 * count)
  end

  return output
end

return MenuCombination
