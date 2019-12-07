local actum = require('../actum')

local func = function() end

describe('Events', function()

  before_each(function()
    actum:clear()
  end)
  
  describe('when registered', function()

    it('should increase the number of entries in the actum.events table', function()
      actum:event()
      assert.are.equal(1, #actum.events)
    end)
    
    it('should return an object', function()
      local event = actum:event()
      assert.are.same({}, event.actions)
      assert.is_function(event.clear)
      assert.is_function(event.bind)
      assert.is_function(event.trigger)
    end)

    it('should have differents tables', function()
      local event1 = actum:event()
      local event2 = actum:event()
      assert.are_not.equals(event1.actions, event2.actions)
    end)

  end)

  describe('binded', function()
    
    it('should add an action to the actions table', function()
      local event = actum:event()
      local action = event:bind(func)
      assert.is_function(action.func)
      assert.is_function(action.enable)
      assert.is_function(action.disable)
      assert.is_function(action.toggle)
    end)

  end)

  describe('triggered', function()

    it('should call all registered functions', function()
      local event = actum:event()

      local spiedfunc1 = spy.new(func)
      local spiedfunc2 = spy.new(func)

      event:bind(spiedfunc1)
      event:bind(spiedfunc2)
      event:trigger()

      assert.spy(spiedfunc1).was.called()
      assert.spy(spiedfunc2).was.called()
    end)
  end)

end)
