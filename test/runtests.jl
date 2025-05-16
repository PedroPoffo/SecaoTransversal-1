using SecaoTransversal
using Test

# Testes de consistência na definição dos dados
include("consistencia.jl")

# Testes com retângulo
include("retangulo.jl")

# Testes com triangulo
include("triangulo.jl")

# Testes com circulo
include("circulo.jl")

# Composição (soma e subtração) 
include("composicao.jl")
