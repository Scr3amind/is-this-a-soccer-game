Map = Class{}

function Map:init(width, height)
    upper = Block(0, 0, width, 50)
    ground = Block(0, height - 50, width, 50)
    wall_left_up = Block(0, 0, 50, height / 3)
    wall_left_down = Block(0, height * 2 / 3, 50, height / 3)
    wall_right_up = Block(width - 50, 0, 50, height / 3)
    wall_right_down = Block(width - 50, height * 2 / 3, 50, height / 3)
end

function Map:render()
    upper:render()
    ground:render()
    wall_left_up:render()
    wall_left_down:render()
    wall_right_up:render()
    wall_right_down:render()
end
