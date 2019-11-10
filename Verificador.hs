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
  | otherwise = error "Não implementado ainda"
  where v = m !! e

proximoEstado :: Vertice -> PDL -> Estado
proximoEstado v p
  | ehFolha p = fst $ head $ filter (\aresta -> (snd aresta) == (simbolo p)) v
  | simbolo p == ";" = proximoEstado v (esquerdo p)

-- testes (só copiar e colar no ghci):

-- verificaFramePDL [[(0, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")