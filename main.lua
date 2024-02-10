local Particle = require("particle")
local circles = {}  -- Table to store circles
local timer = 0  -- Variable to keep track of elapsed time
local ballToggle = false
function love.load()
    love.window.setMode(800, 600)
end
function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        -- Add a new circle to the table with the current mouse position and a specified radius
        local newCircle = Particle.new(x, y)  -- Set a radius for the new circle
        table.insert(circles, newCircle)
    end
end
function love.keypressed(key)
    if key == "c" then
        -- Clear the circles table when the 'c' key is pressed
        circles = {}
    end
    if key == "t" then
        ballToggle = not ballToggle
    end
end
function love.draw()
    love.graphics.setColor(1, 1, 1)

    for _, circle in ipairs(circles) do
        love.graphics.circle("fill", circle.x, circle.y, circle.radius)
    end
    love.graphics.print("Circles: " .. #circles, love.graphics.getWidth() - 100, 10)
end

function love.update(dt)
    -- Increment the timer by the time passed since the last frame
    timer = timer + dt
    
    -- Check if 1 second has passed
    if timer >= .1 then
        -- Perform your action here
        if ballToggle then
            local newCircle = Particle.new(10, 10,20)  -- Set a radius for the new circle
            table.insert(circles, newCircle)
        end
        -- Reset the timer
        timer = timer - .1
    end
    -- Update physics 60 times per second
    for _, circle in ipairs(circles) do
        -- Example physics update functions
        circle.updateVelocity()
        circle.updatePosition()
        for _, circleTwo in ipairs(circles) do
            -- Example physics update functions
            circle.collisionCheck(circleTwo)
        end
    end
end