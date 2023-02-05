Brick = Entity:extend()

function Brick:new(x, y, w, hp)
  Brick.super.new(self, x, y)
  self.width = w
  self.height = w
  self.hp = hp
  self.strength = 300
end

function Brick:update(dt)
  Brick.super.update(self, dt)
end


function Brick:draw()
  Brick.super.draw(self)
  love.graphics.setColor(1 / self.hp, 1 / self.hp, 1 / self.hp)
  if playerHit then
    love.graphics.setColor(1 / self.hp, 0.1 / self.hp, 0.1 / self.hp)
  end
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end