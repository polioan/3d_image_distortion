cos = math.cos
sin = math.sin
rad = math.rad
floor = math.floor
sqrt = math.sqrt

function rgb_sum(r, g, b)
  return r + g + b
end

function half_screen()
  return love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
end

function draw3dpoint(x, y, z, x_cam_cos, x_cam_sin, y_cam_cos, y_cam_sin)
  love.graphics.points((x_cam_cos * x) - (x_cam_sin * y),
    (y_cam_cos * ((x_cam_cos * y) + (x_cam_sin * x))) + (z * y_cam_sin))
end

function dist(x1, y1, x2, y2)
  return sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end
