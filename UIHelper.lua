UIHelper = Class{}

function UIHelper:init(width, height)
    self.width = width
    self.height = height
end

function UIHelper:drawScore(p1Score, p2Score, font)
    love.graphics.setColor(255/255, 255/255 , 255/255, 1/4)
    love.graphics.setFont(font)
    love.graphics.printf(p1Score, self.width / 4, self.height / 2 - 100, self.width / 2, 'left' )
    love.graphics.printf(p2Score, self.width / 4, self.height / 2 - 100, self.width / 2, 'right' )

    --Reset Color to white
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)
end

function UIHelper:drawStartScreen(font, timer)

    love.graphics.setFont(font)
    love.graphics.printf("is this a soccer game?", 0 , self.height / 4, self.width,  'center')
    blinkingAlpha = (math.sin(timer*3) + 1) / 2
    love.graphics.setColor(255/255, 255/255 , 255/255, blinkingAlpha)
    love.graphics.printf("Press Enter", 0 , self.height *  3/4, self.width,  'center')
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)

end

function UIHelper:drawWinScreen(player, font, timer)
    love.graphics.setFont(font)
    love.graphics.printf("Player " .. tostring(player) .. " Wins!", 0 , self.height / 4, self.width,  'center')
    blinkingAlpha = (math.sin(timer*3) + 1) / 2
    love.graphics.setColor(255/255, 255/255 , 255/255, blinkingAlpha)
    love.graphics.printf("Press Enter to Play Again", 0 , self.height *  3/4, self.width,  'center')
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)
end

