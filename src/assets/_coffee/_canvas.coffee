#キャンバスの初期処理
canvasMain = $('#mycanvas1')[0] #メインキャンバス
canvasBuff = $('#mycanvas2')[0] #バッファ処理用キャンバス http://y-stream.blogspot.jp/2013/02/jscanvas.html

#2Dコンテキスト
ctxMain = canvasMain.getContext('2d')
ctxBuff = canvasBuff.getContext('2d')

cW = canvasMain.width #キャンバス横サイズ
cH = canvasBuff.height #キャンバス縦サイズ

mouseX = 0
mouseY = 0

class Actor
  constructor: (imageName) ->  
    @imageName = imageName

  init: (imgDX, imgDY, imgDW, imgDH) ->
    img = new Image()
    img.src = "./assets/img/#{@imageName}.png"
    img.onload = ->
      #表示クリア
      ctxBuff.clearRect 0, 0, cW, cH
      ctxBuff.drawImage img, imgDX, imgDY, imgDW, imgDH
      imageData = ctxBuff.getImageData 0, 0, cW, cH 
      ctxMain.putImageData imageData, 0, 0

  move: (e) ->

  shoot: (e) ->


class Player extends Actor
  constructor: (imageName) ->
    super(imageName)
    @bullets = []

  draw: ->
    img = new Image()
    img.src = "./assets/img/#{@imageName}.png"
    img.onload = ->
      #表示クリア
      ctxBuff.clearRect 0, 0, cW, cH
      ctxBuff.drawImage img, mouseX-25, mouseY-25, 50, 50
      imageData = ctxBuff.getImageData 0, 0, cW, cH 
      ctxMain.putImageData imageData, 0, 0

  move: (e) ->
    #座標調整
    adjustMouseXY e
    @draw()


  update: ->
    @draw()


  shoot: (e) ->
    @bullets.push(new Bullet('test'))
    i = 0
    test = ->
      console.log i
      #表示クリア
      ctxBuff.clearRect 0, 0, cW, cH
      #座標調整
      adjustMouseXY e
      #円を描く
      ctxBuff.beginPath()
      ctxBuff.fillStyle = '#000000'
      ctxBuff.arc mouseX, mouseY - i, 20, 0, Math.PI * 2, false
      ctxBuff.fill()

      imageData = ctxBuff.getImageData 0, 0, cW, cH 
      ctxMain.putImageData imageData, 0, 0
      # bullet.init(cW/2-25, cH-50, 50, 50)
      # bullet.move(e)

      i = i + 10
      if i < 500
        setTimeout test, 1
      else
        console.log 'finish'
    test()



class Bullet extends Actor
  constructor: (imageName) ->
    super(imageName)
    @x = mouseX
    @y = mouseY
    @i = 0
  move: ->
    @y 



$('#start-btn').click ->
  player = new Player('Blinky')
  player.init(cW/2-25, cH-50, 50, 50)
  bullets = []

  #イベント：マウス移動
  canvasMain.onmousemove = (e) ->
    player.move(e)
    #

  #イベント：マウスダウン
  canvasMain.onmousedown = (e) ->
    player.shoot(e)

  main = ->
    # player位置の更新
    player.update

    for bullet in player.bullets
      bullet.move


    setTimeout main, 20

  main()




init = ->
  ctxMain.clearRect 0, 0, cW, cH
  #黒く塗りつぶす
  ctxMain.beginPath();
  ctxMain.fillStyle = '#000000'
  ctxMain.fillRect 0, 0, cW, cH
  #初期メッセージを画面表示
  ctxMain.font = "42px 'ＭＳ Ｐゴシック'";
  ctxMain.textAlign = "center";
  ctxMain.strokeStyle = "white";
  ctxMain.strokeText("Push Start Button!!", cW/2, cH/2);

adjustMouseXY = (e) ->
  rect = e.target.getBoundingClientRect()
  mouseX = e.clientX - (rect.left)
  mouseY = e.clientY - (rect.top)


init()