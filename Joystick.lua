Joystick=class()

function Joystick:init(x,y,id,type)
    self.id=id
    self.type=type
    self.ox=x
    self.oy=y
    self.cx=x    
    self.cy=y
    self.dx=0
    self.dy=0

    self.c=20
    self.bSpeed = 20
end

function Joystick:draw()
    stroke(255)
    strokeWidth(2)
    fill(255,255,255,100)
    ellipse(self.ox,self.oy,150)
    if self.type=="move" then
        hero.x=hero.x+(self.cx-self.ox)/10
        hero.y=hero.y+(self.cy-self.oy)/10
    end
    if self.type=="shoot" then
        bDirection=vec2(self.cx-self.ox,self.cy-self.oy)
        bDirection=bDirection:normalize()
        if math.abs(bDirection.x+bDirection.y)>0 then
            self.dx=bDirection.x*self.bSpeed
            self.dy=bDirection.y*self.bSpeed
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
            if touch.state==MOVING then
                jsInstance.cx=touch.x
                jsInstance.cy=touch.y
            end
            if touch.state==ENDED then
                table.remove(jsTable,jsKey)
            end
        end
    end    
end