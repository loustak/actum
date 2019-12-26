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
  event.n = 0

  function event:clear()
    self.actions = {}
    self.n = 0
  end

  function event:bind(func)
    local action = actum:newaction(func)
    self.n = self.n + 1
    action.index = self.n

    function action:unbind()
      table.remove(event.actions, self.index)
      event.n = event.n - 1
      self = nil
    end

    self.actions[self.n] = action
    return action
  end

  function event:trigger(...)
    for i = 1, self.n do
      local action = self.actions[i]
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

function actum:clean()
  for _, event in ipairs(self.events) do
    for _, action in ipairs(event.actions) do
      action:unbind()
    end
    event = {}
  end

  self.events = {}
end

return actum
