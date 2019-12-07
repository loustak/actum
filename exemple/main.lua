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
