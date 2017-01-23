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


focusWindowUnderMouse = do (lastWindowStreak = new Streak) ->
  return (location) ->
    window = Window.at(location)
    return unless window?
    lastWindowStreak.push window
    window.raise()  if lastWindowStreak.length >= 1
    return window


focusWindowUnderMouseEventId = null

Key.on '/', ['ctrl', 'alt', 'cmd'], ->
  if focusWindowUnderMouseEventId?
    Event.off focusWindowUnderMouseEventId
    focusWindowUnderMouseEventId = null
    Phoenix.notify("Focus Follows Mouse: OFF")
  else
    focusWindowUnderMouseEventId = Event.on 'mouseDidMove', focusWindowUnderMouse
    Phoenix.notify("Focus Follows Mouse: ON")
