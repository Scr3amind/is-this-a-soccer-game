-- CS50 Final Project --
-- Isaac Cruz Santos --

--Libraries
local moonshine = require 'moonshine'
local wf = require 'windfield'
Class = require 'hump/class'
---Classes
require 'Player'
require 'Ball'
require 'Map'
require 'Block'

--Setup Constants
local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720




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
    glow = moonshine(moonshine.effects.glow)
    --------------------------------

    --Gravity & Physics
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 0)

    map = Map(WINDOW_WIDTH, WINDOW_HEIGHT)
    
    -----Players
    p1 = Player(100, WINDOW_HEIGHT / 2 - 25, 50, 1)
    p2 = Player(WINDOW_WIDTH - 150, WINDOW_HEIGHT / 2 - 25 , 50, 2)
    ball = Ball(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 20)
    
end


function love.update(dt)

    world:update(dt)
    p1:controller('d', 'a', 'w', 's', dt)
    p2:controller('right', 'left', 'up', 'down', dt)


end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    
end

function love.draw()
    love.graphics.clear(34 / 255, 40 / 255, 49 / 255, 255 / 255)
    
    glow(function()
        p1:render()
        ball:render()
        p2:render()
        map:render()
    end)

    
end