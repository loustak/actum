local lovebind = require('../love_bind')

lovebind.mousepressed:bind(function(x, y, button, istouch, presses)
  print('pressed at ' .. x .. ' ' .. y)
end)

lovebind.swipe:bind(function(vx, vy, button, istouch)
  print('swiped at ' .. vx .. ' ' .. vy)
end)

lovebind.keyreleased:bind(function(key)
  if key == 'space' then
    print(lovebind:isswaping(1))
  end
end)

function love.draw()
  love.graphics.print('Hello World!', 400, 300)
end
