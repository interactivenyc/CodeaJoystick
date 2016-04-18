Joystick=class()

function Joystick:init(type)
    self.type=type
    self.x=0
    self.y=0
    self.touchX=0
    self.touchY=0
    self.dx=0
    self.dy=0
    
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
        if math.abs(direction.x) > 0 then
            hero.x=hero.x+direction.x*3
            hero.y=hero.y+direction.y*3
        end
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
end

function Joystick:log(msg)
    print("[js] "..msg)
end