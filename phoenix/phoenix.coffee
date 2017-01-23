# within = (point, rect) ->
#   return Math.min(
#     point.x - rect.x,
#     point.y - rect.y,
#     rect.x + rect.width - point.x,
#     rect.y + rect.height - point.y,
#   )

# Event.on 'mouseDidMove', ->
#   mouseLocation = Mouse.location()
#   for window in Window.recent()
#     if within(mouseLocation, window.frame()) > 0
#       window.focus()
#       break

# How far is point inside rect?
within = (point, rect) ->
  return Math.min(
    point.x - rect.x,
    point.y - rect.y,
    rect.x + rect.width - point.x,
    rect.y + rect.height - point.y,
  )


# Calculate the length of the last consecutive series of the same items
class Streak
  constructor: ->
    @length = 0
    @lastItem = undefined

  push: (item) ->
    if @lastItem?.isEqual item
      @length += 1
    else
      @length = 1
      @lastItem = item


focusWindowUnderMouse = do (lastWidowStreak = new Streak) ->
  return ->
    mouseLocation = Mouse.location()
    window = Window.focused()
    return unless window?
    return if within(mouseLocation, Window.focused().frame()) > 0
    for window in Window.recent()
      distWithin = within(mouseLocation, window.frame())
      if distWithin > 40
        lastWidowStreak.push window
        window.focus()  if lastWidowStreak.length >= 2
        return window
      else if distWithin > -40
        return window
    return false


focusWindowUnderMouseEventId = null

Key.on '/', ['ctrl', 'alt', 'cmd'], ->
  if focusWindowUnderMouseEventId?
    Event.off focusWindowUnderMouseEventId
    focusWindowUnderMouseEventId = null
    Phoenix.notify("Focus Follows Mouse: OFF")
  else
    focusWindowUnderMouseEventId = Event.on 'mouseDidMove', focusWindowUnderMouse
    Phoenix.notify("Focus Follows Mouse: ON")
