esp.print('start')

length = 100

dot = {}
dot.__index = dot

dots = {}


function dot:random()
	return esp.random((length/2),length) / length
end


function dot:create()
	local item = {}
	setmetatable(item, dot)

	item.pixel = esp.random(length)
	item.speed = dot.random()
	item.color = color.palette(#dots)
	item.strip = esp.random(3)

	dots[#dots+1] = item
	return item
end


function dot:update()
	self.pixel = self.pixel + self.speed

	if self.pixel >= length then
		self.pixel = 0
		self.speed = self.random()
		self.strip = self.strip + 1
		if self.strip >= 4 then
			self.strip = 0
		end
	end
--[[
	if self.pixel <=0 then
		self.pixel = 0
		self.speed = self.random()
		self.strip = self.strip - 1
		if self.strip < 0 then
			self.strip = 3
		end
	end
--]]
end


function dot:render()
	led.write(
		self.strip,
		self.pixel,
		color.screen(
			led.read(self.strip, self.pixel),
			self.color
		)
	)
end


for i=0,15 do
	dot.create()
end


function frame()
	for i=0,3 do
		led.multiply(i, 0xefefef)
	end

	for idx, item in ipairs(dots) do
		item:update()
		item:render()
	end
end

esp.print('good')
