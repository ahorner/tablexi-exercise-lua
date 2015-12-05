# Programming Exercise

This is a sample Lua solution to [Table XI's programming exercise](http://www.tablexi.com/exercise/).

## Instructions

### Running the Script

Make sure you have Lua installed on your system, and the interpreter available somewhere in your binpath. If you're on a Mac with [Homebrew](http://brew.sh/) installed, the following should be enough to get you going:

    brew install lua

Run the code. I've included an executable and a directory of sample menus for your convenience, so the following should be sufficient to start off with:

    bin/solve menus/menu.txt

If you're not using a standard shell, or don't want to add Lua to your binpath, you can manually invoke the script, instead:

    /my/path/to/lua main.lua menus/menu.txt

### Running the Tests

This repo includes a spec suite built on the [`busted`](https://github.com/Olivine-Labs/busted) testing framework for Lua. A default Lua installation includes the LuaRocks package manager, as well, so the following should be sufficient to get the spec suite running:

    luarocks install busted
    busted

## Commentary

This was written as part of the Crazy Programming Language project at Table XI, with the goal of giving folks a reason to use a language they don't normally work with, and/or want to improve their skills with. That said, I would be remiss if I didn't highlight a few of the interesting quirks of Lua I discovered while working on this solution.

### Object basics

The basic "object" in Lua is a table, which is essentially an associative array (`{name = "Bob"}`).

A "normal" array is a special case of table which uses implicit numeric indexes (`{"First", "Second", "Third"}`). The first element of an Array is considered index 1. Edsger Djikstra may be rolling in his grave, but it's actually not that bad in practice.

### Metatables and Inheritance

Table inheritance works by setting a table's "metatable". It's a form of prototypal inheritance, very similar to Javascript's. `setmetatable` is the standard way of exposing a table's functionality to another table.

Tables can be invoked as functions by setting the `__call` value in their metatable to some function. This is mostly useful for creating implicit constructor functions.

### Comparisons

The standard comparison operators in Lua are `and`, `or`, and `not`. "Not equal to" is represented as `~=`. Like Ruby, `nil` and `false` are both treated as "falsey", while all other values are consider "truthy".

### Function definitions

Functions can be defined on a table in two different ways:

A table function defined with `.` has completely explicit parameters:

```lua
function Calculator.add (self, a)
  self.value = self.value + a
end
```

A table function defined with `:` has an implicit `self` argument, making it a bit nicer when you need that internal reference:

```lua
function Calculator:add (a)
  self.value = self.value + a
end
```

`:` is just syntax sugar, so both of the above are functionally equivalent. The same rule applies when you _invoke_ the function, so either of the definitions above could be invoked as `Calculator.add(Calculator, 1)` or `Calculator:add(1)`.

### Iteration

Iterating over a table requires using the `pairs` or `ipairs` functions to iterate over key-value pairs in that table.

`pairs` is a standard iterator for all forms of table:

```lua
for k,v in pairs({name="Bob", birthday="10/22"}) do
  print(k,v)
end
-- name Bob
-- birthday 10/22
```

`ipairs` is a special-case iterator specifically for arrays (see above). It iterates _only_ over those items in the table with numeric indices.

```lua
for i,v in ipairs({"Sunday","Monday","Tuesday"}) do
  print(i,v)
end
-- 1 Sunday
-- 2 Monday
-- 3 Tuesday
```

Getting the size of an array _used_ to be accomplished through `table.getn`, but that method was deprecated as of Lua 5.1. The current idiom is the `#` operator:

```lua
fish = {"One Fish","Two Fish","Red Fish","Blue Fish"}
#fish
-- 4
```
