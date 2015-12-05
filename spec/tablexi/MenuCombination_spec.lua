describe("MenuCombination", function()
  local MenuCombination = require("tablexi.MenuCombination")
  local MenuItem = require("tablexi.MenuItem")

  local pasta = MenuItem("Spinelli's Spaghetti", 304)
  local fish = MenuItem("Samson's Salmon", 1512)

  describe(":add_item", function()
    local combination = MenuCombination()

    it("sets the passed count for the specified item", function()
      combination:add_item(pasta, 4)
      combination:add_item(fish, 2)

      assert.are.same(4, combination.counts[pasta])
      assert.are.same(2, combination.counts[fish])
    end)
  end)

  describe(":to_string", function()
    local combination = MenuCombination()
    combination:add_item(pasta, 2)
    combination:add_item(fish, 1)

    it("renders a depiction of the item counts", function()
      assert.are.same(
        "Spinelli's Spaghetti\tx 2\t($6.08)\nSamson's Salmon\tx 1\t($15.12)\n",
        combination:to_string()
      )
    end)
  end)
end)
