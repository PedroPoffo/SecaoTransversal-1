@testset "Circulo" begin
    
    # Arquivo sem definição de raio
    @test_throws Exception Calcula_Secao("test/arquivos_teste/circulo/raio.yaml",verbose=false,output=false)
    
    #
    # Roda um círculo de raio 2cm  e com centro em (1,2)m
    #
    saida = Calcula_Secao("test/arquivos_teste/circulo/circ2.yaml",verbose=false,output=false)

    # Centroide
    @test saida[1] ≈ 1.0
    @test saida[2] ≈ 2.0

    # Area 
    @test saida[3] ≈ pi*(2E-2)^2

    # Momentos Iz, Iy e Izy
    @test saida[4] ≈ pi*(2E-2)^4 / 4
    @test saida[5] ≈ pi*(2E-2)^4 / 4
    @test saida[6] ≈ 0.0
    


end