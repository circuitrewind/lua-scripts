led.clear()

fade		= 0
dot			= {}
dot.__index	= dot
dots		= {}

speed_min	= 10
speed_max	= 50



function dot:length()
	return led.length( self.strip )
end

function dot:width()
	return led.width( self.strip )
end

function dot:height()
	return led.height( self.strip )
end



function dot:random()
	local len
	len = self:length()
	return esp.random((len/2),len) / len
end



function dot:create()
	local item	= {}
	setmetatable(item, dot)

	item.strip	= 0

	item.x		= esp.random(1, item:width() - 2)
	item.y		= esp.random(1, item:height() - 2)
	item.xdir 	= esp.random(speed_min, speed_max) / 100
	item.ydir 	= esp.random(speed_min, speed_max) / 100

	item.color	= color.palette(#dots)

	dots[#dots+1] = item

	return item
end



function dot:update()
	self.x = self.x + self.xdir
	self.y = self.y + self.ydir

	if self.x >= self:width() then
		self.x		= self:width() - 1
		self.xdir	= esp.random(-speed_max, -speed_min) / 100
		self.rgb	= color.palette(esp.random(0, 0x0f))
	elseif self.x < 0 then
		self.x		= 0
		self.xdir	= esp.random(speed_min, speed_max) / 100
		self.rgb	= color.palette(esp.random(0, 0x0f))
	end

	if self.y >= self:height() then
		self.y		= self:height() - 1
		self.ydir	= esp.random(-speed_max, -speed_min) / 100
		self.rgb	= color.palette(esp.random(0, 0x0f))
	elseif self.y < 0 then
		self.y		= 0
		self.ydir	= esp.random(speed_min, speed_max) / 100
		self.rgb	= color.palette(esp.random(0, 0x0f))
	end
end



function dot:render()
	led.draw(
		self.strip,
		self.x,
		self.y,
		color.screen(
			led.read(self.strip, self.x, self.y),
			self.color
		)
	)
end



for i=0,5 do
	dot.create()
end



function frame()
	fade = fade + 1
	if fade >= 8 then
		led.fade(0)
		fade = 0
	end

	for idx, item in ipairs(dots) do
		item:update()
		item:render()
	end
end
