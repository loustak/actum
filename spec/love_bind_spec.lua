require('../mocks/love_mock')
local lovebind = require('../love_bind')

describe('Love bind', function()

  describe('swipe', function()
    
    it('should depends of the button', function()
      local x, y, button = 0, 0, 1
      lovebind:startswipe(x, y, button)
      local obj = {
        startx = x,
        starty = y
      }
      assert.are.same(obj, lovebind.swipe[button])
      assert.are.equals(nil, lovebind.swipe[2])
    end)

    it('should trigger when the swipe vector is not null', function()
      local func = function() end
      local spyfunc = spy.new(func)
      lovebind.swipe:bind(spyfunc)
      lovebind:startswipe(0, 0, 1)
      lovebind:endswipe(100, 0, 1)
      assert.spy(spyfunc).was_called(1)
    end)

    it('should be detectable', function()
      lovebind:startswipe(0, 0, 1)
      local isswaping = lovebind:isswaping(1)
      local isnotswaping = lovebind:isswaping(2)
      assert.True(isswaping)
      assert.False(isnotswaping)
    end)

    it('should not trigger when the swipe vector is null', function()
      local func = function() end
      local spyfunc = spy.new(func)
      lovebind.swipe:bind(spyfunc)
      lovebind:startswipe(0, 0, 1)
      lovebind:endswipe(0, 0, 1)
      assert.spy(spyfunc).was_not_called()
    end)

  end)

end)
