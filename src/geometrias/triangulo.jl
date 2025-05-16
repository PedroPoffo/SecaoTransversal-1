#
#                       Triângulo 
#

#
# (x0,y0) coordenadas do vértice inferior esquerdo
# b,h     base a altura (direção x e direção y)
#
function Processa_triangulo(x0,y0,b,h)
   
   xc = x0 + b/2
   yc = y0 + h/3
   A = b*h/2
   Ix = (b*h^3) / 36
   Iy = (h*b^3) / 36
   Ixy = 0.0
   
   return xc, yc, A, Ix, Iy, Ixy
end


# Rotina para desenhar um triângulo
triangulo(x,y,b,h) = Shape([x, x+b, x+b/2, x],[y, y, y+h, y])
