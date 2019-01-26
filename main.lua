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

function love.load()
    Object = require("src.classic")
    push = require("src.push")
    require("src.Entity")
    require("src.Character")
    require("src.Player")
    require("src.Tree")
    require("src.Obj")
    require("src.Background")
    p = Player("img/player.png", 0, 79, 49, 85, 10, 5, 10, 200, 50)
    love.window.setFullscreen(true)
    frames = 1
    background = Background("img/ground.png", 0, 0, 1000, 740, 0, 1)
    for i, v in ipairs(scenary) do
        for j, d in ipairs(scenary[i]) do
            if(scenary[i][j] == 0) then 
                table.insert(jungle, Tree("img/teste.png", j * 80, i * 80, 250, 325, 0, 1))
                table.insert(jungle, Tree("img/teste.png", j * 85, i * 85, 250, 325, 0, 1))
            end
        end
    end

    --Require--
  local _, _, flags = love.window.getMode()
  width, height = love.window.getDesktopDimensions(flags.display) -- flags.display contem o monitor que esta sendo usado.
  love.graphics.setDefaultFilter('nearest', 'nearest') -- Filtro para que o render não use blur e deixe um aspecto pixelado.

  Camera = require("src.Camera") -- Camera.
  push:setupScreen(width, height, width, height, {fullscreen = true}) -- GameScreen Settings.

  Zoom = 2
  camera = Camera(0, 0, Zoom)
  camera:lookAt(0, 0) 
end


function love.update(dt)
    p:update(dt, frames)
    camera_track(p:getCoordinateX(), p:getCoordinateY())
    frames = (frames % 61) + 1
    -- p:checkCollision(t)
end

function love.draw()
    push:start()
    camera:attach()
    -- inicio da draw
    background:draw()
    for i, v in ipairs(jungle) do
        v:draw()
    end
    p:draw()
    -- fim da draw
    camera:detach()
    push:finish()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end