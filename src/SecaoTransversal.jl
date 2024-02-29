module SecaoTranversal

	using LinearAlgebra
        using OrderedCollections
	using YAML
        using Plots
	
        incude("geometrias.jl")
	include("le_geometria.jl")
        include("processa_secao_transversal.jl")
        include("main.jl")

        export Calcula_Secao


end
