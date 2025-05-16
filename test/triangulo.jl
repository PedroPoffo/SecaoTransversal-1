@testset "Triangulo" begin
    
    # Arquivo sem definição de base
    @test_throws Exception Calcula_Secao("arquivos_teste/triangulo/base.yaml",verbose=false,output=false)
    
    # Arquivo sem definição de altura
    @test_throws Exception Calcula_Secao("arquivos_teste/triangulo/altura.yaml",verbose=false,output=false)
    
    #
    # Roda um triângulo 1cm × 2cm  e com o ponto inicial definido em (1,2)m
    #
    saida = Calcula_Secao("arquivos_teste/triangulo/tri12.yaml",verbose=false,output=false)

    # Centroide
    @test saida[1] ≈ 1+0.5E-2
    @test saida[2] ≈ 2+2E-2/3

    # Area 
    @test saida[3] ≈ 1E-4

    # Momentos Iz, Iy e Izy
    @test saida[4] ≈ 1E-2*(2E-2)^3 / 36
    @test saida[5] ≈ 2E-2*(1E-2)^3 / 36
    @test isapprox(saida[6],0.0,atol=1E-12)
    
    # ângulo principal
    @test isapprox(saida[7],0,atol=1E-12)

    # Momentos de inércia no sistema principal
    @test saida[8] ≈ saida[4]
    @test saida[9] ≈ saida[5]

end