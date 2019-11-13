module Verificador
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

verificaFramePDL :: Modelo -> PDL -> String
verificaFramePDL m p = if resposta == (-1) then "Deu certo" else "deu erro no estado " ++ (show resposta)
  where 
    primeiroEstado = 0
    resposta = verificaRec m p primeiroEstado

verificaRec :: Modelo -> PDL -> Estado -> Estado
verificaRec m p e
  | p == Vazia = -1
  | ehFolha p = if verticeTemPrograma v (simbolo p) then -1 else e
  | sequencia_com_iteracao = if not $ null $ filter (\valor -> valor == (-1)) (map (verificaRec m (direito p)) estadosIterSeq) then -1 else e
  | simbolo p == ";" = estadoSequencia (verificaRec m (esquerdo p) e) (verificaRec m (direito p) (proximoEstado v p))
  | simbolo p == "U" = estadoDecisao (verificaRec m (esquerdo p) e) (verificaRec m (direito p ) e) e
  | simbolo p == "*" = if (not $ null $ estadosIterPura) then -1 else e
  | otherwise = error "caso nao tratado"
  where
    v = m !! e
    estadosIterSeq = estadosDeIteracao m (esquerdo $ esquerdo p) e
    estadosIterPura = estadosDeIteracao m (esquerdo p) e
    sequencia_com_iteracao = simbolo p == ";" && simbolo (esquerdo p) == "*"

proximoEstado :: Vertice -> PDL -> Estado
proximoEstado v p
  | ehFolha p = fst $ head $ filter (\aresta -> (snd aresta) == (simbolo p)) v
  | simbolo p == ";" = proximoEstado v (esquerdo p)
  | simbolo p == "U" = error "a função \"proximoEstado\" não deveria ser chamada para \"U\""
  | otherwise = error "caso nao tratado"

executaIteracao :: Modelo -> PDL -> Estado -> Int -> Estado
executaIteracao m p e i
  | i == 0 = e
  | (verificaRec m p e) == (-1) = executaIteracao m p (proximoEstado v p) (i-1)
  | otherwise = -1
  where v = m !! e

estadosDeIteracao :: Modelo -> PDL -> Estado -> [Estado]
estadosDeIteracao m p e = takeWhile (/=(0-1)) (map (executaIteracao m p e) [0..])

estadoSequencia :: Estado -> Estado -> Estado
estadoSequencia e1 e2
  | e1 /= (-1) = e1
  | e2 /= (-1) = e2
  | otherwise = -1

estadoDecisao :: Estado -> Estado -> Estado -> Estado
estadoDecisao e1 e2 e_inicial
  | e1 == (-1) = -1
  | e2 == (-1) = -1
  | otherwise = e_inicial
