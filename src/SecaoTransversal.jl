module SecaoTransversal

	using LinearAlgebra
        using OrderedCollections
	using YAML
        using Plots
	
        include("geometrias.jl")
	include("le_geometria.jl")
        include("processa_secao_transversal.jl")
        include("main.jl")

        export Calcula_Secao


end
