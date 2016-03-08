Number::center = ->
  this.half()

Number::half = ->
  this / 2

#キャンバスの初期処理
canvasMain = $('#mycanvas1')[0] #メインキャンバス
canvasBuff = $('#mycanvas2')[0] #バッファ処理用キャンバス http://y-stream.blogspot.jp/2013/02/jscanvas.html

ctxMain = canvasMain.getContext('2d')
ctxBuff = canvasBuff.getContext('2d')

class Actor
  constructor: (@x, @y, @width, @height) ->


class Player extends Actor
  constructor: ->
    @img = new Image()
    @img.src = "./assets/img/Blinky.png"
    @bullets = []
    super(canvasMain.width.center()-25, canvasMain.height-50, 50, 50)

  update: (e) ->
    rect = e.target.getBoundingClientRect()
    mouseX = e.clientX - (rect.left)
    mouseY = e.clientY - (rect.top)
    @x = mouseX-25
    @y = mouseY-25

  shoot: ->
    @bullets.push(new Bullet @x, @y, 20)
    console.log @bullets.length

class Bullet extends Actor
  constructor: (x, y, @speed) ->
    @style = '#000000'
    super(x, y, 20, 20)

  move: ->
    @y -= @speed

# スタートボタン押下後処理
$('#start-btn').click ->
  ctxMain.clearRect 0, 0, canvasMain.width, canvasMain.height
  #プレイヤー初期描写
  player = new Player()
  player.img.onload = ->
    ctxMain.drawImage player.img, player.x, player.y, player.width, player.height

  # 画面内のマウス座標が変化した時の処理
  canvasMain.addEventListener 'mousemove', (e) ->
    ctxMain.clearRect 0, 0, canvasMain.width, canvasMain.height
    player.update(e)
    ctxMain.drawImage player.img, player.x, player.y, player.width, player.height
    # 弾の移動と描写
    for bullet in player.bullets
      ctxMain.beginPath()
      ctxMain.fillStyle = bullet.style
      ctxMain.arc bullet.x, bullet.y , 20, 0, Math.PI * 2, false
      ctxMain.fill()
  , false

  # 画面内でクリックした時の処理
  canvasMain.addEventListener 'click', (e) ->
      player.shoot()
  , false

  main = ->
    # 画面の削除
    ctxMain.clearRect 0, 0, canvasMain.width, canvasMain.height

    # プレイヤーの描写
    ctxMain.drawImage player.img, player.x, player.y, player.width, player.height

    # 弾の移動と描写
    for bullet in player.bullets
      bullet.move()
      ctxMain.beginPath()
      ctxMain.fillStyle = bullet.style
      ctxMain.arc bullet.x, bullet.y , 20, 0, Math.PI * 2, false
      ctxMain.fill()
    setTimeout main, 20

  main()

init = ->
  ctxMain.clearRect 0, 0, canvasMain.width, canvasMain.height
  #黒く塗りつぶす
  ctxMain.beginPath();
  ctxMain.fillStyle = '#000000'
  ctxMain.fillRect 0, 0, canvasMain.width, canvasMain.height
  #初期メッセージを画面表示
  ctxMain.font = "42px 'ＭＳ Ｐゴシック'";
  ctxMain.textAlign = "center";
  ctxMain.strokeStyle = "white";
  ctxMain.strokeText("Push Start Button!!", canvasMain.width.center(), canvasMain.height.center());

init()