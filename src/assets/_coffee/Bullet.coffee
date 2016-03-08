class Bullet extends Actor
  constructor: (x, y, @speed) ->
    @style = '#000000'
    super(x, y, 20, 20)

  move: ->
    @y -= @speed