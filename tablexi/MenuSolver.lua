local Menu = require("tablexi.Menu")
local MenuCombination = require("tablexi.MenuCombination")

local MenuSolver = {}
MenuSolver.__index = MenuSolver

-------------------------------------
-- Initialize a new MenuSolver.
-- @param menu a Menu.
-- @return a MenuSolver.
-------------------------------------
local function new (_, menu)
  local self = setmetatable({menu = menu}, MenuSolver)
  return self
end
setmetatable(MenuSolver, {__call = new})

-------------------------------------
-- Find all combinations adding to the passed target price for our menu.
-- @param target a number representing the goal.
-- @return an array of MenuCombinations.
-------------------------------------
function MenuSolver:solutions (target)
  local item = self.menu.items[1]
  local combinations = {}

  if item == nil then return combinations end

  local maximum = math.floor(target / item.price)
  for count = 0, maximum do
    new_target = target - (item.price * count)

    if new_target == 0 then
      combination = MenuCombination()
      combination:add_item(item, count)
      table.insert(combinations, combination)

      break
    else
      solver = MenuSolver(self.menu:without(item))
      subset = solver:solutions(target - (item.price * count))

      for _, combination in ipairs(subset) do
        if count > 0 then combination:add_item(item, count) end
        table.insert(combinations, combination)
      end
    end
  end

  return combinations
end

return MenuSolver
