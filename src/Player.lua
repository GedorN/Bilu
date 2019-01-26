Player = Character:extend()

function Player:new(imgPath, x, y, frameWidth, frameHeight, spaceBtweenFrames, numberOfFrames, initialHealth, speed, jumpForce)
    Player.super.new(self, imgPath, x, y, frameWidth, frameHeight, spaceBtweenFrames, numberOfFrames, initialHealth, speed, jumpForce)
    self.moveRate = 7
    -- self.x = self.x + self.originInX
    -- self.y = self.y + self.originInY
end

function Player:update(dt, frames)
    local xInitial = self.x
    local yInitial = self.y
    if love.keyboard.isDown("left") then
        self.orientation = -1
        self.x = self.x - (self.speed * dt)
        if(frames % self.moveRate) == 0 then
            Player.super.nextFrame(self)
        end
    elseif love.keyboard.isDown("right") then
        self.orientation = 1
        self.x = self.x + (self.speed * dt)
        if(frames % 7) == 0 then
            Player.super.nextFrame(self)
        end
    elseif (love.keyboard.isDown("up")) then
       -- AQUI FICARIA O PULO
        self.y = self.y - self.speed * dt
        if(frames % self.moveRate) == 0 then
            Player.super.nextFrame(self)
        end
    elseif (love.keyboard.isDown("down")) then
        self.y = self.y + self.speed * dt
        if(frames % self.moveRate) == 0 then
            Player.super.nextFrame(self)
        end
    elseif (love.keyboard.isDown("up") and love.keyboard.isDown("right")) then
        -- AQUI É O PULO PRA FRENTE
    elseif (love.keyboard.isDown("up") and love.keyboard.isDown("left")) then
        -- AQUI É O PULO PARA TRÁS
    end

    if(self.backgroundCollision(self) == true) then
        self.x = xInitial
        self.y = yInitial
    end


end

function Player:draw()
    Player.super.draw(self)
end


function Player:checkCollision(obj)
    local self_left = (self.x)
    local self_right = self.x + self.frameWidth
    local self_top = self.y
    local self_bottom = self.y + self.frameHeight
    
    local obj_left = obj.x
    local obj_right = obj.x + (obj.width * treeDrawScale)
    local obj_top = obj.y
    local obj_bottom = obj.y + (obj.height * treeDrawScale)
    
    print("self_right: ", self_right, "obj_left: ", obj_left)
    print("")
    print("")
    print("self_left: ", self_left, "obj_right: ", obj_right)
    if self_right > obj_left and
    self_left < obj_right and
    self_bottom > obj_top and
    self_top < obj_bottom then
        print("collision")
        return true
        --Increase enemy speed
    else
        return false
    end
end

function Player:backgroundCollision()
    local anyCollision = false
    for i, obj in ipairs(jungle) do
        local self_left = (self.x)
        local self_right = self.x + self.frameWidth
        local self_top = self.y
        local self_bottom = self.y + self.frameHeight
        
        local obj_left = obj.x
        local obj_right = obj.x + (obj.width * treeDrawScale)
        local obj_top = obj.y
        local obj_bottom = obj.y + (obj.height * treeDrawScale)
        
        print("self_right: ", self_right, "obj_left: ", obj_left)
        print("")
        print("")
        print("self_left: ", self_left, "obj_right: ", obj_right)
        if self_right > obj_left and
        self_left < obj_right and
        self_bottom > obj_top and
        self_top < obj_bottom then
          anyCollision = true
          break
        end
    end
    return anyCollision
end