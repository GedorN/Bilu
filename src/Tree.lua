Tree = Entity:extend()

function Tree:new(imgPath, x, y, frameWidth, frameHeight, spaceBtweenFrames, numberOfFrames)
    Tree.super.new(self, imgPath, x, y, frameWidth, frameHeight, spaceBtweenFrames, numberOfFrames)
end

function Tree:update(dt)

end

function Tree:draw()
    love.graphics.rectangle("line", self.x, self.y, self.frameWidth * treeDrawScale, self.frameHeight * treeDrawScale)
    love.graphics.draw(self.sprite, self.x, self.y, 0, treeDrawScale, treeDrawScale)
end
