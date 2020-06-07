Map = Class{}

function Map:init(width, height)
    
    self.offsetY = 0
    self.timer = 0
    self.blocks_width = 50
    
    -- Map Blocks
    self.upper = Block(0, 0, width, self.blocks_width)
    self.ground = Block(0, height - 50, width, self.blocks_width)
    
    self.wall_left_up = Block(0, 0 -  height * 2 / 3, self.blocks_width, height)
    self.wall_left_down = Block(0, height * 2 / 3, self.blocks_width, height)
    self.wall_right_up = Block(width - self.blocks_width, 0, self.blocks_width, height)
    self.wall_right_down = Block(width - self.blocks_width, height * 2 / 3, self.blocks_width, height)
    
    self.left_limit = Block(-50 , 0, 50, height)
    self.left_limit.collider:setCollisionClass('Limit')
    self.right_limit = Block(width , 0, 50, height)
    self.right_limit.collider:setCollisionClass('Limit')
    

    self.height1 = self.wall_left_up.collider:getY()
    self.height2 = self.wall_left_down.collider:getY()
end

function Map:update(timer,factor)
    self.offsetY = math.sin(timer*factor)
    self.wall_left_up.collider:setY(self.height1 + self.offsetY*150)
    self.wall_left_down.collider:setY(self.height2 + self.offsetY*150)
    self.wall_right_up.collider:setY(self.height1 + 1 - self.offsetY*150)
    self.wall_right_down.collider:setY(self.height2 + 1 - self.offsetY*150)
    
   
end

function Map:render()
    self.upper:render()
    self.ground:render()
    self.wall_left_up:render()
    self.wall_left_down:render()
    self.wall_right_up:render()
    self.wall_right_down:render()
end
