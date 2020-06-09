Ball = Class{}

function Ball:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size

    self.circle = world:newCircleCollider(self.x, self.y, self.size)
    self.circle:setRestitution(1.0)
    self.circle:applyAngularImpulse(5000)
    self.circle:setCollisionClass('Ball')

       --- Particles ---
    self.texture = love.graphics.newImage('textures/circle.png')
    self.pSystem = love.graphics.newParticleSystem(self.texture, 20000)
    self.pSystem:setEmissionRate(1000)
    self.pSystem:setParticleLifetime(0.1, 0.2)
    self.pSystem:setEmissionArea('normal',3 , 3)
    self.pSystem:setSpeed(250, 500)
    self.pSystem:setDirection(0)
    self.pSystem:setColors(1, 1, 1, 1,
                            178/255, 252/255, 255/255, 1.0,
                            143/255, 113/255, 255/255, 1.0)

    self.pSystem:setSizes(1.0, 0.8, 0.5)
end

function Ball:update(dt)
    self.angx, self.angy = self.circle:getLinearVelocity()
    self.angle = math.atan2(self.angx, self.angy)
    self.pSystem:setDirection(-self.angle - (3.1416 / 2))
    --- Particles ---

    self.pSystem:update(dt)

end

function Ball:render()
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)
    --Particles--
    love.graphics.draw(self.pSystem, self.circle.body:getX(), self.circle.body:getY())
    love.graphics.circle('fill',self.circle.body:getX(),self.circle.body:getY(),self.circle.shape:getRadius())
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)
end