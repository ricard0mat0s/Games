WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  squareX = 0
end

function love.update(dt)
  if love.keyboard.isDown('a') then
    squareX = squareX - 10
  elseif love.keyboard.isDown('d') then
    squareX = squareX + 10
  end
end

function love.draw()
  love.graphics.printf("Hello world", 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center')
  
  love.graphics.rectangle("fill", squareX, WINDOW_HEIGHT - 60, 50, 50)
end
