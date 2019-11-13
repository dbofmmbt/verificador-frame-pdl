# verificador-frame-pdl
Trabalho da disciplina de Linguagens de Programação, lecionada em 2019.2 na UFF.

As estruturas utilizadas foram uma árvore binária para o programa PDL e uma lista de listas de tuplas para o grafo. As tuplas são aretas (destino, programa), enquanto que a lista de arestas da posição i da lista mais externa representa o Nó i do Grafo.

Assumimos que o primeiro nó do grafo é o estado inicial e o processamento do programa começa na raiz da árvore PDL.

A função `verificaFramePDL` é a base da verificação. Ela chama a `verificaRec`, que faz a parte recursiva principal, e monta a resposta final.

`verificaRec` recebe os dados do programa e para cada cenário possível retornará o estado de erro. No caso, o estado `-1` representa que não houve erro em estado algum.

- O programa deve ser inicializado a partir do ghci: ghci Verificador.hs
A partir daí, os módulos Arvore, Grafo e o próprio Verificador são compilados. 
- No console do 'Verificador', um caso teste é passado para a função verificaFramePDL (modelo, pdl), cujo retorno é "deu certo", caso o modelo seja aceito, "deu erro no estado [N]" caso contrário. Ex:

-- alpha U beta
-- verificaFramePDL [[(0, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")
Sendo m: [[(0, "alpha"), (1, "beta")], [(0, "beta")]] uma lista de nós com suas respectivas listas de arestas, e o programa uma árvore binária criada a partir de criaArvore, uma função do modulo Arvore.

	                 "U"
	                Ž    `
	             Ž         `
                          "alpha"     "beta"
                           Ž    `         Ž    `
	       Ž        `      null    null
	      null      null

-- verificaFramePDL chama a função recursiva verificaRec (modelo, pdl, estado_inicial), sendo o estado inicial sempre 0 e seu retorno um bool.
------ Enquanto não atingir a condição de parada, verticeTemPrograma procura no nó do modelo correspondente ao estado atual se existe o programa.
Ao encontrar um dos símbolos (;, *, U) na árvore, a função verificaRec é chamada recursivamente pros nós seguintes.

Casos:
(;) Chama a função verificaRec pro nó da esquerda a partir do estado atual e, a partir do seu retorno, executa pra direita com o próximo estado.
(U) A escolha do nó a ser verificado é não determinística, podendo verificaRec ser chamada recursivamente a esquerda OU a direita a partir do estado atual.
(*) 



*sequencia_com_iteração  = 

auxiliares:

proximoEstado
executaIteração
estadosDeIteraçao