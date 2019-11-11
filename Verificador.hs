module Verficador
(
  verificaFramePDL
) where

import Arvore
import Grafo
import Data.List

type Modelo = Grafo
type PDL = Arvore
type Estado = Int

verificaFramePDL :: Modelo -> PDL -> Bool
verificaFramePDL m p = verificaRec m p primeiroEstado
  where primeiroEstado = 0

verificaRec :: Modelo -> PDL -> Estado -> Bool
verificaRec m p e
  | p == Vazia = True
  | ehFolha p = verticeTemPrograma v (simbolo p)
  | simbolo p == ";" = verificaRec m (esquerdo p) e && verificaRec m (direito p) (proximoEstado v p)
  | simbolo p == "U" = verificaRec m (esquerdo p) e || verificaRec m (direito p ) e
  | otherwise = error "Não implementado ainda"
  where v = m !! e

proximoEstado :: Vertice -> PDL -> Estado
proximoEstado v p
  | ehFolha p = fst $ head $ filter (\aresta -> (snd aresta) == (simbolo p)) v
  | simbolo p == ";" = proximoEstado v (esquerdo p)
  | simbolo p == "U" = error "a função \"proximoEstado\" não deveria ser chamada para \"U\""

-- testes (só copiar e colar no ghci):

-- alpha; beta
-- verificaFramePDL [[(0, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")

-- alpha U beta
-- verificaFramePDL [[(0, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")

-- (alpha; beta) U beta
-- verificaFramePDL [[(1, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)) (Arvore \"beta\" Vazia Vazia)")


-- alpha; beta U beta; alpha
-- verificaFramePDL [[(0, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)) (Arvore \";\" (Arvore \"beta\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia))")

-- alpha; alpha U beta; alpha
-- verificaFramePDL [[(0, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia)) (Arvore \";\" (Arvore \"beta\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia))")

-- alpha; alpha U alpha; beta
-- verificaFramePDL [[(0, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia)) (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia))")