Line = Entity:extend()

function Line:new(x1, y1, x2, y2)
  Line.super.new(self, x1, y1)
  self.x2 = x2
  self.y2 = y2
  self.width = 8
  self.height = y2 - y1
  self.strength = 300
  self.hp = -1

  
end

function Line:update(dt)
  Line.super.update(self, dt)
end


function Line:draw()
  Line.super.draw(self)
  love.graphics.setColor(255, 255, 255)
  if playerHit then
    love.graphics.setColor(1, 0.1 , 0.1)
  end
  love.graphics.setLineWidth(self.width)
  love.graphics.line(self.x + 3, self.y, self.x2 + 3, self.y2)
end
  