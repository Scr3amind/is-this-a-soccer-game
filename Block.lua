Block = Class{}

function Block:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.collider = world:newRectangleCollider(x, y, self.width, self.height)
    self.collider:setType('static')

end



function Block:render()
    love.graphics.setColor(130/255, 172/255, 255/255, 1.0)
    love.graphics.polygon("fill", self.collider.body:getWorldPoints(self.collider.shape:getPoints()))
    love.graphics.setColor(255/255, 255/255, 255/255, 1.0)
    love.graphics.polygon("line", self.collider.body:getWorldPoints(self.collider.shape:getPoints()))
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)
end