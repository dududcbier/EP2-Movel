------------------------------
-- Collisions
------------------------------

local Class = require 'libs.hump.class'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local Collisions = Class{}

function Collisions:init(ball, paddle, bricks, walls, score)
   self.ball = ball
   self.paddle = paddle
   self.bricks = bricks
   self.walls = walls
   self.score = score
end


function Collisions:treat(ball, paddle, bricks, walls, bonus)
   self.ball_paddle(self, ball, paddle)
   self.ball_bricks(self, ball, bricks, bonus)
   self.ball_walls(self, ball, walls)
   self.paddle_walls(self, paddle, walls)
   self.bonus_paddle(self, bonus, paddle)
end

----------------
--Check overlap
----------------
--To simplify, the ball is considered as a rectangle
function Collisions:check_rectangles_overlap(a, b)
   local overlap = false
   local shift_b_x, shift_b_y = 0, 0

   local rect1_left = a.x
   local rect1_right = a.x + a.width
   local rect1_top = a.y + a.height
   local rect1_bottom = a.y

   local rect2_left = b.x
   local rect2_right = b.x + b.width
   local rect2_top = b.y + b.height
   local rect2_bottom = b.y


   if (rect1_right > rect2_left and rect2_right > rect1_left  and
           rect1_top > rect2_bottom and rect2_top > rect1_bottom) then
      overlap = true
      
      if rect1_right < rect2_right then
	      shift_b_x = rect1_right - rect2_left
      else 
	      shift_b_x = rect1_left - rect2_right
      end

      if rect1_top < rect2_top then
	      shift_b_y = rect1_top - rect2_bottom
      else
	      shift_b_y = rect1_bottom - rect2_top
      end      
   end

   return overlap, shift_b_x, shift_b_y
end


------------------------------------------------
--Treats the four possible cases of collisions
------------------------------------------------
function Collisions:ball_paddle(ball, paddle)
   local overlap, horizontal_shift, vertical_shift
   local p = paddle:get_rect(paddle)
   local b = ball:get_info(ball)

   overlap, horizontal_shift, vertical_shift = self.check_rectangles_overlap(self, p, b)
   
   if overlap then
      ball:turn_back(horizontal_shift, vertical_shift)
      src1 = love.audio.newSource("music/mechanical-clonk.wav", "static")
      src1:play()
   end

end

function Collisions:ball_walls(ball, walls)

   local overlap, horizontal_shift, vertical_shift
   local b = ball:get_info(ball)

   for _, wall in pairs(walls.current_walls) do
      local w = wall:get_rect(wall)

      overlap, horizontal_shift, vertical_shift = self.check_rectangles_overlap(self, w, b)
      
      if overlap then
	      ball:turn_back(horizontal_shift, vertical_shift)
         src2 = love.audio.newSource("music/ball_walls_hit.wav", "static")
         src2:play()
      end
   end
end

function Collisions:ball_bricks(ball, bricks, bonus)

   local overlap, horizontal_shift, vertical_shift
   local b = ball:get_info(ball)
   
   for i, brick in pairs( bricks.current_bricks ) do   
      local br = brick:get_rect(brick)
      
      overlap, horizontal_shift, vertical_shift = self.check_rectangles_overlap(self, br, b)
      
      if overlap then
         if brick.btype == 2 then
            score:update(5)
         else
            score:update(1)
         end
	      ball:turn_back(horizontal_shift, vertical_shift)
	      bricks:hit_by_ball(i, brick, bonus)
      end
   end
end

function Collisions:paddle_walls(paddle, walls)

   local overlap, horizontal_shift, vertical_shift
   local p = paddle:get_rect(paddle)
   
   for _, wall in pairs(walls.current_walls) do
      
      local w = wall:get_rect(wall) 
      overlap, horizontal_shift, vertical_shift = self.check_rectangles_overlap(self, w, p)
      
      if overlap then
	      paddle:hit_wall(horizontal_shift)
      end
   end
end

function Collisions:bonus_paddle(bonus, paddle)
   local overlap, horizontal_shift, vertical_shift
   local b = bonus:get_info(bonus)
   local p = paddle:get_rect(paddle)

   overlap, horizontal_shift, vertical_shift = self.check_rectangles_overlap(self, p, b)

   if overlap then
      bonus:apply_effect(self.ball, self.paddle, bonus)
      bonus:remove(bonus)
   end

end


return Collisions