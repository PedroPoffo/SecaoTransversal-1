


function Processa_Secao(n_secoes,secao,nome_grafico="secao.png")

   # Vamos montar uma tabela que tem 
   #
   # xc yc A Ix Iy Ixy s/v (solido (1) ou vazio (-1))
   #
   tabela = zeros(n_secoes,7)

   # Verifica quantas geometrias de cada tipo nós temos
   n_retangulos = 0
   n_triangulos = 0
   n_circulos = 0
   n_trapezios = 0
   n_semi_circulo = 0

   # Inicializa um plot
   p = plot()

   # vamos obter as coordenadas máximas no domínio
   x_max = 0.0
   y_max = 0.0

   contador = 1
   for dado in secao

       # Pegamos a informação em tipo
       tipo = dado["tipo"]

       # Estes dados são comuns e obrigatórios
       haskey(dado,"nome") || throw("Nome é um campo obrigatório para dado")
       nome = dado["nome"]

       haskey(dado,"x0") || throw("x0 é um campo obrigatório para $nome")
       x0 = dado["x0"] 

       haskey(dado,"y0") || throw("y0 é um campo obrigatório para $nome")
       y0 = dado["y0"]

       haskey(dado,"solido") || throw("solido é um campo obrigatório para $nome")
       s  = dado["solido"]
       (s==1.0 || s==-1) || throw("Solido deve ser 1 ou -1 para $nome")
       
       # Retângulos e triângulos tem base e altura
       if haskey(dado,"base")
         b  = dado["base"]
         b > 0 || throw("Valor da base deve ser positivo para $nome")
       end

       if haskey(dado,"altura")
         h = dado["altura"]
         h > 0 || throw("Valor da altura deve ser positivo para $nome")
       end

       # Aqui precisamos verificar se retângulos e/ou triângulos tem base e altura 
       # definidas
       if tipo == "retangulo" 
          haskey(dado,"base")  || throw("Figuras do tipo retangulo precisam de base")
          haskey(dado,"altura")  || throw("Figuras do tipo retangulo precisam de altura")
       end

       if tipo == "triangulo" 
          haskey(dado,"base")  || throw("Figuras do tipo triangulo precisam de base")
          haskey(dado,"altura")  || throw("Figuras do tipo triangulo precisam de altura")
       end

       if tipo == "triangulo2" 
         haskey(dado,"base")  || throw("Figuras do tipo triangulo2 precisam de base")
         haskey(dado,"altura")  || throw("Figuras do tipo triangulo2 precisam de altura")
         haskey(dado,"a")  || throw("Figuras do tipo triangulo2 precisam dessa distancia")
      end


      if haskey(dado, "a")
         a = dado["a"]
      end

       # Círculos tem raio 
       if haskey(dado,"raio")
         r = dado["raio"]
       end

       # Verifica se é um círculo e se temos o raio definido
       if tipo == "circulo" 
         haskey(dado,"raio")  || throw("Figuras do tipo círculo precisam de raio")
       end

             # Definindo para o trapezio

      # Trapezios precisam de: uma base maior (b), uma base menor (bm) e uma altura (h)

      if haskey(dado,"basemaior")
         b  = dado["basemaior"]
         b > 0 || throw("Valor da base maior deve ser positivo para $nome")
       end

       if haskey(dado,"basemenor")
         bm  = dado["basemenor"]
         bm > 0 || throw("Valor da base menor deve ser positivo para $nome")
       end

      if tipo == "trapezio"
         haskey(dado, "basemaior") || throw("Figuras do tipo trapézio precisam da base maior")
         haskey(dado, "basemenor") || throw("Figuras do tipo trapézio precisam da base menor")
         haskey(dado, "altura") || throw("Figuras do tipo trapézio precisam da altura")
      end

       # Se for um trapézio
       if tipo =="trapezio"
         xc,yc, A, Ix, Iy, Ixy = Processa_trapezio(h,b,bm)
         n_trapezios += 1
         tabela[contador,:] = [xc yc A Ix Iy Ixy s]
         # Atualiza as coordenadas máximas
         x_max = max(x_max,x0+b)
         y_max = max(y_max,y0+h)
  
         # Adiciona ao plot
         if s==1
            # Se for um sólido
            # plot! -> adiciona o plot no que já existia
            plot!(p,trapezio(x0,y0,bm,b,h),label=nome)
         else
            # Se for um furo
            plot!(p,trapezio(x0,y0,bm,b,h),label=nome,fill=(0,:black))
         end

      # Definindo para um semi círculo

      # Precisamos do raio

      if haskey(dado,"raio")
         r = dado["raio"]
       end

      # Se for um semi círculo
      elseif tipo=="semi_circulo"
         xc,yc, Ix, Iy, Ixy, A = Processa_semi_circulo(r)
         n_semi_circulo += 1
         tabela[contador,:] = [xc yc A Ix Iy Ixy s]
         # Atualiza as coordenadas máximas
         x_max = max(x_max,x0+r)
         y_max = max(y_max,y0+r)
  
         # Adiciona ao plot
         if s==1
            # Se for um sólido
            # plot! -> adiciona o plot no que já existia
            plot!(p,semi_circulo(x0,y0,r),label=nome)
         else
            # Se for um furo
            plot!(p,semi_circulo(x0,y0,r),label=nome,fill=(0,:black))
         end



       # Se for retângulo
       elseif tipo=="retangulo"
          
         xc, yc, A, Ix, Iy, Ixy = Processa_retangulo(x0,y0,b,h)
         n_retangulos += 1
         tabela[contador,:] = [xc yc A Ix Iy Ixy s]

         # Atualiza as coordenadas máximas
         x_max = max(x_max,x0+b)
         y_max = max(y_max,y0+h)

         # Adiciona ao plot
         if s==1
            # Se for um sólido
            # plot! -> adiciona o plot no que já existia
            plot!(p,retangulo(x0,y0,b,h),label=nome)
         else
            # Se for um furo
            plot!(p,retangulo(x0,y0,b,h),label=nome,fill=(0,:black))
         end

       elseif tipo=="triangulo"

         xc, yc, A, Ix, Iy, Ixy = Processa_triangulo(x0,y0,b,h)
         n_triangulos += 1
         tabela[contador,:] = [xc yc A Ix Iy Ixy s]

         # Atualiza as coordenadas máximas
         x_max = max(x_max,x0+b)
         y_max = max(y_max,y0+h)

         # Adiciona ao plot
         if s==1
            plot!(p,triangulo(x0,y0,b,h),label=nome)
         else
           plot!(p,triangulo(x0,y0,b,h),label=nome,fill=(0,:black))
         end

      elseif tipo=="triangulo2"

         xc, yc, A, Ix, Iy, Ixy = Processa_triangulo2(x0,y0,b,h,a)
         n_triangulos += 1
         tabela[contador,:] = [xc yc A Ix Iy Ixy s]

         # Atualiza as coordenadas máximas
         x_max = max(x_max,x0+b)
         y_max = max(y_max,y0+h)

         # Adiciona ao plot
         if s==1
            plot!(p,triangulo2(x0,y0,b,h,a),label=nome)
         else
           plot!(p,triangulo2(x0,y0,b,h,a),label=nome,fill=(0,:black))
         end


      elseif tipo=="circulo"

         xc, yc, A, Ix, Iy, Ixy = Processa_circulo(x0,y0,r)
         n_circulos += 1
         tabela[contador,:] = [xc yc A Ix Iy Ixy s]

         # Atualiza as coordenadas máximas
         x_max = max(x_max,x0+r)
         y_max = max(y_max,y0+r)

         # Adiciona ao plot
         if s==1
            plot!(p,circulo(x0,y0,r),label=nome)
         else
           plot!(p,circulo(x0,y0,r),label=nome,fill=(0,:black))
         end

       else
           error("Tipo de geometria ", tipo, " não está definido")
       end

       # Incrementa o contador de linha da tabela
       contador += 1

   end

   # A área total da seação vai ser
   area = sum(tabela[:,3].*tabela[:,7])

   # Agora podemos calcular o centroide
   xc = sum(tabela[:,1].*tabela[:,3].*tabela[:,7])/area
   yc = sum(tabela[:,2].*tabela[:,3].*tabela[:,7])/area
   
   # Com isso podemos calcular o teorema dos eixos paralelos
   Ix  = sum( ( tabela[:,4].+tabela[:,3].*(yc.-tabela[:,2]).^2 ).*tabela[:,7] )
   Iy  = sum( ( tabela[:,5].+tabela[:,3].*(xc.-tabela[:,1]).^2 ).*tabela[:,7] )
   Ixy = sum( ( tabela[:,6].+tabela[:,3].*(xc.-tabela[:,1]).*(yc.-tabela[:,2])).*tabela[:,7] )
   
   # Como trabalhamos no sistema de coordenadas locais do elemento,
   # temos que trocar z por -x
   # como resultado, 
   # Ix = Iz
   # Ixy = -Izy
   Iz  = Ix
   Izy = -Ixy

   @show Izy
   # Se o produto de inércia for nulo, não precisamos calcuar o que 
   # tem para baixo
   if isapprox(Izy,0.0, atol=1E-12)
      α = 0.0
      Izl = Iz
      Iyl = Iy

   else

      # Podemos calcular o α da direção principal;
      # Evitamos divisão por zero
      if isapprox(Iz,Iy,atol=1E-12)
         α = sign(Izy)*45.0
      else
         α = 0.5*atand( 2*Izy/(Iz-Iy) )
      end

      # Com isso, temos os valores extremos dados por
      Im = (Iz + Iy) / 2
      R = sqrt( ((Iz-Iy)/2)^2 + Ixy^2 )
      Izl = Im + R
      Iyl = Im - R
   end

   # Uma medida para os eixos 
   r = min(x_max, y_max)

   # Com isso, podemos desenhar o sistema de referência rotacionado eixo_x
   plot!(p,[xc,xc-r*cosd(α)],[yc,yc-r*sind(α)],arrow=true,color=:black,label="z'")
   
   # eixo_y
   plot!(p,[xc,xc-r*sind(α)],[yc,yc+r*cosd(α)],arrow=true,color=:black,label="y'")
   
   # Garante que o gráfico fique em escala
   plot!(p,aspect_ratio=1.0)

   # Salva a imagem 
   savefig(nome_grafico)

   # Devolve os valores para o nosso controle
   return xc, yc, area, Iz, Iy, Izy, α,  Izl, Iyl, tabela
   
end