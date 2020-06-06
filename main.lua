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

p1Score = 0
p2Score = 0



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

    ---Font---
    gameFont = love.graphics.newFont('gameFont.ttf',24)
    scoreFont = love.graphics.newFont('gameFont.ttf',150)
end

function resetPositions()
    ball.circle:setLinearVelocity( 0, 0 )
    ball.circle:setX(ball.x)
    ball.circle:setY(ball.y)
    p1.box:setX(p1.x)
    p1.box:setY(p1.y)
    p2.box:setX(p2.x)
    p2.box:setY(p2.y)
end


function love.update(dt)

    world:update(dt)
    p1:controller('d', 'a', 'w', 's', dt)
    p2:controller('right', 'left', 'up', 'down', dt)
    map:update(dt)


    --Scoring---
    if ball.circle:getX() >= WINDOW_WIDTH then
        resetPositions()
        p1Score = p1Score + 1
        
    elseif ball.circle:getX() <= 0 then
        resetPositions()
        p2Score = p2Score + 1
    end

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
    
    --Font Drawing--
    love.graphics.setFont(gameFont)
    love.graphics.printf("is this a soccer game?", 0 , WINDOW_HEIGHT / 4, WINDOW_WIDTH,  'center')
    love.graphics.setColor(255/255, 255/255 , 255/255, 1/4)
    love.graphics.setFont(scoreFont)
    love.graphics.printf(p1Score, WINDOW_WIDTH / 4, WINDOW_HEIGHT / 2 - 100, WINDOW_WIDTH / 2, 'left' )
    love.graphics.printf(p2Score, WINDOW_WIDTH / 4, WINDOW_HEIGHT / 2 - 100, WINDOW_WIDTH / 2, 'right' )
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)
 
    
end