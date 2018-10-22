length	= led.length(0)

x		= esp.random(0, length)
y		= esp.random(0, length)
z		= esp.random(0, length)

xdir	= esp.random((length/2),length) / length
ydir	= esp.random((length/2),length) / length
zdir	= esp.random((length/2),length) / length


function frame()
	x = x + xdir
	y = y + ydir
	z = z + zdir

	if x >= length then
		x = length - 1
		xdir = esp.random(-length,-(length/2)) / length
	end

	if x <=0 then
		x = 0
		xdir = esp.random((length/2),length) / length
	end

	if y >= length then
		y = length - 1
		ydir = esp.random(-length,-(length/2)) / length
	end

	if y <=0 then
		y = 0
		ydir = esp.random((length/2),length) / length
	end

	if z >= length then
		z = length - 1
		zdir = esp.random(-length,-(length/2)) / length
	end

	if z <=0 then
		z = 0
		zdir = esp.random((length/2),length) / length
	end

	led.multiply(0, 0xefefef)
	led.write(0, x, color.add(led.read(0, x), 0xff0000))
	led.write(0, y, color.add(led.read(0, y), 0x00ff00))
	led.write(0, z, color.add(led.read(0, z), 0x0000ff))
end
