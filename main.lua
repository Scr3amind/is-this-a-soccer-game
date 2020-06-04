-- CS50 Final Project --
-- Isaac Cruz Santos --

--Libraries
local moonshine = require 'moonshine'
local wf = require 'windfield'
---Class
Class = require 'hump/class'
require 'Player'
require 'Ball'
--Setup Constants
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
  
    upper = world:newRectangleCollider(0, 0, WINDOW_WIDTH, 50)
    ground = world:newRectangleCollider(0, WINDOW_HEIGHT - 50, WINDOW_WIDTH, 50)
    wall_left = world:newRectangleCollider(0, 0, 50, WINDOW_HEIGHT)
    wall_right = world:newRectangleCollider(WINDOW_WIDTH - 50, 0, 50, WINDOW_HEIGHT)
    
    ground:setType('static') -- Types can be 'static', 'dynamic' or 'kinematic'. Defaults to 'dynamic'
    wall_left:setType('static')
    wall_right:setType('static')
    upper:setType('static')
    
    -----
    p1 = Player(100, WINDOW_HEIGHT / 2 - 25, 50)
    ball = Ball(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 20)
    
end


function love.update(dt)

    world:update(dt)
    p1:controller('d', 'a', 'w', 's', dt)
end


function love.draw()
    love.graphics.clear(34 / 255, 40 / 255, 49 / 255, 255 / 255)
    effect(function()
        p1:render()
        ball:render()
    end)
    world:draw(20)
end