# Verificador de Frames PDL

Trabalho da disciplina de Linguagens de Programação, lecionada em 2019.2 na UFF.

## *Overview* do Trabalho

A linguagem utilizada foi Haskell e a instalação foi feita a partir do site oficial.

As estruturas utilizadas foram uma árvore binária para o programa PDL e uma lista de listas de tuplas para o grafo. As tuplas são arestas (destino, programa), enquanto que a lista de arestas da posição i da lista mais externa representa o Nó i do Grafo.

Assumimos que o primeiro nó do grafo é o estado inicial e o processamento do programa começa na raiz da árvore PDL.

A função `verificaFramePDL` é a base da verificação. Ela chama a `verificaRec`, que faz a parte recursiva principal, e monta a resposta final.

`verificaRec` recebe os dados do programa e para cada cenário possível retornará o estado de erro. No caso, o estado `-1` representa que não houve erro em estado algum.

Para implementar a parte da iteração, foi feito o uso da "preguiça" de Haskell para iterar sobre todas as execuções possíveis do PDL sendo iterado e feito uma lista de estados, onde o valor da posição i representa o estado do programa após executar i vezes.

Essa lista de estados foi mapeada de forma a ter uma lista de todas as execuções possíveis. Se alguma execução fosse bem sucedida, a parte da iteração não causou problemas na verificação e podemos continuar verificando.

Naturalmente, o uso de funções parciais e recursão foi aplicado durante o trabalho tendo em vista o uso de Haskell para o desenvolvimento.

## Como executar

### Execução interativa

O programa deve ser inicializado a partir do ghci: `ghci Verificador.hs`. A partir daí, os módulos Arvore, Grafo e o próprio Verificador são compilados. 

No console do 'Verificador', um caso teste é passado para a função verificaFramePDL (modelo, pdl), cujo retorno é "deu certo", caso o modelo seja aceito, "deu erro no estado [N]" caso contrário. Ex:

### `alpha U beta`

`verificaFramePDL [[(0, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")`

Sendo o modelo: `[[(0, "alpha"), (1, "beta")], [(0, "beta")]]` uma lista de nós com suas respectivas listas de arestas, e o programa uma árvore binária criada a partir de criaArvore, uma função do modulo Arvore.

### Execução do `main.hs`

Para executar os casos de teste preparados previamente, basta rodar:

`runhaskell main.hs`

E todos os casos previamente definidos no `main.hs` irão rodar.

## Explicações dos Casos:

- `;` Chama a função `verificaRec` pro nó da esquerda a partir do estado atual e, a partir do seu retorno, executa pra direita com o próximo estado. Se algum deles der erro, retorna o primeiro que deu erro. Senão, retornar -1.

- `U` A escolha do nó a ser verificado é não determinística, podendo `verificaRec` ser chamada recursivamente a esquerda OU a direita a partir do estado atual. Logo, ambos os lados são executados e se algum deles der certo, retorna -1. Senão, retorna o estado atual, que deu errado.

- `*` Lista-se os estados em que se pode chegar através de todas as execuções possíveis de `*` (0, 1.. k vezes). Com essa lista, é possível checar se o resto do programa satisfaz a verificação para algum desses estados. Se sim, retorna -1. Se não, retorna o estado de `*`.

## Funções auxiliares

Aqui estão as funções utilizadas como apoio no modulo Verificador e seus significados.

- `proximoEstado`: indica qual o próximo estado com base no atual e no próximo programa a ser executado.

- `executaIteracao`: executa um mesmo PDL tantas vezes quanto for passado no parâmetro `Int`

- `estadosDeIteracao`: gera a lista de todos os estados possíveis de serem alcançados ao iterar sobre um PDL. Cada posição da lista retornada representa o estado alcançado nessa posição.

- `estadoSequencia`: indica qual estado deve ser retornado na `verificaRec` quando o simbolo é `;`

- `estadoDecisao`: indica qual estado deve ser retornado na `verificaRec` quando o simbolo é `U`