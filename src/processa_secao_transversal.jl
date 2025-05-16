
#
# Utiliza as entradas no vetor de dicionários <secao> e, dependendo da forma geométricas
# calcula as propriedades da seção composta
#

function Processa_Secao(n_secoes::Int64,secao::Vector{Dict{Any,Any}},nome_grafico="secao.png")

   
   #
   # Vamos iniciar montando uma tabela que tem 
   #
   # xc yc A Ix Iy Ixy s/v (solido (1) ou vazio (-1))
   #
   tabela = zeros(n_secoes,7)

   # Verifica quantas geometrias de cada tipo nós temos
   n_retangulos = 0
   n_triangulos = 0
   n_circulos = 0
   
   # Inicializa um plot
   p = plot()

   # Registramos as coordenadas máximas de todo o domínio
   x_max = 0.0
   y_max = 0.0

   #
   # Loop pelas entradas do dicionário, processando cada uma das formas 
   #
   contador = 1
   for dado in secao

      # Tipo de geometria
      tipo = dado["tipo"]

      # Nome da seção 
      nome = dado["nome"]

      # Coordenada x0
      x0 = dado["x0"] 

      # Coordenada y0
      y0 = dado["y0"]

      # Solido 
      s = dado["solido"]

      # Processa os tipos 
      if tipo=="retangulo"
       
         # base
         b = dado["base"] 

         # altura
         h = dado["altura"]
      
         # Calcula os valores locais para o retângulo
         xc, yc, A, Ix, Iy, Ixy = Processa_retangulo(x0,y0,b,h)

         # Incrementa o contador e guarda na tabela 
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
         
         # base
         b = dado["base"] 
         
         # altura
         h = dado["altura"]

         # Calcula os valores locais para o triângulo
         xc, yc, A, Ix, Iy, Ixy = Processa_triangulo(x0,y0,b,h)

         # Incrementa o contador e guarda na tabela
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

      elseif tipo=="circulo"

         # raio
         r = dado["raio"]

         # Calcula os valores locais para o círculo
         xc, yc, A, Ix, Iy, Ixy = Processa_circulo(x0,y0,r)

         # Incrementa o contador e guarda na tabela
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

   end # loop sobre o vetor de dicionários

   #
   #                                        Processamento de toda a seção transversal 
   #
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
   # Ix  = Iz
   # Ixy = -Izy
   Iz  = Ix
   Izy = -Ixy

   
   # Se o produto de inércia for nulo, não precisamos calcular a rotação do sistema 
   # de referência
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

   # Vamos gerar o gráfico da figura e também dos eixos centrais principais de inércia 

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