Hero = class()

function Hero:init(x,y)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
    self.imageIndex = 0
    self.imageName = ""
    self.timer = 0
    self.whichFoot = "a"
    self.whichFootChange = 12
    self.whichFootTimer = 0
    
    sprite()
    
end

function Hero:draw()
    self.timer = self.timer + 1
    
    -- make sure hero stays on screen
    local nextX = self.x+moveStick.vector[1]*3
    local nextY = self.y+moveStick.vector[2]*3
    if nextX > WIDTH then nextX = WIDTH end
    if nextX < 0 then nextX = 0 end
    if nextY > HEIGHT then nextY = HEIGHT end
    if nextY < 0 then nextY = 0 end
    
    if math.abs(moveStick.angle) >= 0 then
        self.x=nextX
        self.y=nextY
    end
    
    self.imageIndex = math.tointeger(moveStick.angle/15 + 12)
    
    if self.imageIndex then
        self.imageName = "Project:gyrobot"..self.imageIndex.."-"..self.whichFoot
    end
    
    sprite(self.imageName,self.x,self.y,200)
    
    self.whichFootTimer = self.whichFootTimer + 1
    if self.whichFootTimer > self.whichFootChange then
        self.whichFootTimer = 0
        if self.whichFoot == "a" then
            self.whichFoot = "b"
        elseif self.whichFoot == "b" then
            self.whichFoot = "a"
        end
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

