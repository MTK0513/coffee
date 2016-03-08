(function() {
  var Actor, Bullet, Player, canvasBuff, canvasMain, ctxBuff, ctxMain, init,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Number.prototype.center = function() {
    return this.half();
  };

  Number.prototype.half = function() {
    return this / 2;
  };

  canvasMain = $('#mycanvas1')[0];

  canvasBuff = $('#mycanvas2')[0];

  ctxMain = canvasMain.getContext('2d');

  ctxBuff = canvasBuff.getContext('2d');

  Actor = (function() {
    function Actor(x1, y1, width, height) {
      this.x = x1;
      this.y = y1;
      this.width = width;
      this.height = height;
    }

    return Actor;

  })();

  Player = (function(superClass) {
    extend(Player, superClass);

    function Player() {
      this.img = new Image();
      this.img.src = "./assets/img/Blinky.png";
      this.bullets = [];
      Player.__super__.constructor.call(this, canvasMain.width.center() - 25, canvasMain.height - 50, 50, 50);
    }

    Player.prototype.update = function(e) {
      var mouseX, mouseY, rect;
      rect = e.target.getBoundingClientRect();
      mouseX = e.clientX - rect.left;
      mouseY = e.clientY - rect.top;
      this.x = mouseX - 25;
      return this.y = mouseY - 25;
    };

    Player.prototype.shoot = function() {
      this.bullets.push(new Bullet(this.x, this.y, 20));
      return console.log(this.bullets.length);
    };

    return Player;

  })(Actor);

  Bullet = (function(superClass) {
    extend(Bullet, superClass);

    function Bullet(x, y, speed) {
      this.speed = speed;
      this.style = '#000000';
      Bullet.__super__.constructor.call(this, x, y, 20, 20);
    }

    Bullet.prototype.move = function() {
      return this.y -= this.speed;
    };

    return Bullet;

  })(Actor);

  $('#start-btn').click(function() {
    var main, player;
    ctxMain.clearRect(0, 0, canvasMain.width, canvasMain.height);
    player = new Player();
    player.img.onload = function() {
      return ctxMain.drawImage(player.img, player.x, player.y, player.width, player.height);
    };
    canvasMain.addEventListener('mousemove', function(e) {
      var bullet, i, len, ref, results;
      ctxMain.clearRect(0, 0, canvasMain.width, canvasMain.height);
      player.update(e);
      ctxMain.drawImage(player.img, player.x, player.y, player.width, player.height);
      ref = player.bullets;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        bullet = ref[i];
        ctxMain.beginPath();
        ctxMain.fillStyle = bullet.style;
        ctxMain.arc(bullet.x, bullet.y, 20, 0, Math.PI * 2, false);
        results.push(ctxMain.fill());
      }
      return results;
    }, false);
    canvasMain.addEventListener('click', function(e) {
      return player.shoot();
    }, false);
    main = function() {
      var bullet, i, len, ref;
      ctxMain.clearRect(0, 0, canvasMain.width, canvasMain.height);
      ctxMain.drawImage(player.img, player.x, player.y, player.width, player.height);
      ref = player.bullets;
      for (i = 0, len = ref.length; i < len; i++) {
        bullet = ref[i];
        bullet.move();
        ctxMain.beginPath();
        ctxMain.fillStyle = bullet.style;
        ctxMain.arc(bullet.x, bullet.y, 20, 0, Math.PI * 2, false);
        ctxMain.fill();
      }
      return setTimeout(main, 20);
    };
    return main();
  });

  init = function() {
    ctxMain.clearRect(0, 0, canvasMain.width, canvasMain.height);
    ctxMain.beginPath();
    ctxMain.fillStyle = '#000000';
    ctxMain.fillRect(0, 0, canvasMain.width, canvasMain.height);
    ctxMain.font = "42px 'ＭＳ Ｐゴシック'";
    ctxMain.textAlign = "center";
    ctxMain.strokeStyle = "white";
    return ctxMain.strokeText("Push Start Button!!", canvasMain.width.center(), canvasMain.height.center());
  };

  init();

}).call(this);
