class Player extends Actor
  constructor: (x, y) ->
    @img = new Image()
    @img.src = "./assets/img/Blinky.png"
    @mouseX = 0
    @mouseY = 0
    @bullets = []
    super(x, y, 50, 50)

  update: (e) ->
    rect = e.target.getBoundingClientRect()
    @mouseX = e.clientX - (rect.left)
    @mouseY = e.clientY - (rect.top)
    @x = @mouseX-25
    @y = @mouseY-25

  shoot: ->
    @bullets.push(new Bullet @mouseX, @mouseY, 20)
    console.log @bullets.length