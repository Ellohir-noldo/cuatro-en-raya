function love.load()

	m = {}
	m.x = 0
	m.y = 0

	hover = {}
	hover.x = 0
	hover.y = 0
	
	down = {}
	down.x = -1
	down.y = -1
	
	size = {}
	size.x = 600
	size.y = 400
	tile = 100
	
	bkg = {200, 200, 255, 255}
	pl1 = {255, 20, 20, 255}
	pl2 = {20, 20, 255, 255}
	turn = true
	falling = false
	
	board= {}          -- create the matrix
	for i=0,size.x/tile do
		board[i] = {}     -- create a new row
		for j=0,size.y/tile do
			board[i][j] = bkg
		end
	end
	
	
end

function love.update(dt)

	-- get hover position
	hover.x = math.floor(love.mouse.getX() / tile)
	hover.y = math.floor(love.mouse.getY() / tile)

	if falling then
		-- make pieces fall
		falling = false
	end
	
	
end


function love.mousereleased(x, y, button)
	if button == "l" and not falling then
		if turn == true then
			board[hover.x][hover.y] = pl1
		else
			board[hover.x][hover.y] = pl2
		end
		turn = not turn
		falling = true
	end
end


function love.draw()

	-- draw the board
	for i = 0, (size.x/tile)-1 do
		for j = 0, (size.y/tile)-1 do
			love.graphics.setColor(bkg)
			love.graphics.rectangle('fill', i*tile, j*tile, tile, tile)
			love.graphics.setColor( board[i][j] )
			love.graphics.circle('fill',i*tile+tile/2, j*tile+tile/2, tile/2, 20)
			love.graphics.setColor(bkg)
			love.graphics.circle('fill',i*tile+tile/2, j*tile+tile/2, tile/2-tile/4, 20)
		end
	end

	-- draw the hover tile
	if turn then
		love.graphics.setColor(pl1)
	else 
		love.graphics.setColor(pl2)
	end
	love.graphics.circle('fill',hover.x*tile+tile/2, hover.y*tile+tile/2, tile/2, 20)
	love.graphics.setColor(bkg)
	love.graphics.circle('fill',hover.x*tile+tile/2, hover.y*tile+tile/2, tile/2-tile/4, 20)
	
	-- draw lines
	love.graphics.setColor( 20, 200, 20 )
	for i = 0, size.x/tile do
		love.graphics.line( i*tile, 0, i*tile, size.y)
	end
	for i = 0, size.y/tile do
		love.graphics.line( 0, i*tile, size.x, i*tile)
	end
	
end
