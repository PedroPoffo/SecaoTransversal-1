module SecaoTransversal

	using LinearAlgebra
        using OrderedCollections
	using YAML
        using Plots
	
        # Definições básicas das geometrias
        include("geometrias/retangulo.jl")
        include("geometrias/triangulo.jl")
        include("geometrias/circulo.jl")

        # Lê o arquivo .yaml
	include("le_geometria.jl")

        # Verifica a consistência dos dados de entrada
        include("verifica_consistencia.jl")

        # Processamento principal da geometria
        include("processa_secao_transversal.jl")

        # Rotina principal
        include("main.jl")

        export Calcula_Secao


end
