describe("MenuSolver", function()
  local Menu = require("tablexi.Menu")
  local MenuItem = require("tablexi.MenuItem")
  local MenuSolver = require("tablexi.MenuSolver")

  local pizza = MenuItem("America's Pastime", 200)
  local jello = MenuItem("The Cold Cosby", pizza.price * 1.5)

  describe(":solutions", function()
    local menu = Menu({pizza, jello})
    local solver = MenuSolver(menu)

    describe("when the target price does not match any combination of items", function()
      local solutions = solver:solutions(pizza.price + 1)

      it("returns an empty list", function()
        assert.are.same(0, #solutions)
      end)
    end)

    describe("when the target price matches one item precisely", function()
      local solutions = solver:solutions(pizza.price)

      it("returns the single valid item", function()
        assert.are.same(1, #solutions)
        assert.are.same(solutions[1]:to_string(), "America's Pastime\tx 1\t($2.00)\n")
      end)
    end)

    describe("when the target price matches more than one copy of a single item", function()
      local solutions = solver:solutions(pizza.price * 2)

      it("returns multiples of that item", function()
        assert.are.same(1, #solutions)
        assert.are.same(solutions[1]:to_string(), "America's Pastime\tx 2\t($4.00)\n")
      end)
    end)

    describe("when the target price matches a combination of items", function()
      local solutions = solver:solutions(pizza.price + jello.price)

      it("returns the correct combination of items", function()
        assert.are.same(1, #solutions)
        assert.are.same(solutions[1]:to_string(), "The Cold Cosby\tx 1\t($3.00)\nAmerica's Pastime\tx 1\t($2.00)\n")
      end)
    end)

    describe("when the target price matches multiple combinations of items", function()
      local solutions = solver:solutions(pizza.price * 3)

      it("returns multiple valid combinations", function()
        assert.are.same(2, #solutions)
        assert.are.same(solutions[1]:to_string(), "The Cold Cosby\tx 2\t($6.00)\n")
        assert.are.same(solutions[2]:to_string(), "America's Pastime\tx 3\t($6.00)\n")
      end)
    end)
  end)
end)
