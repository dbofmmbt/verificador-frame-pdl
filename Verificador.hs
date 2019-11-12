module Verficador
(
  verificaFramePDL
) where

import Arvore
import Grafo
import Data.List
import Data.Maybe

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
  | simbolo (esquerdo p) == "*" = not $ null $ filter (\valor -> valor) (map (verificaRec m (direito p)) iteracoes)
  | simbolo p == ";" = verificaRec m (esquerdo p) e && verificaRec m (direito p) (proximoEstado v p)
  | simbolo p == "U" = verificaRec m (esquerdo p) e || verificaRec m (direito p ) e
  -- | simbolo p == "*" = 
  | otherwise = error "Não implementado ainda"
  where
    v = m !! e
    iteracoes = takeWhile (/=(0-1)) (map (executaIteracao m (esquerdo $ esquerdo p) e) [0..])

proximoEstado :: Vertice -> PDL -> Estado
proximoEstado v p
  | ehFolha p = fst $ head $ filter (\aresta -> (snd aresta) == (simbolo p)) v
  | simbolo p == ";" = proximoEstado v (esquerdo p)
  | simbolo p == "U" = error "a função \"proximoEstado\" não deveria ser chamada para \"U\""
  | otherwise = error "caso nao tratado"

executaIteracao :: Modelo -> PDL -> Estado -> Int -> Estado
executaIteracao m p e i
  | i == 0 = e
  | verificaRec m p e = executaIteracao m p (proximoEstado v p) (i-1)
  | otherwise = -1
  where v = m !! e

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


-- alpha*; beta
-- verificaFramePDL [[(1, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"alpha\" Vazia Vazia) Vazia) (Arvore \"beta\" Vazia Vazia)")

-- alpha*;beta
-- verificaFramePDL [[(1, "alpha")], [(2, "beta")], []] (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"alpha\" Vazia Vazia) Vazia) (Arvore \"beta\" Vazia Vazia)")