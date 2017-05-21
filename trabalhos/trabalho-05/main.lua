function love.load ()

    ball = { x=400, y=540, r=10 }
    player = { x=340, y=550, w=120, h=10 }
	ball.angle = - math.pi / 4
	ball.speed = 200
	player.speed = 450
	score = 0
	
	-- TRABALHO 05  --
	-- Nome: r (raio da bola)
	-- Propriedade: valor
	-- Binding Time: compilação
	-- Explicação: O raio da bola (r) é atribuído em tempo de compilação 
	--		e não é alterado em toda execução do jogo pois se 
	-- 		trata de uma propriedade gráfica da bola.	

end
	
--função de colisão
function collides(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

	-- TRABALHO 05  --
	-- Nome: local
	-- Propriedade: semântica
	-- Binding Time: desing
	-- Explicação: Local é uma palavra reservada que serve para definir uma variável 
	--		como local, fazendo-a existir somente no escopo da função.

function love.update (dt)

	-- TRABALHO 05  --
	-- Nome: dt
	-- Propriedade: endereço
	-- Binding Time: execução
	-- Explicação: Como dt é uma variável local, seu endereço só pode ser definido em tempo de execução.

  ball.x = ball.x + math.cos(ball.angle) * ball.speed * dt
  ball.y = ball.y + math.sin(ball.angle) * ball.speed * dt 
  
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
   if ball.x < 10 then
	ball.x = 10
	ball.angle = math.pi - ball.angle
  elseif ball.x > 790 then
	ball.x = 790
	ball.angle = math.pi - ball.angle
  end
 
	-- TRABALHO 05  --
	-- Nome: math.pi
	-- Propriedade: semântica
	-- Binding Time: desing
	-- Explicação: Definida como uma palavra reservada, retorna o valor de pi da biblioteca Math.

  if ball.y < 10 then
	ball.y = 10
	ball.angle = -ball.angle
  elseif ball.y > love.graphics.getHeight() - 10 then
	ball.y = love.graphics.getHeight() - 10
	ball.angle = -ball.angle
  end
  
  -- limites do teclado
   if player.x < 0 then
	player.x = 0
  elseif player.x > 680 then
	player.x = 680
  end
  
  -- caso tenha colisão
  if collides(ball.x, ball.y, ball.r, ball.r, player.x, player.y, player.w, player.h) then
	ball.angle = -ball.angle
	score = score + 100
  end
  
	-- TRABALHO 05  --
	-- Nome: score
	-- Propriedade: valor
	-- Binding Time: execução
	-- Explicação: Score é uma variável que muda durante toda execução do jogo, 
	--		dependendo da atuação do jogador, aumenta e/ou diminui.
  
  -- perder ponto caso a bola caia
  if ball.y == 780 then
    score = score - 50
  end
  
  -- aumentar a velocidade gradativamente  
  if ball.speed < 700 then
     ball.speed = ball.speed + 0.02
  end
	
  	-- TRABALHO 05  --
	-- Nome: +
	-- Propriedade: semântica
	-- Binding Time: compilação
	-- Explicação: A adição é definida em tempo de compilação 
	--		de acordo com o tipo dos operandos.
	
end

function love.draw ()
    love.graphics.circle('fill', ball.x, ball.y, ball.r)
    love.graphics.rectangle('fill', player.x,player.y, player.w,player.h)
    love.graphics.printf("SCORE: ",700,580,800,"left")
    love.graphics.printf(score,750,580,800,"left")
    love.graphics.printf("QUIT: Q | RESTART: R",10,580,800,"left")
    love.graphics.setColor(255, 0, 255, 255)
end
