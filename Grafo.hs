module Grafo (
  Grafo(..),
  destinosVertice,
  programasVertice,
  verticeTemPrograma,
  lerGrafo,
  Programa,
  Vertice
) where

type Destino = Int
type Programa = String
type Vertice = [(Destino, Programa)]
type Grafo = [Vertice]

destinosVertice :: Vertice -> [Destino]
destinosVertice v = map (\aresta -> fst aresta) v

programasVertice :: Vertice -> [Programa]
programasVertice v = map (\aresta -> snd aresta) v

verticeTemPrograma :: Vertice -> Programa -> Bool
verticeTemPrograma v p = p `elem` (programasVertice v)

lerGrafo :: String -> Grafo
lerGrafo s = read s :: Grafo