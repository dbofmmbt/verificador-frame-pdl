module Arvore
(
  Arvore(..),
  simbolo,
  esquerdo,
  direito,
  ehFolha,
  criaArvore
) where

data Arvore = Vazia | Arvore String Arvore Arvore deriving (Show, Read, Eq)

simbolo :: Arvore -> String
simbolo Vazia = ""
simbolo (Arvore simbolo _ _) = simbolo

esquerdo :: Arvore -> Arvore
esquerdo (Arvore _ esquerdo _) = esquerdo

direito :: Arvore -> Arvore
direito (Arvore _ _ direito) = direito

ehFolha :: Arvore -> Bool
ehFolha arvore = esquerdo arvore == Vazia && direito arvore == Vazia

criaArvore :: String -> Arvore
criaArvore "" = Vazia
criaArvore str = read str :: Arvore