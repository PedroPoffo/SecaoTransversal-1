#
# Verifica a consistência dos dados no vetor de dicionários 
#
function Verifica_consistencia(secao::Vector{Dict{Any,Any}})

    # Figuras geométricas que estão definidas neste arquivo/programa
    validos = ["retangulo"; "triangulo"; "circulo"]

    for dado in secao

        # Pegamos a informação em tipo. Obrigatório
        haskey(dado,"tipo") || error("Tipo de geometria é obrigatório")
        tipo = dado["tipo"]
        
        # Verifica se temos um tipo de geometria válido 
        tipo in validos || error("A forma geométrica $tipo não é reconhecida pelo programa")
  
        # Nome da forma 
        haskey(dado,"nome") || error("Nome é um campo obrigatório para dado do tipo $tipo")
                
        # Coordenada x0
        haskey(dado,"x0") || error("x0 é um campo obrigatório para $nome")
        
        # Coordenada y0
        haskey(dado,"y0") || error("y0 é um campo obrigatório para $nome")
        
        # Sólido ou vazio
        haskey(dado,"solido") || error("solido é um campo obrigatório para $nome")
        s  = dado["solido"]
        (s==1.0 || s==-1) || error("Solido deve ser 1 ou -1 para $nome")
        
        # Aqui precisamos verificar se retângulos e/ou triângulos tem base e altura 
        # definidas
        if tipo == "retangulo" 
           haskey(dado,"base")    || throw("Figuras do tipo retangulo precisam de base")
           haskey(dado,"altura")  || throw("Figuras do tipo retangulo precisam de altura")
        end
  
         if tipo == "triangulo" 
            haskey(dado,"base")    || throw("Figuras do tipo triangulo precisam de base")
            haskey(dado,"altura")  || throw("Figuras do tipo triangulo precisam de altura")
         end
  
        # Verifica se é um círculo e se temos o raio definido
        if tipo == "circulo" 
          haskey(dado,"raio")  || throw("Figuras do tipo círculo precisam de raio")
        end
             
        # Retângulos e triângulos tem base e altura
        if haskey(dado,"base")
          b  = dado["base"]
          b > 0 || error("Valor da base deve ser positivo para $nome")
        end
  
        if haskey(dado,"altura")
          h = dado["altura"]
          h > 0 || throw("Valor da altura deve ser positivo para $nome")
        end
  
    end

end