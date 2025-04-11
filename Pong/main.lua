local love = require("love")

push = require 'push'

PADDLE_SPEED = 200

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  smallFont = love.graphics.newFont('font.ttf', 8)
  scoreFont = love.graphics.newFont('font.ttf', 32)
  love.graphics.setFont(smallFont)

  player1Score = 0
  player2Score = 0

  player1X = 20
  player2X = VIRTUAL_WIDTH - 40

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
                  fullscreen = false,
                  resizable = false,
                  vsync = true})
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.update(dt)
  if love.keyboard.isDown('d') then
    player1X = player1X + PADDLE_SPEED * dt
  elseif love.keyboard.isDown('a') then
    player1X = player1X + -PADDLE_SPEED * dt
  end

  if love.keyboard.isDown('right') then
    player2X = player2X + PADDLE_SPEED * dt
  elseif love.keyboard.isDown('left') then
    player2X = player2X + -PADDLE_SPEED * dt
  end

end

function love.draw()
  push:apply('start')

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  love.graphics.printf("Hello world", 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

  love.graphics.rectangle('fill', player1X, 10, 20, 5)
  love.graphics.rectangle('fill', player2X, VIRTUAL_HEIGHT - 20, 20, 5)

  push:apply('end')

end
