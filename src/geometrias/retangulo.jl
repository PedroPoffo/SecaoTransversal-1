#
#                       Retângulo
#

#
# (x0,y0) coordenadas do vértice inferior esquerdo
# b,h     base a altura (direção x e direção y)
#
function Processa_retangulo(x0,y0,b,h)

    xc = x0 + b/2
    yc = y0 + h/2
    A = b*h
    Ix = b*h^3 / 12
    Iy = h*b^3 / 12
    Ixy = 0.0
 
    return xc, yc, A, Ix, Iy, Ixy
 end
 

# Rotina para desenhar um retângulo
# Função shape: "desenha" a figura
retangulo(x,y,b,h) = Shape(x .+ [0,b,b,0], y .+ [0,0,h,h])


