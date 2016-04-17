--displayMode(FULLSCREEN)

function setup()

    --joystick table
    jsTable = {}
    
    --bullet table
    bTable = {}
    
    hero = Hero(WIDTH/2,HEIGHT/2)
    
    parameter.watch("hero.x")
    parameter.watch("hero.y")
    
end

function draw()
    background(40, 40, 50)

    --draw all the joysticks
    for jsIndex,jsInstance in pairs(jsTable) do
        jsInstance:draw()
    end
    
    fill(255)
    
    --draw the bullets
    for bIndex,bInstance in pairs(bTable) do
        bInstance:draw()
        if bInstance.x<0 or bInstance.x>WIDTH or bInstance.y<0 or bInstance.y>HEIGHT then
            table.remove(bTable,bIndex)
        end
    end
    hero:draw()
    
end

function touched(touch)
    if touch.state==BEGAN then
        if touch.x<WIDTH/2 then
            for a,b in pairs(jsTable) do
                if b.type=="move" then
                    return  -- limit 1 move joystick
                end
            end
            --create move joysticks
            table.insert(jsTable,Joystick(touch.x,touch.y,touch.id,"move"))
        else
            for a,b in pairs(jsTable) do
                if b.type=="shoot" then
                    return  -- limit 1 move joystick
                end
            end
            --create shoot joysticks
            table.insert(jsTable,Joystick(touch.x,touch.y,touch.id,"shoot"))    -- allow multiple shoot
        end
    end
    
    --pass along the touch information to the joysticks
    for jsIndex,jsInstance in pairs(jsTable) do
        jsInstance:touched(touch)
    end
end