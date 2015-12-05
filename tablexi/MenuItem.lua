local MenuItem = {name = nil, price = nil}
MenuItem.__index = MenuItem

-------------------------------------
-- Initialize a new MenuItem.
-- @param name a string item name.
-- @param price a number item price.
-- @return a MenuItem.
-------------------------------------
local function new (_, name, price)
  local self = setmetatable({name = name, price = price}, MenuItem)
  return self
end
setmetatable(MenuItem, {__call = new})

-------------------------------------
-- Compare two MenuItems to determine if they are equivalent.
-- @param a a MenuItem.
-- @param b a MenuItem.
-- @return a boolean.
-------------------------------------
function MenuItem.__eq (a, b)
  return (a.name == b.name) and (a.price == b.price)
end

return MenuItem
