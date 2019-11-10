import System.IO
import Data.List.Split
import Arvore

main = do
  putStrLn "Lendo arquivo de entrada..."
  arq <- openFile "entrada.txt" ReadMode
  input <- hGetContents arq
  let linhas = lines input
  print $ length linhas
  hClose arq
