-- particle.lua
local Particle = {}

function Particle.new(x, y,dx)
    local self = {
        x = x or 0,
        y = y or 0,
        radius = 10,  -- Set a default radius (you can adjust this value)
        dx = dx or 0,
        dy = 0,
        gravity = .163,
        angle = 0,
        dragCoefficient = 0.01, -- Adjust as needed
        
    }

    function self.collisionCheck(circleTwo)
        if self ~= circleTwo then
            local distance = math.sqrt((self.x - circleTwo.x)^2 + (self.y - circleTwo.y)^2)
    
            if distance <= self.radius + circleTwo.radius and distance > 0 then
                local overlap = self.radius + circleTwo.radius - distance
    
                local nx = (self.x - circleTwo.x) / distance
                local ny = (self.y - circleTwo.y) / distance
    
                self.x = self.x + overlap * nx
                self.y = self.y + overlap * ny
                circleTwo.x = circleTwo.x - overlap * nx
                circleTwo.y = circleTwo.y - overlap * ny
    
                local rel_velocity_x = self.dx - circleTwo.dx
                local rel_velocity_y = self.dy - circleTwo.dy

                local impulse = (2.0 * (rel_velocity_x * nx + rel_velocity_y * ny)) / (self.radius + circleTwo.radius)

                self.dx = self.dx - impulse * circleTwo.radius * nx * .99
                self.dy = self.dy - impulse * circleTwo.radius * ny * .99
                circleTwo.dx = circleTwo.dx + impulse * self.radius * nx * .99
                circleTwo.dy = circleTwo.dy + impulse * self.radius * ny * .99
            end
        end
    end

    function self.updateVelocity()
        self.dy = self.dy + self.gravity
        -- self.dx = self.dx + self.ddx * 1
    end

    function self.updatePosition(a, b)
        self.y = self.y + self.dy
        self.x = self.x + self.dx
        if self.y >= 600-self.radius then
            self.dx = self.dx * .995
        end
        if self.y > 600-self.radius then
            self.y = 600-self.radius
            self.dy = self.dy * -.9
        end
        if self.y < 0+self.radius then
            self.y = 0+self.radius
            self.dy = self.dy * -1
        end
        if self.x > 800-self.radius then
            self.x = 800-self.radius
            self.dx = self.dx * -1
        end
        if self.x < 0+self.radius then
            self.x = 0+self.radius
            self.dx = self.dx * -1
        end
    end

    return self
end

return Particle
