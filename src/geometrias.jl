

# Rotina para desenhar um retângulo
# Função shape: "desenha" a figura
retangulo(x,y,b,h) = Shape(x .+ [0,b,b,0], y .+ [0,0,h,h])

function Processa_retangulo(x0,y0,b,h)

   xc = x0 + b/2
   yc = y0 + h/2
   A = b*h
   Ix = b*h^3 / 12
   Iy = h*b^3 / 12
   Ixy = 0.0

   return xc, yc, A, Ix, Iy, Ixy
end

# Rotina para desenhar um triângulo
triangulo(x,y,b,h) = Shape([x, x+b, x+b/2, x],[y, y, y+h, y])

function Processa_triangulo(x0,y0,b,h)
   
   xc = x0 + b/2
   yc = y0 + h/3
   A = b*h/2
   Ix = (b*h^3) / 36
   Iy = (h*b^3) / 36
   Ixy = 0.0
   
   return xc, yc, A, Ix, Iy, Ixy
end


# Rotina para desenhar um triangulo com origem dos eixos no centroide de forma mais geral(fig3 apD Gere, p643)
triangulo2(x,y,h,b,a) = Shape([x, x+b, x+(b-a), x], [y, y, y+h, y])

function Processa_triangulo2(x0, y0, b, h, a)

   c = b - a

   # Obs: xc está invertido pois no livro a referencia é na direita (1/3 de b+c)
   xc = x0 + 2*(b + c)/3 
   yc = y0 + h/3
   A = (b*h)/2
   Ix = (b*h^3)/36
   Iy = ((b*h)/36)*(b^2 - b*c + c^2)
   Ixy = ((b*h^2)/72)*(b-2*c)

   return xc, yc, A, Ix, Iy, Ixy

end

# Rotina para desenhar um círculo 
# Para o circulo, x e y estão no centro. Para o retângulo e triângulo são os dos cantos
function circulo(x,y,r,ndiv=60) 
   θ = 0:360÷ndiv:360
   Shape(r*sind.(θ) .+ x, r*cosd.(θ) .+ y)
end
# X0 e Y0 são as coordenadas do centro
function Processa_circulo(x0,y0,r)

   xc = x0 
   yc = y0 
   A = pi*r^2
   Ix = (pi*r^4)/4
   Iy = (pi*r^4)/4
   Ixy = 0.0

   return xc, yc, A, Ix, Iy, Ixy
end

# Rotina para desenhar um trapézio
# A origem está no centroide da figura
trapezio(x, y, bm, b, h) = Shape([x - b/2, x + b/2, x + bm/2, x - bm/2], [y - h/2, y - h/2, y + h/2, y + h/2])
function Processa_trapezio(h,b,bm)
   
   xc = 0
   yc = 0
   A = (h*(bm+b))/2
   Ix = (h^2*(bm^2+4*bm*b+b^2))/(36*(bm+b))
   Iy = (h/48)*(bm^3+bm^2*b+bm*b^2+b^3)
   Ixy = (h^3/12)*(bm^2+b^2+bm*b)
   
   return xc, yc, A, Ix, Iy, Ixy
end

# Rotina para desenhar um semi círculo
function semi_circulo(x, y, r, ndiv=60)
   θ = 0:180÷ndiv:180
   Shape(r*sind.(θ) .+ x, r*cosd.(θ) .+ y)
end


function Processa_semi_circulo(r)
   xc = 0
   yc = (4*r)/(3*π)
   Ix = (1/8)*(π*r^4)
   Iy = Ix
   Ixy = 0
   A = (π*r^2)/2

   return xc, yc, Ix, Iy, Ixy, A
end
