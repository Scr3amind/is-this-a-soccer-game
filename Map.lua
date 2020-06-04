Map = Class{}

function Map:init(width, height)
    upper = world:newRectangleCollider(0, 0, width, 50)
    ground = world:newRectangleCollider(0, height - 50, width, 50)
    wall_left = world:newRectangleCollider(0, 0, 50, height)
    wall_right = world:newRectangleCollider(width - 50, 0, 50, height)
    
    ground:setType('static') -- Types can be 'static', 'dynamic' or 'kinematic'. Defaults to 'dynamic'
    wall_left:setType('static')
    wall_right:setType('static')
    upper:setType('static')
end