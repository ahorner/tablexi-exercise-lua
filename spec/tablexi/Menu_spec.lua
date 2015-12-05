describe("Menu", function()
  local Menu = require("tablexi.Menu")
  local MenuItem = require("tablexi.MenuItem")

  local soda = MenuItem("Fizzy Lifting Drink", 150)
  local brownie = MenuItem("Chewy Chocolate Treat", 250)

  describe(":add", function()
    local menu = Menu()
    menu:add(soda.name, soda.price)

    it("adds a MenuItem with the passed name and price", function()
      assert.are.same(soda, menu.items[1])
    end)
  end)

  describe(":add_item", function()
    local menu = Menu()
    menu:add_item(brownie)

    it("adds the passed item to the next spot in the menu", function()
      assert.are.same(brownie, menu.items[1])
    end)
  end)

  describe(":without", function()
    local menu = Menu({soda, brownie})
    local new_menu = menu:without(menu.items[1])

    it("returns a new menu without the passed item", function()
      assert.are_not.same(menu.items[1], new_menu.items[1])
      assert.are.same(menu.items[2], new_menu.items[1])
    end)
  end)
end)
