"""
  Calcula_Secao(arquivo sem terminação yaml)

"""
function Calcula_Secao(arquivo,output=true)

    # Testa para vermos se arquivo está OK
	isempty(arquivo) && trow("Calcula_Secao:: é necessário informar um arquivo .yaml com os dados da seção")

	# Se o usuário passou o arquivo com .yaml, desfazemos
	if contains(arquivo,".yaml")
		arquivo = arquivo[1:end-5]
	end

	# Le a geometria
	# Devolve o numero de seções e o dicionário com as informações
	n_secoes,secoes = Le_Geometria_YAML(arquivo*".yaml")

    # Verifica a consitência dos dados
	Verifica_consistencia(secoes)

	# Processa a seção
	xc, yc, area, Iz, Iy, Izy, α,  Izl, Iyl, tabela = Processa_Secao(n_secoes,secoes,output,arquivo*".png");

	# Se output for verdadeiro, gera um arquivo com os dados básicos
	if output
		fd = open(arquivo*".txt","w")
		println(fd,"Centroide em ")
		println(fd,"x $xc")
		println(fd,"y $yc")
		println(fd,"Área $area")
		println(fd,"Momentos de inércias no sistema original")
		println(fd,"Iz  $Iz")
		println(fd,"Iy  $Iy")
		println(fd,"Izy $Izy")
		println(fd,"Ângulo principal $α")
		println(fd,"Momentos de inércia no sistema principal")
		println(fd,"Iz' $Izl") 
		println(fd,"Iy' $Iyl")
		close(fd)
	end
end


