Hero = class()

function Hero:init(x,y)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
end

function Hero:draw()
    -- Codea does not automatically call this method
    sprite("Platformer Art:Guy Standing",self.x,self.y,25)
end

function Hero:touched(touch)
    -- Codea does not automatically call this method
end
