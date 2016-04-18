Hero = class()

function Hero:init(x,y)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
end

function Hero:draw()

    if math.abs(moveStick.dx) > 0 then
        self.x=self.x+moveStick.dx*3
        self.y=self.y+moveStick.dy*3
    end
    
    sprite("Platformer Art:Guy Standing",self.x,self.y,25)
end

function Hero:touched(touch)
    -- Codea does not automatically call this method
end
