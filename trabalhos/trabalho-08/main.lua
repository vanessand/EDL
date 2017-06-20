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
	
	gameOver = 0
	
	blocks = levelOne()
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
	
-- TRABALHO 8 --
-- Corotina: função gameBad()
-- Desenha um retângulo se movendo de forma retangular quando o jogador perde o jogo (ou seja, quando todas as bolas são removidas)
-- É criado dentro de um if na linha 205 
-- Desenhado a partir da linha 225
	
function gameBad()
	local me 
	local x = 500
	local y = 150
	local velx = 100
    local vely = 100
 
	me = {
        move = function (dx,dy)
            x = x + dx
            y = y + dy
		
				
            return x, y
        end,
        get = function ()
            return x, y
        end,
		
		 co = coroutine.create(function (dt)			
			
            while true do
                if(x < 500 and y < 100) then
                    me.move(velx*dt, 0)
                end
                if(x == 500 and y < 300) then
                    me.move(0, vely*dt)
                end
                if(x > 200 and y == 300) then
                    me.move(velx*dt*(-1), 0)
                end
                if(x == 200 and y > 100) then
                    me.move(0, vely*dt*(-1)) 
                end 
				
				if(x > 500) then
					x=500
				end
				if(x < 200) then
					x=200
				end
				if(y > 300) then
					y=300
				end
				if(y < 100) then
					y=100
				end

				dt = coroutine.yield()
            end
		end)
    }
    return me
end

	
 
function love.update (dt)

	if gameOver == 0 then 
  
	  for i,ball in ipairs(bolas) do
		  ball.x = ball.x + math.cos(ball.angle) * ball.speed * dt
		  ball.y = ball.y + math.sin(ball.angle) * ball.speed * dt 
	  end
	  
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
	 
	  
	  -- aumentar a velocidade gradativamente  
	  for i,ball in ipairs(bolas) do
		  if ball.speed < 700 then
			 ball.speed = ball.speed + 0.02
		  end
	  end
	  
	  --se bater no bloco
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
		coro = gameBad()
	  end
	  
	end
  
  if gameOver == 1 then
	if love.keyboard.isDown('r') then
		love.load()
	elseif love.keyboard.isDown('q') then
		love.event.quit()
	 end
	 coroutine.resume(coro.co, dt)
  end 
	
end
	


function love.draw ()
	
	if gameOver == 1 then
		love.graphics.printf("Game Over! Aperte R para reiniciar",(love.graphics.getWidth() / 2) - 250, 30, 500, "center")
		local x,y = coro.get()
		love.graphics.rectangle('fill', x, y, 50, 50)
	else 
	  for i,b in ipairs(blocks) do
		b:draw()
	  end
	  
		love.graphics.circle('fill', ball.x, ball.y, ball.r)
		love.graphics.rectangle('fill', player.x,player.y, player.w,player.h)
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
