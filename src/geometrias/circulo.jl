#
#                       Círculo
#

#
# (x0,y0) coordenadas do centro
# r     raio
#
function Processa_circulo(x0,y0,r)
 
    xc = x0 
    yc = y0 
    A = pi*r^2
    Ix = (pi*r^4)/4
    Iy = (pi*r^4)/4
    Ixy = 0.0
 
    return xc, yc, A, Ix, Iy, Ixy
end
 

# Rotina para desenhar um círculo 
function circulo(x,y,r,ndiv=60) 
    θ = 0:360÷ndiv:360
    Shape(r*sind.(θ) .+ x, r*cosd.(θ) .+ y)
 end
