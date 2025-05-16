@testset "Composicao" begin
    
    #
    # Roda um quadrado 1cm × 1cm e um furo circular no centro, com raio 0.3cm
    #
    saida = Calcula_Secao("arquivos_teste/composicao/quadrado_furo.yaml",verbose=false,output=false)

    # Centroide
    @test saida[1] ≈ 1E-2 / 2
    @test saida[2] ≈ 1E-2 / 2

    # Area 
    @test saida[3] ≈ (1E-2)^2 - pi*(3E-3)^2

    # Momentos Iz, Iy e Izy
    @test saida[4] ≈ (1E-2)^4/12 - pi*(3E-3)^4/4
    @test saida[5] ≈ (1E-2)^4/12 - pi*(3E-3)^4/4
    @test isapprox(saida[6],0,atol=1E-12)

    # ângulo principal
    @test isapprox(saida[7],0,atol=1E-12)

    # Momentos de inércia no sistema principal
    @test saida[8] ≈ saida[4]
    @test saida[9] ≈ saida[5]


    #
    # Roda a seção em T
    #
    # Centroide em 0.04000000000000001,0.08545454545454546
    # Momentos de inércias no sistema original Iz=6.455757575757577e-6 Iy=1.346666666666667e-6 Izy=-1.88079096131566e-37
    # ângulo principal 0.0
    # Momentos de inércia no sistema principal Iz=6.455757575757577e-6 e Iy=1.346666666666667e-6

    saida = Calcula_Secao("arquivos_teste/composicao/T.yaml",verbose=false,output=false)

    # Centroide
    @test saida[1] ≈ 0.04
    @test saida[2] ≈ 0.08545454545454546

    # Area 
    @test saida[3] ≈ 0.0044

    # Momentos Iz, Iy e Izy
    @test saida[4] ≈ 6.455757575757577e-6
    @test saida[5] ≈ 1.346666666666667e-6
    @test isapprox(saida[6],0,atol=1E-12)

    # ângulo principal
    @test isapprox(saida[7],0,atol=1E-12)

    # Momentos de inércia no sistema principal
    @test saida[8] ≈ saida[4]
    @test saida[9] ≈ saida[5]
    

    #
    # Roda a seção em L
    #
    
    saida = Calcula_Secao("arquivos_teste/composicao/L.yaml",verbose=false,output=false)

    # Centroide
    @test saida[1] ≈ 0.01611111111111111
    @test saida[2] ≈ 0.01611111111111111

    # Area 
    @test saida[3] ≈ 0.0009

    # Momentos Iz, Iy e Izy
    @test saida[4] ≈ 1.9638888888888889e-7
    @test saida[5] ≈ 1.9638888888888889e-7
    @test saida[6] ≈ 1.1111111111111111e-7

    # ângulo principal
    @test saida[7] ≈ 45

    # Momentos de inércia no sistema principal
    @test saida[8] ≈ 3.075e-7
    @test saida[9] ≈ 8.52777777777778e-8



end