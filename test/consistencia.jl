@testset "Consistência" begin
    

    # Arquivo sem a definição de uma seção transversal
    @test_throws Exception Calcula_Secao("arquivos_teste/vazio.yaml")
    
    # Arquivo sem a definição de tipo
    @test_throws Exception Calcula_Secao("arquivos_teste/tipo.yaml")
    

end