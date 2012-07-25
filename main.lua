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
	size.x = 700
	size.y = 500
	tile = 100
	
	bkg = {60, 60, 255, 255}
	pl1 = {255, 60, 60, 255}
	pl2 = {240, 240, 240, 255}
	turn = true
	falling = false
	fpiece = {}
	fpiece.x = -1
	fpiece.y = -1
	ftime = 0
	
	counter = 0
	winner = -1
	
	board= {}          -- create the matrix
	for i=0,size.x/tile do
		board[i] = {}     -- create a new row
		for j=0,size.y/tile do
			board[i][j] = -1
		end
	end
	
	
end

function love.update(dt)

	-- get hover position
	hover.x = math.floor(love.mouse.getX() / tile)
	hover.y = math.floor(love.mouse.getY() / tile)

	-- make pieces fall
	if falling then
		ftime = ftime + dt
		if ftime > 0.1 then
			if board[fpiece.x][fpiece.y+1] == -1 then
				board[fpiece.x][fpiece.y+1] = board[fpiece.x][fpiece.y]
				board[fpiece.x][fpiece.y] = -1
				fpiece.y = fpiece.y +1
			else
				ftime = 0
				falling = false
			end
		end
	end
	
	-- check for winners
	if not falling then
	
		-- horizontally
		for i = 0, size.x/tile do
			count = 0
			for j = 0, size.y/tile do
				if board[i][j] == -1 then break
				elseif board[i][j] == board[i+1][j] then
					counter = counter +1;
				end
				if counter >= 3 then
					winner = board[i][j]
					return
				end
			end
		end
		
		-- vertically
		for i = 0, size.x/tile do
			count = 0
			for j = 0, size.y/tile do
				if board[j][i] == -1 then break
				elseif board[j][i] == board[j][i+1] then
					counter = counter +1;
				end
				if counter >= 3 then
					winner = board[i][j]
					return
				end
			end
		end
		
		-- diagonal /
		
		-- diagonal \
		
	end
	
end


function love.mousereleased(x, y, button)
	if button == "l" and not falling and winner == -1 then
		if turn == true then
			board[hover.x][hover.y] = 1
		else
			board[hover.x][hover.y] = 2
		end
		turn = not turn
		fpiece.x = hover.x
		fpiece.y = hover.y
		falling = true
	end
end


function love.draw()

	-- draw the board
	love.graphics.setColor(bkg)
	love.graphics.rectangle('fill', 0, 0, size.x+tile, size.y+tile)
	
	-- draw lines
	love.graphics.setColor( 20, 200, 20 )
	for i = 0, (size.x/tile)+1 do
		love.graphics.line( i*tile, 0, i*tile, size.y+tile)
	end
	for i = 0, (size.y/tile)+1 do
		love.graphics.line( 0, i*tile, size.x+tile, i*tile)
	end
	
	-- draw pieces
	for i = 0, size.x/tile do
		for j = 0, size.y/tile do
			love.graphics.setColor(0,255,0);
			love.graphics.print("p"..i..j, i*tile+tile/2, j*tile+tile/2);
		
			if board[i][j] == 1 then
				love.graphics.setColor(pl1)
				love.graphics.circle('fill',i*tile+tile/2, j*tile+tile/2, tile/2, 20)
			elseif board[i][j] == 2 then
				love.graphics.setColor(pl2)
				love.graphics.circle('fill',i*tile+tile/2, j*tile+tile/2, tile/2, 20)
			end
		end
	end


	if winner ~= -1 then
		-- win message
		love.graphics.setColor(0,255,0);
		love.graphics.print("WINNER: PLAYER"..winner, 0, 0, 0, 3,3);
	else
		-- draw the hover
		if turn then
			love.graphics.setColor(pl1)
		else 
			love.graphics.setColor(pl2)
		end
		love.graphics.circle('fill',hover.x*tile+tile/2, hover.y*tile+tile/2, tile/3, 20)
	end
end
