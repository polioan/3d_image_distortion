require("func")

local x_cam = 0
local y_cam = 0

local x_cam_cos = cos(x_cam)
local x_cam_sin = sin(x_cam)
local y_cam_cos = cos(y_cam)
local y_cam_sin = sin(y_cam)

local img = love.image.newImageData("img.jpg")

local iter = 1

function love.load()
  love.graphics.setBackgroundColor(0, 0, 0)
  love.graphics.setPointSize(5)
end

function love.keypressed(key)
  if key == "escape" then
    love.window.minimize()
  elseif key == "end" or key == "delete" then
    love.event.quit()
  elseif key == "f11" then
    love.window.setFullscreen(not love.window.getFullscreen())
  elseif key == "f" then
    x_cam, y_cam = 0, 0
  end
end

function love.update(dt)
  if love.keyboard.isDown("space") then
    local half_screen_w, half_screen_h = half_screen()

    x_cam = (love.mouse.getX() - half_screen_w) / 100
    y_cam = (love.mouse.getY() - half_screen_h) / 100

    x_cam_cos = cos(x_cam)
    x_cam_sin = sin(x_cam)
    y_cam_cos = cos(y_cam)
    y_cam_sin = sin(y_cam)
  else
    if love.keyboard.isDown("right") then x_cam = x_cam + dt end
    if love.keyboard.isDown("left") then x_cam = x_cam - dt end
    if love.keyboard.isDown("up") then y_cam = y_cam + dt end
    if love.keyboard.isDown("down") then y_cam = y_cam - dt end

    x_cam_cos = cos(x_cam)
    x_cam_sin = sin(x_cam)
    y_cam_cos = cos(y_cam)
    y_cam_sin = sin(y_cam)
  end
end

function love.draw()
  collectgarbage()

  local half_screen_w, half_screen_h = half_screen()

  love.graphics.translate(half_screen_w, half_screen_h)

  local x_size = floor((img:getWidth() - 1) / 2)
  local y_size = floor((img:getHeight() - 1) / 2)
  local size = (x_size + y_size) / 2

  for x = -x_size, x_size, iter do
    for y = -y_size, y_size, iter do
      local r, g, b = img:getPixel(x + x_size, y + y_size)
      love.graphics.setColor(r, g, b)
      local layers = 10
      draw3dpoint(
        x,
        y,
        size / -2 + floor(rgb_sum(r, g, b) * layers) / layers * size,
        x_cam_cos, x_cam_sin, y_cam_cos, y_cam_sin)
    end
  end

  love.graphics.translate(-half_screen_w, -half_screen_h)

  love.graphics.setColor(1, 0, 1)
  love.graphics.circle("line", love.mouse.getX(), love.mouse.getY(), 10)

  love.graphics.print("fps: " .. tostring(love.timer.getFPS()), 20, 20)
  love.graphics.print("x cam: " .. tostring(x_cam), 20, 40)
  love.graphics.print("y cam: " .. tostring(y_cam), 20, 60)
  love.graphics.print("dots: " .. tostring(img:getWidth() * img:getHeight()), 20, 80)
end
