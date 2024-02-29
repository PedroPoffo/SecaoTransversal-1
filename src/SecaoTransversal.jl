module SecaoTranversal

	using LinearAlgebra
	using YAML
	
	include("le_geometria.jl")
        include("processa_secao_transversal.jl")
        include("main.jl")

        export Calcula_Secao


end
