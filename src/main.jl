"""
  Calcula_Secao(arquivo sem terminação yaml)

"""
function Calcula_Secao(arquivo)

    # Testa para vermos se arquivo está OK
	isempty(arquivo) && trow("Calcula_Secao:: é necessário informar um arquivo .yaml com os dados da seção")

	# Se o usuário passou o arquivo com .yaml, desfazemos
	if contains(arquivo,".yaml")
		arquivo = arquivo[1:end-5]
	end

	# Le a geometria
	# Devolve o numero de seções e o dicionário com as informações
	n_secoes,secoes = Le_Geometria_YAML(arquivo*".yaml")

	# Processa a seação
	xc, yc, area, Iz, Iy, Izy, α,  Izl, Iyl, tabela = Processa_Secao(n_secoes,secoes,arquivo*".png");

	# Gera um arquivo com os dados básicos
	fd = open(arquivo*".txt","w")
	println(fd,"Centroide em $xc,$yc")
	println(fd,"Momentos de inércias no sistema original Iz=$Iz Iy=$Iy Izy=$Izy")
	println(fd,"ângulo principal $α")
	println(fd,"Momentos de inércia no sistema principal Iz=$Izl e Iy=$Iyl")
	close(fd)
end


