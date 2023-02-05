function love.load()
  Object = require "classic"
  require "entity"
  require "player"
  require "brick"
  require "line"
  require "ball"
  
  -- gap is a number that determines how far the lines are from each other
  local gap = 200
  local window_height = love.graphics.getHeight()
  local window_width = love.graphics.getWidth()
  
  -- keep track of how many bricks are destroyed
  destroyed_bricks = 0
  
  player = Player(window_width/2,  4 * window_height/5, destroyed_bricks)
  line1 = Line(window_width/2 - gap, 0, window_width/2 - gap, window_height)
  line2 = Line(window_width / 2 + gap, 0, window_width / 2 + gap, window_height)
  
  
  --sfx
  brick_sfx = love.audio.newSource("brick_destroy.wav", "static")
  ball_hit_sfx = love.audio.newSource("ball_hit.wav", "static")
  ball_shoot_sfx = love.audio.newSource("ball_shoot.wav", "static")
  player_hurt_sfx = love.audio.newSource("player_hurt.wav", "static")
    
  --brick size 
  local brick_width = 30
  
  --brick map: every 1 represents a brick
  
  brick_map = {
    {20, 10, 10, 10, 10, 10, 10, 20},
    {0, 10, 8, 8, 8, 8, 8, 10},
    {0, 8, 5, 5, 5, 5, 8, 0},
    {0, 0, 6, 4, 4, 4, 6, 0},
    {0, 0, 4, 3, 3, 4, 0, 0},
    {0, 0, 0, 3, 2, 3, 0, 0} 
  }
  
  bgImage = love.graphics.newImage("background.png")

  
  --table of all the stationary objects in the game
  stop_objects = {}
  
  --duration value of how long the screen should shake when brick is destroyed
  shakeDuration = 0
  
  --duration value of how long the screen should shake when player is hit
  pShakeDuration = 0
  
  --another timer to determine how long the screen should shake
  shakeWait = 0
  pShakeWait = 0
  
  --offset values by which to shake the camera when a brick is destroyed/ player is hit
  shakeOffset = { x = 0, y = 0}
  pShakeOffset = { x = 0, y = 0}
  
  --duration value of how long player is colored red when hit by ball
  colorDuration = 0
  
  table.insert(stop_objects, line1)
  table.insert(stop_objects, line2)
  
  --playerHit will help change color of all objects when player gets hit
  playerHit = false
  
  --table of all moving objects in the game
  moving_objects = {}
  
  --font for score and hp
  font= love.graphics.newFont("Square.ttf", 15)
  love.graphics.setFont(font)
  
  print(window_height)
  
  
  --even-number rows (2nd row, 4th row...) will be slightly deviated to the right to make the brick structure more appealing
  for i,row in ipairs(brick_map) do
    for j, brick in ipairs(row) do
      if brick > 0 then
        if i % 2 == 1 then
          table.insert(stop_objects, Brick(window_width/2 - gap + 30 + (j-1) * 3/2 * brick_width, 20 + (i - 1) * 3/2 * brick_width, brick_width, brick))
        else
          table.insert(stop_objects, Brick(window_width/2 - gap + 22 - 1/2 * brick_width + (j-1) * 3/2 * brick_width, 20 + (i - 1) * 3/2 *    brick_width          , brick_width, brick))
        end
      end
    end
  end
end



function love.update(dt)
  for i, stop_object in ipairs(stop_objects) do
    stop_object:update(dt)
    if stop_object.hp == 0 then
      table.remove(stop_objects, i)
      destroyed_bricks = destroyed_bricks + 1
      shakeDuration = 0.3
      d_player = true
      brick_sfx:play()
    end
  end
  for j, object in ipairs(moving_objects) do
    object:update(dt)
    if object.hp == 0 then
      table.remove(moving_objects, j)
    end
  end
  
  if d_player then
    player:update(dt, destroyed_bricks)
    d_player = false
  else
    player:update(dt, 0)
  end
        
  --for each object check collision with every wall
  for i,stop_object in ipairs(stop_objects) do
    for j,object in ipairs(moving_objects) do
       object:resolveCollision(stop_object)
     end
  end
  
  for j,object in ipairs(moving_objects) do
    object:resolveCollision(player)
  end
  
  for i,object in ipairs(stop_objects) do
    player:resolveCollision(object)
  end
  
  if shakeDuration > 0 then
    shakeDuration = shakeDuration - dt
    if shakeWait > 0 then
      shakeWait = shakeWait - dt
    else
      shakeOffset.x = love.math.random(-5, 5)
      shakeOffset.y = love.math.random(-5, 5)
      shakeWait = 0.05
    end
  end
  
  if pShakeDuration > 0 then
    pShakeDuration = pShakeDuration - dt
    if pShakeWait > 0 then
      pShakeWait = pShakeWait - dt
    else
      pShakeOffset.x = love.math.random(-7, 7)
      pShakeOffset.y = love.math.random(-7, 7)
      pShakeWait = 0.05
    end
  end
end

function love.keypressed(key)
  player:keyPressed(key)
end

function love.draw()
  love.graphics.draw(bgImage, -1, 50)
  if shakeDuration > 0 then
    love.graphics.translate(shakeOffset.x, shakeOffset.y)
  end
  if pShakeDuration > 0 then
    love.graphics.translate(pShakeOffset.x, pShakeOffset.y)
  end
  for j,object in ipairs(moving_objects) do
    object:draw()
  end
  for i,stop_object in ipairs(stop_objects) do
    stop_object:draw()
  end
  player:draw()
  
  love.graphics.print("Score: " .. destroyed_bricks, 10, 10)
  love.graphics.print("HP: " .. player.hp, 760, 10)
end