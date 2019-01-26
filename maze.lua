function camera_track(x, y)
  w = (width / 2) / Zoom
  h = (height / 2) / Zoom
  if x - w >= -500 and x + w <= width + 500 then
    camera:lockX(x, Camera.smooth.damped(2))
  end

  if y - h >= -500 and y + h <= height + 500 then
    camera:lockY(y, Camera.smooth.damped(2))
  end
end

function Reverse (arr)
  local i, j = 1, #arr

  while i < j do
    arr[i], arr[j] = arr[j], arr[i]

    i = i + 1
    j = j - 1
  end
end

function love.load()
  -- Require
  Object = require("src.classic")
  require("src.Entity")
  push = require("src.push")
  Camera = require("src.Camera")

  tick = require ("src.tick")
  flux = require("src.flux")

  Grid = require ("src.jumper.grid")
  Pathfinder = require ("src.jumper.pathfinder")
  -- Require
  local _, _, flags = love.window.getMode()
  width, height = love.window.getDesktopDimensions(flags.display) -- flags.display contem o monitor que esta sendo usado.
  love.graphics.setDefaultFilter('nearest', 'nearest')

  push:setupScreen(800, 600, 800, 600, {fullscreen = false}) -- Trocar para fullscreen depois.
  Zoom = 2
  --camera = Camera(0, 0, Zoom)

  image = love.graphics.newImage("img/teste.png")
  gameScale = 0.3
  map = 
  {
    {0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0},
    {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0},
    {0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0},
  }

  p = {}
  p.x = 500
  p.y = 50

  walkable = 0
  grid = Grid(map)

  myFinder = Pathfinder(grid, 'DIJKSTRA', walkable)

  ball = {}
  ball.x = 50 * 8
  ball.y = 50 * 4
  --flux.to(ball, 2, { x = fim, y = 500}):ease("linear") -- Se usar na update, o mesmo tempo sera calculado a cada frame e isso vai fazer a velocidade de movimento ser desacelerada.

  move = 0
  moving = 0

  followingPlayer = 1
  goal = {}
  defaultX, defaultY = 11, 4
  defaultSX, defaultSY = 8, 4
  endx, endy = defaultX, defaultY
end

function love.update(dt)
  tick.update(dt)
  flux.update(dt)
  require("src.lurker").update()
  if move == 0 and #goal ~= 0 then
    flux.to(ball, 1, { x = goal[1].x * 50, y = goal[1].y * 50 }):ease("linear"):onstart(function() move = 1 end):oncomplete(function() move = 0 table.remove(goal, 1) end)
  end

  if love.keyboard.isDown("w") and moving == 0 then
    flux.to(p, 0.5, { y = p.y - 50 }):ease("linear"):onstart(function() moving = 1 end):oncomplete(function() moving = 0 end)
  end
  if love.keyboard.isDown("a") and moving == 0 then
    flux.to(p, 0.5, { x = p.x - 50 }):ease("linear"):onstart(function() moving = 1 end):oncomplete(function() moving = 0 end)
  end
  if love.keyboard.isDown("s") and moving == 0 then
    flux.to(p, 0.5, { y = p.y + 50 }):ease("linear"):onstart(function() moving = 1 end):oncomplete(function() moving = 0 end)
  end
  if love.keyboard.isDown("d") and moving == 0 then
    flux.to(p, 0.5, { x = p.x + 50 }):ease("linear"):onstart(function() moving = 1 end):oncomplete(function() moving = 0 end)
  end
  if love.keyboard.isDown("t") then
    followingPlayer = followingPlayer * (-1)
    for i, v in ipairs(goal) do
      table.remove(goal, i)
    end
  end



  if followingPlayer == -1 and move == 0 then
    startx, starty = math.floor(ball.x / 50), math.floor(ball.y / 50)
    endx, endy = math.floor(p.x / 50), math.floor(p.y / 50)
    goal = {}
    path, length = myFinder:getPath(startx, starty, endx, endy)
    if path then
      print(('Path found! Length: %.2f'):format(length))
      for node, count in path:iter() do
        k = {}
        k.x = node.x
        k.y = node.y
        table.insert(goal, k)
        print(('Step: %d - x: %d - y: %d'):format(count, goal[#goal].x, goal[#goal].y))
      end
      table.remove(goal, 1)
    end
  elseif move == 0 and followingPlayer == 1 then
    startx, starty = math.floor(ball.x / 50), math.floor(ball.y / 50)

    if math.floor(ball.x / 50) == defaultX and math.floor(ball.y / 50) == defaultY then
      endx, endy = defaultSX, defaultSY
      defaultSX, defaultSY = startx, starty
      defaultX, defaultY = endx, endy
    end

    goal = {}
    path, length = myFinder:getPath(startx, starty, endx, endy)
    if path then
      print(('Path found! Length: %.2f'):format(length))
      for node, count in path:iter() do
        k = {}
        k.x = node.x
        k.y = node.y
        table.insert(goal, k)
        print(('Step: %d - x: %d - y: %d'):format(count, goal[#goal].x, goal[#goal].y))
      end
      table.remove(goal, 1)
    end
  end



end

function love.draw()
  push:start()
  love.graphics.circle("fill", ball.x, ball.y, 10, 60)
  love.graphics.circle("fill", p.x, p.y, 10, 60)
  for i, v in ipairs (map) do
    for j, d in ipairs (map[i]) do
      if (map[i][j] == 1) then
        love.graphics.setColor(1, 1, 1)
        love.graphics.points(j * 50, i * 50)
      else
        love.graphics.setColor(1, 0, 0)
        love.graphics.points(j * 50, i * 50)
      end
    end
  end
  push:finish()
end




function love.keypressed(key)
  if(key == "escape") then
    love.event.quit()
  end
end
