function camera_track(x, y)
    w = (width / 2) / Zoom
    h = (height / 2) / Zoom
    if x - w >= -2000 and x + w <= width + 2000 then
      camera:lockX(x, Camera.smooth.damped(2))
    end
  
    if y - h >= -2000 and y + h <= height + 2000 then
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
    baseImage = love.image.newImageData("img/maze.png")
    -- local testTable = {}
    for i=1, 99 do
        table.insert(scenary, {})
        for j=1, 99 do
           local r, g, b, a = baseImage:getPixel(i, j)
           r = math.floor(r)
           g = math.floor(g)
           b = math.floor(b)
           print(r, g, b)
           if (r == 0 and g == 0 and b == 0) then
            table.insert(scenary[i], 0)
           elseif (r == 1 and g == 0 and b ==0) then
            p = Player("img/player.png", i * 16, j * 16, 49, 85, 10, 5, 10, 200, 50)
            else
            table.insert(scenary[i], 1)
           end

        end
    end
    -- for i, baseImage:getWidth() - 1 do
    --     for j, baseImage:getHeight() - 1 do
    --         print(baseImage:getPi)
    --     end
    -- end
    love.window.setFullscreen(true, 'desktop')
    frames = 2
    background = Background("img/ground.png", 0, 0, 1000, 740, 0, 1)
    for i, v in ipairs(scenary) do
        for j, d in ipairs(scenary[i]) do
            if(scenary[i][j] == 0) then 
                table.insert(jungle, Tree("img/teste.png", j * 16, i * 16, 250, 325, 0, 1))
                table.insert(jungle, Tree("img/teste.png", j * 16, i * 16, 250, 325, 0, 1))
            -- elseif(scenary[])
            end
        end
    end

    --Require--
  local _, _, flags = love.window.getMode()
  width, height = love.window.getDesktopDimensions(flags.display) -- flags.display contem o monitor que esta sendo usado.
  love.graphics.setDefaultFilter('nearest', 'nearest') -- Filtro para que o render não use blur e deixe um aspecto pixelado.

  Camera = require("src.Camera") -- Camera.
  push:setupScreen(width, height, width, height, {fullscreen = true}) -- GameScreen Settings.

  Zoom = 1
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