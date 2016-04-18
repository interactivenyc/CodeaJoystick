Joystick=class()

function Joystick:init(type)
    self.type=type
    self.x=0
    self.y=0
    self.touchX=0
    self.touchY=0
    self.dx=0
    self.dy=0
    self.angle = 0;
    
    self.c=20
    self.visible = false
    
end

function Joystick:draw()
    stroke(255)
    strokeWidth(2)
    fill(255,255,255,100)
    ellipse(self.x,self.y,150)
    
    local direction=vec2(self.touchX-self.x,self.touchY-self.y)
    local direction=direction:normalize()
    
    self.dx=direction.x
    self.dy=direction.y 
    
    if self.type=="move" then
        --convert the vector to angle, and add snapping
        self.angle = math.atan2(self.dx, self.dy) -- radians
        self.angle = self.angle * 180/math.pi -- degrees
        self.angle = self.angle - (self.angle % 15) -- snap to 15 degree increments
        
        --convert the new angle back to a vec2
        self.angle = self.angle * math.pi/180 -- convert back to radians
        self.dx = math.sin(self.angle)
        self.dy = math.cos(self.angle)
        
        
    end

    if self.type=="shoot" then
        self.c=self.c+1
        if self.c>12 then
            table.insert(bTable,Bullet(hero.x,hero.y,self.dx,self.dy))
            self.c=0
        end
    end
end

function Joystick:touched(touch)
    self.touchX=touch.x
    self.touchY=touch.y
    
    if touch.state==BEGAN then
        self.x = touch.x
        self.y = touch.y
        self.dx=0
        self.dy=0
    end
    if touch.state==ENDED then
        self.x = touch.x
        self.y = touch.y
        self.dx=0
        self.dy=0
    end
end

function Joystick:log(msg)
    print("[js] "..msg)
end