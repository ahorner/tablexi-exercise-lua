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
-- Find all combinations adding up to the passed target price for our menu.
-- @param target a number representing the goal.
-- @return an array of MenuCombinations.
-------------------------------------
function MenuSolver:solutions (target)
  local item = self.menu.items[1]
  local combinations = {}

  if not item then return combinations end

  local maximum = math.floor(target / item.price)
  for count = 0, maximum do
    local new_target = target - (item.price * count)

    if new_target == 0 then
      -- If we meet the target price exactly, we've found a basic combination.
      local combination = MenuCombination()
      combination:add_item(item, count)
      table.insert(combinations, combination)

      break
    else
      -- If we don't meet the target price exactly, we need to find all valid
      -- solutions for permutations of the rest of the menu against the reduced
      -- target price.
      local solver = MenuSolver(self.menu:without(item))
      local subset = solver:solutions(new_target)

      -- Once we have valid solutions for the rest of the menu, we add our
      -- current item count to each of those combinations, to make up the
      -- difference.
      for _, combination in ipairs(subset) do
        if count > 0 then combination:add_item(item, count) end
        table.insert(combinations, combination)
      end
    end
  end

  return combinations
end

return MenuSolver
