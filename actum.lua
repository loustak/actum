local actum = {}
actum.events = {}

function actum:clear()
  self.events = {}
end

function actum:newaction(func)
  local action = {}
  action.func = func
  action.enabled = true

  function action:enable()
    self.enabled = true
  end

  function action:disable()
    self.enabled = false
  end

  function action:toggle()
    self.enabled = not self.enabled
  end

  return action
end

function actum:newevent()
  local event = {}
  event.actions = {}

  function event:clear()
    self.actions = {}
  end

  function event:bind(func)
    local index = #self.actions + 1
    local action = actum:newaction(func)
    self.actions[index] = action
    return action
  end

  function event:trigger(...)
    for _, action in pairs(self.actions) do
      if action.enabled then action.func(...) end
    end
  end

  return event
end

function actum:event()
  local event = self:newevent()
  local index = #self.events + 1
  self.events[index] = event
  return event
end

return actum
