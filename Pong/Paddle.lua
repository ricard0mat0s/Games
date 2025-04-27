local love = require("love")

Paddle = Class{}

function Paddle:init(x, y)
  self.x = x
  self.y = y
  self.width = 40
  self.height = 5
  self.speed = 0
end

function Paddle:update(dt)
  self.x = self.x + self.speed * dt
end

function Paddle:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
