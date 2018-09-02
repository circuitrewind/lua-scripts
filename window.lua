led.clear()

len = 100

dot = {}
dot.__index = dot

dots = {}


function dot:length()
	return led.length( self.strip )
end


function dot:random()
	local len
	len = self:length()
	return esp.random((len/2),len) / len
end


function dot:create()
	local item = {}
	setmetatable(item, dot)

	item.strip = esp.random(3)
	item.pixel = esp.random( item:length() )
	item.speed = item:random()
	item.color = color.palette(#dots)

	if esp.bit() then
		item.speed = -item.speed
	end

	dots[#dots+1] = item
	return item
end


function dot:newstrip(dir)
	self.strip = self.strip + dir
	if self.strip >= 4 then
		self.strip = 0
	elseif self.strip < 0 then
		self.strip = 3
	end

	if self.speed > 0 then
		self.speed = self:random()
		if self.strip == 0 or self.strip == 1 then
			self.pixel = 0
		else
			self.pixel = self:length() - 1
		end
	else
		self.speed = -self:random()
		if self.strip == 0 or self.strip == 1 then
			self.pixel = self:length() - 1
		else
			self.pixel = 0
		end
	end
end


function dot:update()
	if self.strip == 2 or self.strip == 3 then
		self.pixel = self.pixel - self.speed
	else
		self.pixel = self.pixel + self.speed
	end

	if self.speed > 0 then
		if self.pixel >= self:length() then
			self:newstrip(1)
		elseif self.pixel < 0 then
			self:newstrip(1)
		end
	else
		if self.pixel >= self:length() then
			self:newstrip(-1)
		elseif self.pixel < 0 then
			self:newstrip(-1)
		end
	end
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
