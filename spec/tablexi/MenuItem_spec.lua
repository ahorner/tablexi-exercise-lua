describe("MenuItem", function()
  local MenuItem = require("tablexi.MenuItem")

  local original = MenuItem("The real thing", 150)

  describe(".__eq", function()

    it("compares MenuItems by name and price", function()
      assert.are_not.same(original, MenuItem(original.name, 200))
      assert.are_not.same(original, MenuItem("Shameless knock-off", original.price))

      assert.are.same(original, MenuItem(original.name, original.price))
      assert.are.same(original, original)
    end)
  end)
end)
