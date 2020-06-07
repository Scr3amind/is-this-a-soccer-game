-- CS50 Final Project --
-- Isaac Cruz Santos --

--Libraries
local moonshine = require 'moonshine'
local wf = require 'windfield'
Class = require 'hump/class'
Timer = require "hump.timer"
---Classes
require 'Player'
require 'Ball'
require 'Map'
require 'Block'
require 'UIHelper'

--Setup Constants
local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720


--Scoring
local WIN_SCORE = 5
local p1Score = 0
local p2Score = 0
local winner = 0

--GameState --
gameState = 'StartScreen'

--Timer--
local timer = 0


function love.load()

    -- Display Setup
    love.window.setTitle('Is this a soccer game?')
    
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
    world:addCollisionClass('Limit')
    world:addCollisionClass('Ball', {ignores = {'Limit'}})
    --Map

    map = Map(WINDOW_WIDTH, WINDOW_HEIGHT)
    
    -----Players
    p1 = Player(100, WINDOW_HEIGHT / 2 - 25, 50, 1)
    p2 = Player(WINDOW_WIDTH - 150, WINDOW_HEIGHT / 2 - 25 , 50, 2)
    ball = Ball(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 20)

    ---Font---
    gameFont = love.graphics.newFont('gameFont.ttf',48)
    scoreFont = love.graphics.newFont('gameFont.ttf',150)

    --UI--
    UIdrawer = UIHelper(WINDOW_WIDTH, WINDOW_HEIGHT)
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

function increaseScore(playerNumber, points)
    
    resetPositions()
    
    if playerNumber == 1 then
        p1Score = p1Score + points
    else
        p2Score = p2Score + points
    end

end

function finishGame(playerNumber)
    winner = playerNumber
    gameState = 'Finished'
    p1Score = 0
    p2Score = 0
end


function love.update(dt)

    --Timer--
    timer = timer + dt

    world:update(dt)
    --Players Input--
    if gameState == 'Playing' then
     p1:controller('d', 'a', 'w', 's', dt)
     p2:controller('right', 'left', 'up', 'down', dt)
    end
    --Map animation--
    map:update(timer, (p1Score + p2Score) / (WIN_SCORE - 1))


    --Scoring---
    if ball.circle:getX() >= WINDOW_WIDTH + 100 then
        increaseScore(1,1)
        
    elseif ball.circle:getX() <= 0 - 100 then
        increaseScore(2,1)
    end
    --Finishing
    if p1Score >= WIN_SCORE then
        finishGame(1)
    elseif p2Score >= WIN_SCORE then
        finishGame(2)
    end
    

end

function love.keypressed(key)
    --Press ESC to quit game
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'return' then
        gameState = 'Playing'
    end
    
end

function love.draw()
    love.graphics.clear(34 / 255, 40 / 255, 49 / 255, 255 / 255)
    
    glow(function()
        p1:render()
        ball:render()
        p2:render()
        if gameState == 'Playing' or gameState == 'Finished' then
            map:render()
        end
    end)
    
    --Font Drawing--
    if gameState == 'StartScreen' then
        UIdrawer:drawStartScreen(gameFont, timer)
    elseif gameState == 'Playing' then
        UIdrawer:drawScore(p1Score, p2Score, scoreFont)
    elseif gameState == 'Finished' then
        UIdrawer:drawWinScreen(winner, gameFont, timer)
    end
    
end