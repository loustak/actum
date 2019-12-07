# 🎯 Actum
A simple and flexible library for event and action handling in lua.
It comes with bindings for [Löve2D](https://love2d.org/), but feel free to propose yours!

## Documentation
Actum's API is very simple, but to understand it well you need to understand two conecpts, `events` and `action`. An event is  something that will happen during the life cycle of your program. An action is the reaction to this event.

```lua
local event = actum:event()
```
This will create a new event, but the list of actions binded to this event is empty. Let's bind one !
```lua
local action = event:bind(func)
```
`event:bind()` takes a single argument, the function to call when the event is triggered. The function returns an action as we will see later. You can bind as many function as you want to a single event.
To clear all the actions binded to an event simply run `event:clear()` it will empty it's actions list.
```lua
action:enable()
action:disable()
action:toggle()
```
This three functions controls the state of an action. A disabled function will not be trigerred by an event and will simply be ignored.

## Love bindings
On top of actum are construct bindings. They allow to use it's flexible API to handle events from different frameworks. Actum comes with bindings for Löve2D by default. It's very easy to construct bindings, simply check the [love binding file](https://github.com/loustak/actum/blob/master/love_bind.lua) for an exemple!

## Exemples
A simple exemple of how to use love bindings can be found in exemples/main.lua.
```lua
local lovebind = require('../love_bind')

local actionmousepressed = lovebind.mousepressed:bind(
    function(x, y, button, istouch, presses)
      print('pressed at ' .. x .. ' ' .. y)
    end)

local actionswipe = lovebind.swipe:bind(
    function(vx, vy, button, istouch)
      print('swiped at ' .. vx .. ' ' .. vy)
    end)

local actionkeyreleased = lovebind.keyreleased:bind(
    function(key)
      if key == 'space' then
        print('space pressed')
      end
    end)

function love.draw()
  love.graphics.print('Hello World!', 400, 300)
end

function love.update()
  if lovebind:isswaping(1) then
    print('swaping')
  end
end
```
As you can see we reuse events defined in the love_bind file to bind function and create actions that we can then manipulate.

## Tests
This project use [busted](http://olivinelabs.com/busted/) to run tests. Simply run the command `busted` at the root of the repo, it will both test actum and it's bindings.

## License
This repository use the [MIT license](https://github.com/loustak/actum/blob/master/License).
