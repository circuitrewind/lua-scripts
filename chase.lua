length	= 100

x		= esp.random(0, length)
y		= esp.random(0, length)
z		= esp.random(0, length)

xdir	= esp.random((length/2),length) / length
ydir	= esp.random((length/2),length) / length
zdir	= esp.random((length/2),length) / length


led.write(1, 0, 0xffffff)

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

	for i=0,3 do
		led.multiply(i, 0xefefef)
		led.write(i, x, led.read(i, x) + 0xff0000)
		led.write(i, y, led.read(i, y) + 0x00ff00)
		led.write(i, z, led.read(i, z) + 0x0000ff)
	end
end
