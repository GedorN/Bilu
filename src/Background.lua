Background = Entity:extend()

function Background:new(imgPath, x, y, frameWidth, frameHeight, spaceBtweenFrames, numberOfFrames)
    Background.super.new(self, imgPath, x, y, frameWidth, frameHeight, spaceBtweenFrames, numberOfFrames)
end

function Background:update(dt)

end

function Background:draw()
    love.graphics.draw(self.sprite, self.x, self.y, 0, backgroundDrawScale, backgroundDrawScale)
end
