@testset "Consistência" begin
    

    # Arquivo sem a definição de uma seção transversal
    @test_throws Exception Calcula_Secao("test/arquivos_teste/consistencia/vazio.yaml",verbose=false,output=false)
    
    # Arquivo sem a definição de tipo
    @test_throws Exception Calcula_Secao("test/arquivos_teste/consistencia/tipo.yaml",verbose=false,output=false)
    
    # Arquivo sem a definição de nome
    @test_throws Exception Calcula_Secao("test/arquivos_teste/consistencia/nome.yaml",verbose=false,output=false)

    # Arquivo sem a definição de coordenada x0
    @test_throws Exception Calcula_Secao("test/arquivos_teste/consistencia/x0.yaml",verbose=false,output=false)

    # Arquivo sem a definição de coordenada y0
    @test_throws Exception Calcula_Secao("test/arquivos_teste/consistencia/y0.yaml",verbose=false,output=false)
 
    # Arquivo sem a definição de solido
    @test_throws Exception Calcula_Secao("test/arquivos_teste/consistencia/solido.yaml",verbose=false,output=false)
 
end