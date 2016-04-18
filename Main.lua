--displayMode(FULLSCREEN)

function setup()
    --bullet table
    bTable = {}
    
    hero = Hero(WIDTH/2,HEIGHT/2)
    
    moveStick = Joystick("move")
    shootStick = Joystick("shoot")
    
    parameter.watch("moveStick.dx")
    parameter.watch("moveStick.dy")
    
end

function draw()
    background(40, 40, 50)

    if moveStick.visible == true then
        moveStick:draw()
    end
    if shootStick.visible == true then
        shootStick:draw()
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
    --moveStick:touched(touch)
    --shootStick:touched(touch)
    
    if touch.x < WIDTH/2 then
        moveStick:touched(touch)
        if touch.state == BEGAN then
            moveStick.visible = true
        elseif touch.state == ENDED then
            moveStick.visible = false
        end
    elseif touch.x > WIDTH/2 then
        shootStick:touched(touch)
        if touch.state == BEGAN then
            shootStick.visible = true
            --hero:startFiring()
        elseif touch.state == ENDED then
            shootStick.visible = false
            --hero:stopFiring()
        end
    end
    
end