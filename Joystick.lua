Joystick=class()

function Joystick:init(x,y,id,type)
    self.id=id
    self.type=type
    self.x=x
    self.y=y
    self.touchX=x    
    self.touchY=y
    self.dx=0
    self.dy=0

    self.c=20
    
end

function Joystick:draw()
    stroke(255)
    strokeWidth(2)
    fill(255,255,255,100)
    ellipse(self.x,self.y,150)
    if self.type=="move" then
        hero.x=hero.x+(self.touchX-self.x)/10
        hero.y=hero.y+(self.touchY-self.y)/10
    end
    if self.type=="shoot" then
        local bDirection=vec2(self.touchX-self.x,self.touchY-self.y)
        local bDirection=bDirection:normalize()
        if math.abs(bDirection.x+bDirection.y)>0 then
            self.dx=bDirection.x
            self.dy=bDirection.y
            self.c=self.c+1
            if self.c>12 then
                table.insert(bTable,Bullet(hero.x,hero.y,self.dx,self.dy)) 
                self.c=0
            end  
        end        
    end
end

function Joystick:touched(touch)
    for jsKey,jsInstance in pairs(jsTable) do
        if touch.id==jsInstance.id then
            if touch.state==BEGAN then
                jsInstance.x = touch.x
                jsInstance.y = touch.y
                
            end
            if touch.state==MOVING then
                jsInstance.touchX=touch.x
                jsInstance.touchY=touch.y
            end
            if touch.state==ENDED then
                table.remove(jsTable,jsKey)
            end
        end
    end    
end

function Joystick:log(msg)
    print("[js] "..msg)
end