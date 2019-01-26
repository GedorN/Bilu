Obj = Entity:extend()

function Obj:new(imgPath, x, y, frameWidth, frameHeight, spaceBtweenFrames, numberOfFrames)
    Obj.super.new(self, imgPath, x, y, frameWidth, frameHeight, spaceBtweenFrames, numberOfFrames)
end

function Obj:update(dt)
end

function Obj:draw()
    Obj.super.draw(self)
end