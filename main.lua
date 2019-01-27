function camera_track(x, y)
    w = (width / 2) / Zoom
    h = (height / 2) / Zoom
    if x - w >= -2000 and x + w <= width + 2000 then
      camera:lockX(x, Camera.smooth.damped(dl))
    end
  
    if y - h >= -2000 and y + h <= height + 5000 then
      camera:lockY(y, Camera.smooth.damped(dl))
    end
end

function love.load()
    dl = 0.5
    Object = require("src.classic")
    push = require("src.push")
    require("src.Entity")
    require("src.Character")
    require("src.Player")
    require("src.Tree")
    require("src.Obj")
    require("src.Background")
    tick = require("src.tick")
    p = Player("img/player.png", 500, 270, 49, 85, 10, 5, 10, 200, 50)
    -- print(type(p))
    love.window.setFullscreen(true)
    baseImage = love.image.newImageData("img/labirinto.png")
    baseBackground = love.graphics.newImage(baseImage)
    print(type(baseImage))
    for i= 1, baseBackground:getWidth() - 1 do
        tb = {}
        for j=1, baseBackground:getHeight() - 1  do
             
            local r, g, b, a = baseImage:getPixel(j, i)
            if (r == 0 and g == 0 and b == 0) then
                table.insert(tb, 0)
            else
                table.insert(tb, 1)
            end

            -- -- baseImage:mapPixel
            -- if(love.graphics.getColor(baseImage:getPixel(i , j)) == #000000 then
            --     print("if")
            -- else
            --     print("else")
            -- end
        end
        table.insert(scenary, tb)

    end
    frames = 1
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
            p = Player("img/player.png", i * 30, j * 32, 49, 85, 10, 5, 10, 200, 50)
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
    frames = 1
    background = Background("img/ground.png", 0, 0, 1000, 740, 0, 1)
    for i, v in ipairs(scenary) do
        for j, d in ipairs(scenary[i]) do
            if(scenary[i][j] == 0) then 
                print("info: ", scenary[i][j])
                table.insert(jungle, Tree("img/teste.png", j * 32, i * 32, 250, 325, 0, 1))
                -- table.insert(jungle, Tree("img/teste.png", j * 1, i * 1, 250, 325, 0, 1))
            end
        end
    end

    --Require--
  local _, _, flags = love.window.getMode()
  width, height = love.window.getDesktopDimensions(flags.display) -- flags.display contem o monitor que esta sendo usado.
  love.graphics.setDefaultFilter('nearest', 'nearest') -- Filtro para que o render não use blur e deixe um aspecto pixelado.

  Camera = require("src.Camera") -- Camera.
  push:setupScreen(width, height, width, height, {fullscreen = true}) -- GameScreen Settings.

  Zoom = 1.5
  camera = Camera(5000, 5000, Zoom)
 camera:lookAt(5000, 5000, Camera.smooth.damped(1)) 
 tick.delay(function() dl = 5 end,7)
end


function love.update(dt)
    tick.update(dt)
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