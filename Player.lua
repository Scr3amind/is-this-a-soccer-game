Player = Class {}

function Player:init(x, y, size)
    self.x = x
    self.y = y
    self.velocity = 30000
    self.size = size
    

    self.box = world:newRectangleCollider(self.x, self.y, self.size, self.size)
    self.box:setRestitution(0.5)
    self.box:applyAngularImpulse(5000)



end

function Player:controller(right, left, up, down, dt)
    if love.keyboard.isDown(right) then
        self.box:setLinearVelocity( self.velocity * dt, 0 )
        --box:applyForce(2000, 0)
    elseif love.keyboard.isDown(left) then
        self.box:setLinearVelocity( -self.velocity * dt, 0 )
        --box:applyForce(-2000, 0)
    elseif love.keyboard.isDown(up) then
        self.box:setLinearVelocity( 0, -self.velocity * dt )
        --box:applyForce(0, -2000)
    elseif love.keyboard.isDown(down) then
        self.box:setLinearVelocity( 0, self.velocity * dt)
        --box:applyForce(0, 2000)
    end

end

function Player:render()
    love.graphics.setColor(0/255, 255/255, 255/255, 1)
    love.graphics.polygon("fill", self.box.body:getWorldPoints(self.box.shape:getPoints()))
    love.graphics.setColor(255/255, 255/255 , 0/255, 1)
end