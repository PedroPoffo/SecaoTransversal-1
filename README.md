# SecaoTransversal
Programa para calcular propriedades de área de seções transversais de vigas, formadas pela união de figuras geométricas simples.

A entrada de dados é realizada pela definição de figuras geométricas simples, que são combinadas para formarmos seções com geometria mais complexa.
Assume-se que as coordenadas são informadas no plano $XY$ com origem em $(0,0)$ e os resultados são informados em relação a origem deste sistema 
de coordenadas. Os momentos de inércia são informados no sistema centroidal $YZ$, em que $Z=-X$, como definido na disciplina de Mecânica dos Sólidos I.

Atualmente o programa reconhece os seguintes tipos: retângulos, triângulos e círculos. Cada um deles tem 
um conjunto de dados de entrada particular.

1. Retângulo: retangulo
  - $x_0$    : coordenada $x$ do canto inferior esquerdo 
  - $y_0$    : coordenada $y$ do canto inferior esquerdo
  - $base$   : base 
  - $altura$ : altura

2. Círculo: circulo
  - $x_0$: coordenada $x$ do centro
  - $y_0$: coordenada $y$ do centro
  - $r$  : raio

3. Triangulo com vértices em $(x_0,y_0)$, $(x_0+base,y_0$) e $(x_0+base/2,y_0+altura)$: triangulo
  - $x_0$     : coordenada $x$ do vértice inferior esquerdo
  - $y_0$     : coordenada $y$ do vértice inferior esquerdo
  - $base$    : base
  - $altura$  : altura


Um arquivo .txt e uma imagem são geradas no mesmo diretório do arquivo .yaml, com os resultados e com a imagem da seção (cada uma das suas partes em uma cor diferente) e os eixos centrais principais de inércia.


# Exemplos 

<details>

<summary> Seção em T </summary>


```bash

#
# Seção transversal em T - página 571 Hibbeler
#

#
# Para processar este arquivo, utilizar
#
# using SecaoTranversal
# Calcula_Secao(arquivo.yaml)
#

#
# Versão do arquivo de dados
#
versao: 1.0

#
# Título é opcional
#
titulo:  "T para verificação" 

#
# Data de criação também é opcional
#
data:  16/05/2025

#
# Uma seção transversal é definida pela união/subtração 
# de formas geométricas simples. solido=1 é para união 
# e solido=0 para subtração.
#

#
# A seção em T composta por dois retângulos - um horizontal e outro vertical
# O primeiro inicia em (0,10)cm e tem base=8cm e altura=3cm a partir deste ponto.
# O segundo inicia em (3,0)cm e tem base=2cm e altura=10cm a partir deste ponto.
#
#
# Os valores calculados para esta geometria são 
#
# Centroide em 0.04000000000000001,0.08545454545454546
# Momentos de inércias no sistema original Iz=6.455757575757577e-6 Iy=1.346666666666667e-6 Izy=-1.88079096131566e-37
# ângulo principal 0.0
# Momentos de inércia no sistema principal Iz=6.455757575757577e-6 e Iy=1.346666666666667e-6
#
secao:
  - tipo: retangulo
    nome: horizontal
    x0: 0.0
    y0: 10E-2
    base: 8E-2
    altura: 3E-2
    solido: 1
  - tipo: retangulo
    nome: vertical
    x0: 3E-2
    y0: 0
    base: 2E-2
    altura: 10E-2
    solido: 1
  

```



<p align="center">
  <img src="doc/secao_T.png" alt="Seção transversal em T" width="50%">
</p>

</details>



<details>

<summary> Seção em quadrada com furo circular </summary>


```bash

#
# Quadrado com um furo circular no meio 
#

versao: 1.0

# Título
titulo:  "Quadrado com furo circular no meio" 

# Data de criação 
data: 16/05/2025

# Dados da seção 
secao:
  - tipo: retangulo
    nome: cheio
    x0: 0.0
    y0: 0.0
    base: 1E-2
    altura: 1E-2
    solido: 1
  - tipo: circulo
    nome: furo
    x0: 5E-3
    y0: 5E-3
    raio: 3E-3
    solido: -1
    

```



<p align="center">
  <img src="doc/quadrado_furo_meio.png" alt="Seção transversal quadrada com um furo circular no meio " width="50%">
</p>

</details>



<details>

<summary> Seção em L </summary>


```bash
#
# Seção transversal em L
#

versao: 1.0

# Título
titulo:  "Seção em L" 

# Data de criação 
data:  16/05/2025

# Dados para a seção 
secao:
  - tipo: retangulo
    nome: horizontal
    x0: 0.0
    y0: 0.0
    base: 5E-2
    altura: 1E-2
    solido: 1
  - tipo: retangulo
    nome: vertical
    x0: 0.0
    y0: 1E-2
    base: 1E-2
    altura: 4E-2
    solido: 1
  

```


<p align="center">
  <img src="doc/secao_L.png" alt="Seção transversal em L" width="50%">
</p>

</details>



