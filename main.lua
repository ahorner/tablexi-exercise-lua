local MenuParser = require("tablexi.MenuParser")
local MenuSolver = require("tablexi.MenuSolver")

local parser = MenuParser()
local target, menu = parser:parse(arg[1])

local solver = MenuSolver(menu)
local solutions = solver:solutions(target)

print(string.format("The following combinations add up to $%.02f:\n", target / 100))
if #solutions > 0 then
  for index, combination in ipairs(solutions) do
    print("Combination #" .. index .. "\n---")
    print(combination:to_string())
  end
else
  print("No valid combinations found")
end
