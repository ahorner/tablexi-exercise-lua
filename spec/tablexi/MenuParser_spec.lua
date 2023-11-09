describe("MenuParser", function()
  local MenuParser = require("tablexi.MenuParser")
  local parser = MenuParser()

  describe(".parse_currency", function()

    it("converts a dollar amount to an integer", function()
      assert.are.same(2034, parser.parse_currency("20.34"))
    end)

    it("correctly handles a dollar sign", function()
      assert.are.same(1507, parser.parse_currency("$15.07"))
    end)

    it("handles dollar amounts without decimals", function()
      assert.are.same(300, parser.parse_currency("3"))
    end)
  end)

  describe(":parse_line", function()

    it("breaks a line of text into an item name and price", function()
      local line = "Mad Madame Mim's Moist Marshmallow Pie,$15.08"
      local name, price = parser:parse_line(line)

      assert.are.same("Mad Madame Mim's Moist Marshmallow Pie", name)
      assert.are.same(1508, price)
    end)
  end)
end)
