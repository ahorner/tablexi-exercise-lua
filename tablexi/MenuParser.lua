local Menu = require("tablexi.Menu")

local MenuParser = {}
MenuParser.__index = MenuParser

-------------------------------------
-- Initialize a new MenuParser.
-- @return a MenuParser.
-------------------------------------
local function new ()
  local self = setmetatable({}, MenuParser)
  return self
end
setmetatable(MenuParser, {__call = new})

-------------------------------------
-- Parse the passed string representation of currency into a number.
-- @param value a string.
-- @return a number.
-------------------------------------
function MenuParser.parse_currency (value)
  return tonumber(value:match("$?(.+)")) * 100
end

-------------------------------------
-- Parse the passed string menu item description into its components.
-- @param line a string.
-- @return a string and a number.
-------------------------------------
function MenuParser:parse_line (line)
  local name, price = line:match("(.+),(.+)")
  if name == nil or price == nil then
    if line ~= "" then
      error("Invalid line format:\n" .. line)
    else
      return nil
    end
  end

  return name, self.parse_currency(price)
end

-------------------------------------
-- Parse a target price and Menu from the referenced file.
-- @param filename a string file name.
-- @return a number and a Menu.
-------------------------------------
function MenuParser:parse (filename)
  local file = io.open(filename, "r")
  if not file then error("Invalid file name supplied") end

  local target = nil
  local menu = Menu()

  for line in file:lines() do
    if target then
      local name, price = self:parse_line(line)
      if price <= 0 then error("All item prices must exceed $0.00") end
      menu:add(name, price)
    else
      target = self.parse_currency(line)
    end
  end

  return target, menu
end

return MenuParser
