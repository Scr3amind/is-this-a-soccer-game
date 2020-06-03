-- CS50 Final Project --
-- Isaac Cruz Santos --

--Libraries
local moonshine = require 'moonshine'
local wf = require 'windfield'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

timer = 0

function love.load()

    -- Display Setup
    love.window.setTitle('Final Project')
    
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false,
    })

    -------------------------------------

    --Shaders
    effect = moonshine(moonshine.effects.glow)
    ---

    --Gravity
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 0)
  
    box = world:newRectangleCollider(400 - 50/2, 100, 50, 50)
    box:setRestitution(0.5)
    box:applyAngularImpulse(5000)


  
    circle = world:newCircleCollider(400 - 50/2, 100, 20)
    circle:setRestitution(0.8)
    circle:applyAngularImpulse(5000)

    upper = world:newRectangleCollider(0, 0, WINDOW_WIDTH, 50)
    ground = world:newRectangleCollider(0, WINDOW_HEIGHT - 50, WINDOW_WIDTH, 50)
    wall_left = world:newRectangleCollider(0, 0, 50, WINDOW_HEIGHT)
    wall_right = world:newRectangleCollider(WINDOW_WIDTH - 50, 0, 50, WINDOW_HEIGHT)
    ground:setType('static') -- Types can be 'static', 'dynamic' or 'kinematic'. Defaults to 'dynamic'
    wall_left:setType('static')
    wall_right:setType('static')
    upper:setType('static')
    -----

end


function love.update(dt)

    world:update(dt)
    if love.keyboard.isDown("right") then
        box:setLinearVelocity( 500, 0 )
        --box:applyForce(2000, 0)
    elseif love.keyboard.isDown("left") then
        box:setLinearVelocity( -500, 0 )
        --box:applyForce(-2000, 0)
    elseif love.keyboard.isDown("up") then
        box:setLinearVelocity( 0, -500 )
        --box:applyForce(0, -2000)
    elseif love.keyboard.isDown("down") then
        box:setLinearVelocity( 0, 500 )
        --box:applyForce(0, 2000)
    
    end
end


function love.draw()
    love.graphics.clear(0 / 255, 38 / 255, 59 / 255, 255 / 255)
    effect(function()
        love.graphics.setColor(0/255, 255/255, 255/255, 1)
        love.graphics.polygon("fill", box.body:getWorldPoints(box.shape:getPoints()))
        love.graphics.setColor(255/255, 255/255 , 0/255, 1)
        love.graphics.circle('fill',circle.body:getX(),circle.body:getY(),circle.shape:getRadius())
        love.graphics.setColor(255/255, 255/255 , 255/255, 1)
    end)
    --world:draw(20)
end