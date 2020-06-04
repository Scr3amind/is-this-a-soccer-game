Ball = Class{}

function Ball:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size

    self.circle = world:newCircleCollider(self.x, self.y, self.size)
    self.circle:setRestitution(0.8)
    self.circle:applyAngularImpulse(5000)
end

function Ball:render()
    love.graphics.setColor(255/255, 255/255 , 0/255, 1)
    love.graphics.circle('fill',self.circle.body:getX(),self.circle.body:getY(),self.circle.shape:getRadius())
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)
end