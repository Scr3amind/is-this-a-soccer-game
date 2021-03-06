Player = Class {}

function Player:init(x, y, size, playerNo)
    self.velocity = 50000
    self.angularVelocity = 20
    self.size = size
    
    self.color = {255/255, 255/255, 255/255, 1}
    if playerNo == 1 then
        self.color = {0/255, 255/255, 255/255, 1}
    elseif playerNo == 2 then
        self.color = {255/255, 255/255, 0/255, 1}
    end

    self.box = world:newRectangleCollider(x, y, self.size, self.size * 4)
    self.box:setRestitution(0.5)
    self.box:applyAngularImpulse(5000)

    self.x = self.box:getX()
    self.y = self.box:getY()



end

function Player:controller(right, left, up, down, dt)
    if love.keyboard.isDown(right) then
        self.box:setLinearVelocity( self.velocity * dt, 0 )
        self.box:setAngularVelocity(self.angularVelocity)
    elseif love.keyboard.isDown(left) then
        self.box:setLinearVelocity( -self.velocity * dt, 0 )
        self.box:setAngularVelocity(-self.angularVelocity)
    elseif love.keyboard.isDown(up) then
        self.box:setLinearVelocity( 0, -self.velocity * dt )
    elseif love.keyboard.isDown(down) then
        self.box:setLinearVelocity( 0, self.velocity * dt)

    else 
        self.box:setLinearVelocity( 0, 0)

    end

end

function Player:render()
    love.graphics.setColor(self.color)
    love.graphics.polygon("fill", self.box.body:getWorldPoints(self.box.shape:getPoints()))
    love.graphics.setColor(255/255, 255/255 , 0/255, 1)
end