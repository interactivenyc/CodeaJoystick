Bullet = class()

function Bullet:init(startX,startY,deltaX,deltaY)
    -- you can accept and set parameters here
    self.x = startX
    self.y = startY
    self.dx = deltaX
    self.dy = deltaY
    self.bulletSize = 5
end

function Bullet:draw()
    -- Codea does not automatically call this method
    self.x = self.x + self.dx
    self.y = self.y + self.dy
    ellipse(self.x,self.y,self.bulletSize)
end

function Bullet:touched(touch)
    -- Codea does not automatically call this method
end
