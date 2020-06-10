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
    self.texture = love.graphics.newImage('textures/shockwave.png')
    self.pSystem = love.graphics.newParticleSystem(self.texture, 20000)
    self.pSystem:setEmissionRate(1000)
    self.pSystem:setParticleLifetime(0.07, 0.14)
    self.pSystem:setEmissionArea('normal',3 , 3)
    self.pSystem:setSpeed(250, 500)
    self.pSystem:setDirection(0)
    self.pSystem:setColors( 139/255, 255/255, 255/255, 1.0,
                            130/255, 172/255, 255/255, 1.0,
                            143/255, 113/255, 255/255, 1.0)

    self.pSystem:setSizes(1.0, 0.8, 0.5)
end

function Ball:update(dt)
    --Calculate particles direction
    self.angx, self.angy = self.circle:getLinearVelocity()
    self.angle = math.atan2(self.angx, self.angy)
    self.pSystem:setDirection(-self.angle - (math.pi / 2))
    --- Particles ---

    self.pSystem:update(dt)

end

function Ball:render()
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)
    love.graphics.circle('fill',self.circle.body:getX(),self.circle.body:getY(),self.circle.shape:getRadius())
    --Particles--
    love.graphics.draw(self.pSystem, self.circle.body:getX(), self.circle.body:getY())
    love.graphics.setColor(255/255, 255/255 , 255/255, 1)
end