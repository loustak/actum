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

    function action:unbind()
      table.remove(event.actions, index)
      self = nil
    end

    self.actions[index] = action
    return action
  end

  function event:trigger(...)
    local max = #self.actions
    for i = 1, max do
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
