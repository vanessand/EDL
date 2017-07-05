require 'block'

function love.load ()
	
	ball = { x=400, y=540, r=10 }
	
	ball.angle = - math.pi / 4
    ball.speed = 200
	
	bolas = {}
	
	table.insert(bolas,ball)

	player = { x=340, y=550, w=120, h=10 }
    player.speed = 450

    score = 0	
	count = 0
	cbola = 1
	cblock = 30
	
	blockMove = newBlockMove(500,150,100);
	
	dx = {500,200}
    dy = {300,100}
	
	xBarLimits = {500,200}
    yBarLimits = {300,100}
	
	gameOver = 0
	
	blocks = levelOne()
end

-- TRABALHO 8 --
-- Corotina: função newBlockMove()
-- Desenha um retângulo se movendo de forma retangular durante todo o jogo. Se a bola colide com a coroutine, ela muda de ângulo.
-- É criado no love.load()
-- Desenhado a partir da linha 263

function newBlockMove (x,y,vel)

    local direction =  {0,1};
    local me; 
    local dx = {500,200}
    local dy = {300,100}
    local height = 100
    local width = 20
	
    local setHorizontal = function(horizontal)
        if((horizontal and height > width) or (not horizontal and height < width)) then
                local tempH = height
                height =  width
                width = tempH
        end
    end
    me = {
        direction = direction
        , dx = dx
        , dy = dy
        , height = height
        , width = width
        , move = function(dt)
                x = x + dt*direction[1]*vel
                y = y + dt*direction[2]*vel
                counter = direction[1]
                if (x > dx[2]) then x = dx[2] end
                if (y > dy[2]) then y = dy[2] end
                if (x < dx[1]) then x = dx[1] end
                if (y < dy[1]) then y = dy[1] end
            end
        , get = function ()
                return x, y, height, width
        end
        , co = coroutine.create( function()
		
                    while true do
                        direction = {1,0}
                        setHorizontal(true)
                        coroutine.yield()

                        direction = {0,-1}
                        setHorizontal(false)
                        coroutine.yield()

                        direction = {-1,0}
                        setHorizontal(true)
                        coroutine.yield()

                        direction = {0,1}
                        setHorizontal(false)
                        coroutine.yield()
                    end
                end),
    }
    return me
end
	
--função de colisão
function collides(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

-- TRABALHO 8 --
-- Closure: função newBola()
-- Cria as novas bolas quando 5 blocos são quebrados
-- É chamada dentro de um if na linha 155


function newBola(x, y)
	
	local x1 = x - 10
    local y1 = y - 10
    return function()
        ball = {x = x1, y = y1, r=10, angle = - math.pi / 4, speed = 200}
        return ball
    end
end

 
function love.update (dt)

	if gameOver == 0 then 
  
		-- move a bola
		for i,ball in ipairs(bolas) do
		  ball.x = ball.x + math.cos(ball.angle) * ball.speed * dt
		  ball.y = ball.y + math.sin(ball.angle) * ball.speed * dt 
		end
		
		-- move a coroutine
		local bx, by = blockMove.get()
		if(bx == dx[1] and by == dy[2]) then
			coroutine.resume(blockMove.co)
		elseif(bx == dx[2] and by == dy[2]) then
			coroutine.resume(blockMove.co)
		elseif(bx == dx[1] and by == dy[1]) then
			coroutine.resume(blockMove.co)
		elseif(bx == dx[2] and by == dy[1]) then
			coroutine.resume(blockMove.co)
		end
		blockMove.move(dt) 
		
		
		-- entradas do teclado
		if love.keyboard.isDown('left') then
		player.x = player.x - player.speed * dt
		elseif love.keyboard.isDown('right') then
		player.x = player.x + player.speed * dt
		elseif love.keyboard.isDown('r') then
		love.load()
		elseif love.keyboard.isDown('q') then
		love.event.quit()
		end

		  -- limites da bola
		for i,ball in ipairs(bolas) do

			 if ball.x < 10 then
				ball.x = 10
				ball.angle = math.pi - ball.angle
				
			 elseif ball.x > 790 then
				ball.x = 790
				ball.angle = math.pi - ball.angle
			 end

			 if ball.y < 10 then
				ball.y = 10
				ball.angle = -ball.angle
				
			 elseif ball.y > love.graphics.getHeight() - 10 then
				ball.y = love.graphics.getHeight() - 10
				ball.angle = -ball.angle
				score = score-200
				-- remover a bola caso ela caia
				table.remove(bolas, i)
				cbola = cbola - 1
			  end
			end

			-- limites do jogador
			if player.x < 0 then
				player.x = 0
			elseif player.x > 680 then
				player.x = 680
			end

			-- caso tenha colisão com o player
			for i,ball in ipairs(bolas) do
				if collides(ball.x, ball.y, ball.r, ball.r, player.x, player.y, player.w, player.h) then
					ball.angle = -ball.angle
					score = score + 100
				end
			end
			
			-- caso colida com a coroutine
			for i,ball in ipairs(bolas) do
				local bx,by,bw,bh = blockMove.get()
				if collides(ball.x, ball.y, ball.r, ball.r, bx, by, bw, bh) then
					ball.angle = -ball.angle
				end
			end
			
			-- caso tenha colisão com o bloco
			for i,ball in ipairs(bolas) do 
			   for j,v in ipairs(blocks) do
					if collides(ball.x, ball.y, ball.r / 2, ball.r / 2, v.x, v.y, v.width, v.height) then
						ball.angle = -ball.angle
						table.remove(blocks, j)
						cblock = cblock - 1
						count = count + 1
						break
					end
				end
			end

			-- aumentar a velocidade gradativamente  
			for i,ball in ipairs(bolas) do
				if ball.speed < 700 then
					ball.speed = ball.speed + 0.02
				end
			end

			-- inserir uma nova bola caso 5 blocos tenham sido quebrados
			if count > 5  then
				closure = newBola(player.x, player.y)
				table.insert(bolas,closure())
				count = 0
				cbola = cbola + 1
			end 

			-- caso não existam mais bolas: game over
			if cbola == 0 then
				gameOver = 1
			end

		end

	if gameOver == 1 then
		if love.keyboard.isDown('r') then
			love.load()
		elseif love.keyboard.isDown('q') then
			love.event.quit()
		end
	end 
	
end
	


function love.draw ()
	
	if gameOver == 1 then
		love.graphics.printf("Game Over! Aperte R para reiniciar",(love.graphics.getWidth() / 2) - 250, 30, 500, "center")
	else 
		for i,b in ipairs(blocks) do
		b:draw()
	end
	  
		love.graphics.circle('fill', ball.x, ball.y, ball.r)
		love.graphics.rectangle('fill', player.x,player.y, player.w,player.h)
		local x,y = blockMove.get()
		love.graphics.rectangle('fill', x, y, 100, 20)
		
	end 
		love.graphics.printf("SCORE: ",700,580,800,"left")
		love.graphics.printf(score,750,580,800,"left")
		love.graphics.printf("QUIT: Q | RESTART: R",10,580,800,"left")
		love.graphics.setColor(255, 0, 255, 255)
		
		for index,v in ipairs(bolas) do 
			love.graphics.setColor(math.random(50, 255),math.random(50, 255),math.random(50, 255),255)
			love.graphics.circle('fill', v.x, v.y, v.r)  
			love.graphics.setColor(255,255,255,255)
		end
		
		if cblock <= 0 then
			love.graphics.printf("Parabéns!!! Você venceu!!",(love.graphics.getWidth() / 2) - 250, 30, 500, "center")

		end
		
		love.graphics.setColor(255,255,255,255)
	
end
