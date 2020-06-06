Map = Class{}

function Map:init(width, height)
    
    self.width = width
    self.height = height
    self.offsetY = 0
    self.timer = 0
    
    upper = Block(0, 0, width, 50)
    ground = Block(0, height - 50, width, 50)
    
    wall_left_up = Block(0, 0 -  height * 2 / 3, 50, height)
    wall_left_down = Block(0, height * 2 / 3, 50, height)
    wall_right_up = Block(width - 50, 0, 50, height)
    wall_right_down = Block(width - 50, height * 2 / 3, 50, height)
    
    left_limit = Block(-80 , height / 3, 50, height / 3)
    right_limit = Block(width + 30 , height / 3, 50, height / 3)
    
    self.height1 = wall_left_up.collider:getY()
    self.height2 = wall_left_down.collider:getY()
end

function Map:update(dt)
    self.timer = self.timer + dt
    self.offsetY = math.sin(self.timer)
    wall_left_up.collider:setY(self.height1 + self.offsetY*150)
    wall_left_down.collider:setY(self.height2 + self.offsetY*150)
    wall_right_up.collider:setY(self.height1 + 1 - self.offsetY*150)
    wall_right_down.collider:setY(self.height2 + 1 - self.offsetY*150)
    
   
end

function Map:render()
    upper:render()
    ground:render()
    wall_left_up:render()
    wall_left_down:render()
    wall_right_up:render()
    wall_right_down:render()
end
