Player = Entity:extend()

function Player:new(x,y, db)
  Player.super.new(self, x, y)
  self.hp = 3
  self.width = 30
  self.height = 10
  self.speed.x = 200
  self.speed.y = 0
  self.strength = 100
  self.db = 0
  self.ball = 0
end

function Player:update(dt, db)
  direction = 0
  Player.super.update(self, dt)
  if love.keyboard.isDown("left") then
    self.x = self.x - self.speed.x *dt
    direction = 1
  elseif love.keyboard.isDown("right") then
    self.x = self.x + self.speed.x * dt
    direction = 2
  end
  
  self.db = db
  if db > 0 then
    self.width = self.width + 1
    self.ball = self.ball + (db % 2)
  end
  
  
  -- if hp reaches 0, then restart
  if self.hp == 0 then
    love.load()
  end
  
  
  if colorDuration > 0 then
    colorDuration = colorDuration - dt
  end
  
  
  --if colorDuration is 0, it means we shouldn't consider the player as being still hit
  if colorDuration <= 0 then
    playerHit = false
  end
end

function Player:keyPressed(key)
  if key == "space"  and #moving_objects < 5 then
    ball_shoot_sfx:play()
    if direction == 1 then
      table.insert(moving_objects, Ball(self.x + self.width/2, self.y - 15, 5, -200 - 8 * destroyed_bricks , -200 - 8 * destroyed_bricks))
    elseif direction == 2 then
      table.insert(moving_objects, Ball(self.x + self.width/2, self.y - 15, 5, 200 + 8 * destroyed_bricks, -200 - 8 *destroyed_bricks))
    else
      table.insert(moving_objects, Ball(self.x + self.width/2, self.y - 15, 5, 0, -300 - 8 * destroyed_bricks))
    end
  end
end

function Player:draw()
  Player.super.draw(self)
  love.graphics.setColor(1, 1, 1)
  if playerHit then
    love.graphics.setColor(1, 0.1, 0.1)
  end
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
  