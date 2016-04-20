Hero = class()

function Hero:init(x,y)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
    self.imageIndex = 0
    self.imageName = ""
    self.timer = 0
    
    sprite()
    
end

function Hero:draw()
    self.timer = self.timer + 1

    if math.abs(moveStick.vector[1]) > 0 then
        self.x=self.x+moveStick.vector[1]*2
        self.y=self.y+moveStick.vector[2]*2
    end
    
    self.imageIndex = math.tointeger(moveStick.angle/15 + 12)
    
    if self.imageIndex then
        if self.timer % 2 == 0 then
            self.imageName = "Project:gyrobot"..self.imageIndex.."-a"
        else
            self.imageName = "Project:gyrobot"..self.imageIndex.."-b"
        end
        
        sprite(self.imageName,self.x,self.y,100)
    end
    
end

function Hero:touched(touch)
    -- Codea does not automatically call this method
end

function Hero:log(msg)
    if msg then
        print("[Hero] "..msg)
    end
    
end
