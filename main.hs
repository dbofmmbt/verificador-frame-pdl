import System.IO
import Data.List
import Arvore
import Verificador

main = do
  
  putStrLn $ "alpha; beta"
  putStrLn $ verificaFramePDL [[(0, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")
  putStrLn $ "-----"
  putStrLn $ "alpha U beta"
  putStrLn $ verificaFramePDL [[(0, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")
  putStrLn $ "-----"
  putStrLn $ "(alpha; beta) U beta"
  putStrLn $ verificaFramePDL [[(1, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)) (Arvore \"beta\" Vazia Vazia)")
  putStrLn $ "-----"
  putStrLn $ "alpha; alpha U beta; alpha"
  putStrLn $ verificaFramePDL [[(0, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia)) (Arvore \";\" (Arvore \"beta\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia))")
  putStrLn $ "-----"
  putStrLn $ "alpha; alpha U alpha; beta"
  putStrLn $ verificaFramePDL [[(0, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia)) (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia))")
  putStrLn $ "-----"
  putStrLn $ "alpha*; beta"
  putStrLn $ verificaFramePDL [[(1, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"alpha\" Vazia Vazia) Vazia) (Arvore \"beta\" Vazia Vazia)")
  putStrLn $ "-----"
  putStrLn $ "alpha*;beta"
  putStrLn $ verificaFramePDL [[(1, "alpha")], [(2, "beta")], []] (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"alpha\" Vazia Vazia) Vazia) (Arvore \"beta\" Vazia Vazia)")
  putStrLn $ "-----"
  putStrLn $ "alpha*"
  putStrLn $ verificaFramePDL [[(1, "alpha")], [(2, "beta")], []] (criaArvore "Arvore \"*\" (Arvore \"alpha\" Vazia Vazia) Vazia")
  putStrLn $ "-----"
  putStrLn $ "a*a*b"
  putStrLn $ verificaFramePDL [[(1, "a")], [(2,"a")],[(3,"b")]] (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"a\" Vazia Vazia) Vazia) (Arvore \";\" (Arvore \"*\" (Arvore \"a\" Vazia Vazia) Vazia) (Arvore \"b\" Vazia Vazia))")
  putStrLn $ "-----"
  putStrLn $ "b*;a"
  putStrLn $ verificaFramePDL [[(1,"a"), (2, "b"), (3, "a")], [(1,"a")], [], []] (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"b\" Vazia Vazia) Vazia) (Arvore \"a\" Vazia Vazia)")
  putStrLn $ "\n"
--------------------------------------

  putStrLn $ "CASOS QUE DEVEM DAR ERRO:"

  putStrLn $ "\n"
  putStrLn $ "a*a*b"
  putStrLn $ verificaFramePDL [[(1, "a")], [],[(3,"b")]]  (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"a\" Vazia Vazia) Vazia) (Arvore \";\" (Arvore \"*\" (Arvore \"a\" Vazia Vazia) Vazia) (Arvore \"b\" Vazia Vazia))")
  putStrLn $ "-----"
  putStrLn $ "alpha; beta U beta; alpha"
  putStrLn $ verificaFramePDL [[(0, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)) (Arvore \";\" (Arvore \"beta\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia))")
  putStrLn $ "-----"
  putStrLn $ "a;b"
  putStrLn $ verificaFramePDL [[(1, "alpha")], [(2, "gama")], []] (criaArvore "Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")
  putStrLn $ "-----"
  putStrLn $ "a*b, mas com 2 vértices ao invés de 3 (como no anterior)"
  putStrLn $ verificaFramePDL [[(1, "alpha"), (2, "gama")], []] (criaArvore "Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")
  putStrLn $ "-----"
  putStrLn $ "a;b;g"
  putStrLn $ verificaFramePDL [ [(1, "a")], [(2, "b")], [(3, "beta")], []] (criaArvore "Arvore \";\" (Arvore \"a\" Vazia Vazia) (Arvore \";\" (Arvore \"b\" Vazia Vazia) (Arvore \"g\" Vazia Vazia))")
  putStrLn $ "-----"
  putStrLn $ "b;a"
  putStrLn $ verificaFramePDL [[(1,"a"), (2, "b"), (3, "a")], [(1,"a")], [], []] (criaArvore "Arvore \";\" (Arvore \"b\" Vazia Vazia) (Arvore \"a\" Vazia Vazia)")
  putStrLn $ "-----"
  