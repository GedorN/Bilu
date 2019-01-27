Menu = Object:extend()

function Menu:new()
  self.m = {}
  table.insert(self.m, "Continue")
  table.insert(self.m, "Start")
  table.insert(self.m, "Quit")
  self.isPlaying = false
  self.option = 2
  self.gameStart = false
end

function Menu:draw()
  for i = 1, 3 do
    if self.gameStart == true then
      if i ~= 2 then
        if i == self.option then
          love.graphics.setColor(0, 1, 0, 1)
        end
        love.graphics.print(self.m[i], width / 2 - 50, 300 + 50 * i, 0, 4, 4)
        love.graphics.setColor(1, 1, 1, 1)
      end
    else
      if i ~= 1 then
        if i == self.option then
          love.graphics.setColor(0, 1, 0, 1)
        end
        love.graphics.print(self.m[i], width / 2 - 50, 300 + 100 * i, 0, 4, 4)
        love.graphics.setColor(1, 1, 1, 1)
      end
    end
  end
end
