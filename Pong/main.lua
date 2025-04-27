local love = require("love")

push = require 'push'

Class = require 'class'

require 'Ball'
require 'Paddle'

PADDLE_SPEED = 200

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  math.randomseed(os.time())

  smallFont = love.graphics.newFont('font.ttf', 8)
  scoreFont = love.graphics.newFont('font.ttf', 32)
  love.graphics.setFont(smallFont)

  love.window.setTitle('Pong')

  player1Score = 0
  player2Score = 0

  Player1 = Paddle(20, 10)
  Player2 = Paddle(VIRTUAL_WIDTH - 40, VIRTUAL_HEIGHT - 20)

  Ball = Ball(VIRTUAL_WIDTH / 2 -2, VIRTUAL_HEIGHT / 2 - 2, 5, 5)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
                  fullscreen = false,
                  resizable = false,
                  vsync = true})

  gameState = 'start'
end

function love.update(dt)
  if love.keyboard.isDown('d') then
    Player1.speed = PADDLE_SPEED
  elseif love.keyboard.isDown('a') then
    Player1.speed = -PADDLE_SPEED
  else
    Player1.speed = 0
  end

  print(Player2.x)

  if Ball.x > Player2.x + 40 then
    Player2.speed = PADDLE_SPEED
  elseif Ball.x < Player2.x then
    Player2.speed = -PADDLE_SPEED
  else
    Player2.speed = 0
  end

  Player1:update(dt)
  Player2:update(dt)

  if Ball:collide(Player1) then
    Ball.dy = -Ball.dy * 1.03
    Ball.y = Player1.y + 5

    if Ball.dx < 0 then
      Ball.dx = -math.random(10, 150)
    else
      Ball.dx = math.random(10, 150)
    end
  end

  if Ball:collide(Player2) then
    Ball.dy = -Ball.dy * 1.03
    Ball.y = Player2.y - 4

    if Ball.dx < 0 then
      Ball.dx = -math.random(10, 150)
    else
      Ball.dx = math.random(10, 150)
    end
  end

  if Ball.x <= 0 then
    Ball.x = 0
    Ball.dx = -Ball.dx
  end

  if Ball.x >= VIRTUAL_WIDTH - 4 then
    Ball.x = VIRTUAL_WIDTH - 4
    Ball.dx = -Ball.dx
  end

  if Ball.y < 0 then
    player2Score = player2Score + 1
    Ball:reset()
    gameState = 'start'
  end

  if Ball.y > VIRTUAL_HEIGHT then
    player1Score = player1Score + 1
    Ball:reset()
    gameState = 'start'
  end

  if gameState == 'play' then
    Ball:update(dt)
  end

end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'

      Ball:reset()
    end
  end
end

function love.draw()
  push:apply('start')

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  if gameState == 'start' then
    love.graphics.setFont(smallFont)
    love.graphics.printf('Welcome to Pong', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to begin', 0, 20, VIRTUAL_WIDTH, 'center')
  end
  love.graphics.setFont(scoreFont)
  love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 15)
  love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 2 - 15)


  Ball:render()
  Player1:render()
  Player2:render()

  displayFPS()

  push:apply('end')

end

function displayFPS()
  love.graphics.setFont(smallFont)
  love.graphics.setColor(0, 255/255, 0, 255/255)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

