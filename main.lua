function love.load()
    Object = require("src.classic")
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
    
end


function love.update(dt)
    p:update(dt, frames)
    frames = (frames % 61) + 1
    -- p:checkCollision(t)
end

function love.draw()
    background:draw()
    for i, v in ipairs(jungle) do
        v:draw()
    end
    p:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end