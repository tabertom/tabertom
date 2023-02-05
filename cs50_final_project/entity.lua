Entity = Object:extend()

function Entity:new(x, y)
  self.x = x
  self.y = y
  self.width = 0
  self.height = 0
  
  self.speed = {}
  self.speed.x = 0
  self.speed.y = 0
  
  --add a number indicating its HP
  self.hp = 0
  
  -- add a table of previous positions
  self.last = {}
  
  self.last.x = self.x
  self.last.y = self.y
  
  --add a strength value  
  self.strength = 0
end


function Entity:update(dt)
  self.last.x = self.x
  self.last.y = self.y
end


function Entity:draw()


end

function Entity:resolveCollision(e)
    if self:checkCollision(e) then
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

function Entity:collide(e, direction)
    -- collide takes two arguments: the other entity the object collides with, and the direction from which the object is coming fron
    -- depending on the direction, the speed of the object will be affected
    if direction == "right" then
        self.x = e.x - self.width
        if self.strength > e.strength then
          self.x = self.last.x
        end
    elseif direction == "left" then
        self.x = e.x + e.width
        if self.strength > e.strength then
          self.x = self.last.x
        end
    elseif direction == "bottom" then
        self.y = e.y - self.height
        if self.strength > e.strength then
          self.y = self.last.y
        end
    elseif direction == "top" then
        self.y = e.y + e.height
        if self.strength > e.strength then
          self.y = self.last.y
        end
    end
end

-- using the previous x and y positions of the object and the entity that it's colliding with, we can 
-- understand from which direction the object was coming from when it collided
function Entity:wasVerticallyAligned(e)
    return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end

function Entity:wasHorizontallyAligned(e)
    return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end

function Entity:checkCollision(e)
  
  -- e is the other Entity we collide with
  return self.x + self.width > e.x
  and self.x < e.x + e.width
  and self.y + self.height > e.y
  and self.y < e.y + e.height
end

