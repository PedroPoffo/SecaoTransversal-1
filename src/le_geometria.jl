using OrderedCollections
using YAML

#
# Le um arquivo de dados de geometria em YAML. O processamento é bem simples,
# em que apenas lemos os dados e devolvemos um vetor de dicionários  <secao>
#
function Le_Geometria_YAML(arquivo,ver=1.0;verbose=true)

   # Primeiro lemos o arquivo de dados
   dados = YAML.load_file(arquivo)

   # Verifica se temos informação sobre a versão do arquivo de dados
   versao = 0.0
   if haskey(dados,"versao")
      versao = dados["versao"]

      # Verifica se a versão é compatível
      versao==ver || error("Le_Geometris_YAML::versão do arquivo não é compatível com a versão atual") 
        
   end

   # Vamos ver se o título e/ou a data estão definidos
   titulo = ""
   if haskey(dados,"titulo")
      titulo = dados["titulo"]
   end

   data = ""
   if haskey(dados,"data")
      data = dados["data"]
   end

   # Se for o caso, mostra os dados na tela
   if verbose
      println("Lendo    ",arquivo)
      println("Versão:  ", versao)
      println("Título:  ", titulo)
      println("Data:    ", data)
   end


   # Le o vetor de dicionários com a geometria da seção
   haskey(dados, "secao") || error("Arquivo não contém as informações sobre a seção.")
   secao = dados["secao"]

   # Número de informações no arquivo
   n_secoes = length(secao)

   if verbose 
      println("Seção tem ",n_secoes, " partes")
   end

   # Retorna o número de entidades geométricas
   # e o dicionário de entidades
   return n_secoes, secao

end 

