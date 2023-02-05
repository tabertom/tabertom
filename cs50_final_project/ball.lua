Ball = Entity:extend()


--for the ball, we're going to draw a circle, but we will use a rectangular hitbox
--the square hitbox is going to have a side of 2r, where r is the circle's radius
function Ball:new(x, y, r, speed_x, speed_y)
  Ball.super.new(self, x, y)
  self.width = r * 2
  self.height = r * 2
  self.speed.y = speed_y
  self.speed.x = speed_x
  self.r = r
  self.strength = 1
  self.hp = -1
  self.db = db
  
end

function Ball:update(dt, db)
  Ball.super.update(self, dt)
  self.x = self.x + self.speed.x * dt
  self.y = self.y + self.speed.y * dt
  
  if self.y > love.graphics.getHeight() or self.y < 0 then
    self.hp = 0
  end
  
  self.db = db
end

function Ball:collide(e, direction)
  e.hp = e.hp - 1
    -- collide takes two arguments: the other entity the object collides with, and the direction from which the object is coming fron
    -- depending on the direction, the speed of the object will be affected
      if direction == "right" then
          self.x = e.x - self.width
          self.speed.x = -self.speed.x
      elseif direction == "left" then
          self.x = e.x + e.width
          self.speed.x = -self.speed.x
          
      elseif direction == "bottom" then
          self.y = e.y - self.height
          self.speed.y = -self.speed.y

      elseif direction == "top" then
          self.y = e.y + e.height
          self.speed.y = -self.speed.y
      end
end

function Ball:resolveCollision(e)
    if self:checkCollision(e) then
      if e == player then
        colorDuration = 0.75
        pShakeDuration = 0.5
        playerHit = true
        player_hurt_sfx:play()
      else
        ball_hit_sfx:play()
      end
        if self:wasVerticallyAligned(e) then
            -- knowing the object is either on the right or on the left of the entity, if it's not on the right of the object, it must be on the left
            if self.x + self.width/2 < e.x + e.width/2 then
              self:collide(e, "right")
            else
              self:collide(e, "left")
            end
        elseif self:wasHorizontallyAligned(e) then
            -- knowing the object is either above or under the entity, if it's not under the object, it must be above
            if self.y + self.height/2 < e.y + e.height/2 then
              self:collide(e, "bottom")
            else
              self:collide(e, "top")
            end
        end
        -- There was collision, return true
        return true
    end
    -- There was NO collision, return false
    return false
end

function Ball:draw(dt)
  Ball.super.draw(self)
  love.graphics.setColor(1, 1, 1)
  if playerHit then
    love.graphics.setColor(1, 0.1, 0.1)
  end
  love.graphics.circle("fill", self.x + self.r, self.y + self.r, self.r)
end