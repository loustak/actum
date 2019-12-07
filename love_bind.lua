local actum = require('actum')

local lovebind = {}
lovebind.swipe = {}

-- Mouse events
lovebind.mousepressed = actum:event()

function love.mousepressed(...)
  lovebind.mousepressed:trigger(...)
  lovebind:startswipe(...)
end

lovebind.mousereleased = actum:event()

function love.mousereleased(...)
  lovebind.mousereleased:trigger(...)
  lovebind:endswipe(...)
end

lovebind.mousemoved = actum:event()

function love.mousemoved(...)
  lovebind.mousemoved:trigger(...)
end

-- Keyboard events
lovebind.keypressed = actum:event()

function love.keypressed(...)
  lovebind.keypressed:trigger(...)
end

lovebind.keyreleased = actum:event()

function love.keyreleased(...)
  lovebind.keyreleased:trigger(...)
end

-- Custom event to handle swipes
lovebind.swipe = actum:event()

function lovebind:startswipe(x, y, button)
  local obj = {}
  obj.startx = x
  obj.starty = y
  self.swipe[button] = obj
end

function lovebind:endswipe(x, y, button, istouch)
  local obj = self.swipe[button]

  local vx = obj.startx - x
  local vy = obj.starty - y

  self.swipe[button] = nil

  if vx ~= 0 or vy ~= 0 then
    lovebind.swipe:trigger(vx, vy, button, istouch)
  end
end

function lovebind:isswaping(button)
  return self.swipe[button] ~= nil
end

return lovebind
