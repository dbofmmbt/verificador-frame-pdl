import System.IO
import Data.List.Split
import Arvore
import Verificador

main = do
  putStrLn $ verificaFramePDL [[(1, "alpha")], [(2, "beta")], []] (criaArvore "Arvore \"*\" (Arvore \"alpha\" Vazia Vazia) Vazia")
