import System.IO
import Data.List
import Arvore
import Verificador

main = do
  
  putStrLn $ "alpha; beta"
  putStrLn $ verificaFramePDL [[(0, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")
  putStrLn $ "alpha U beta"
  putStrLn $ verificaFramePDL [[(0, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)")

  putStrLn $ "(alpha; beta) U beta"
  putStrLn $ verificaFramePDL [[(1, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)) (Arvore \"beta\" Vazia Vazia)")

  putStrLn $ "alpha; beta U beta; alpha"
  putStrLn $ verificaFramePDL [[(0, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia)) (Arvore \";\" (Arvore \"beta\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia))")

  putStrLn $ "alpha; alpha U beta; alpha"
  putStrLn $ verificaFramePDL [[(0, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia)) (Arvore \";\" (Arvore \"beta\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia))")

  putStrLn $ "alpha; alpha U alpha; beta"
  putStrLn $ verificaFramePDL [[(0, "alpha")], [(0, "beta")]] (criaArvore "Arvore \"U\" (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"alpha\" Vazia Vazia)) (Arvore \";\" (Arvore \"alpha\" Vazia Vazia) (Arvore \"beta\" Vazia Vazia))")

  putStrLn $ "alpha*; beta"
  putStrLn $ verificaFramePDL [[(1, "alpha"), (1, "beta")], [(0, "beta")]] (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"alpha\" Vazia Vazia) Vazia) (Arvore \"beta\" Vazia Vazia)")

  putStrLn $ "alpha*;beta"
  putStrLn $ verificaFramePDL [[(1, "alpha")], [(2, "beta")], []] (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"alpha\" Vazia Vazia) Vazia) (Arvore \"beta\" Vazia Vazia)")

  putStrLn $ "alpha*"
  putStrLn $ verificaFramePDL [[(1, "alpha")], [(2, "beta")], []] (criaArvore "Arvore \"*\" (Arvore \"alpha\" Vazia Vazia) Vazia")


  putStrLn $ "a*;a*;b"
  putStrLn $ verificaFramePDL [[(1, "a")], [(2,"a")],[(3,"b")]] (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"a\" Vazia Vazia) Vazia) (Arvore \";\" (Arvore \"*\" (Arvore \"a\" Vazia Vazia) Vazia) (Arvore \"b\" Vazia Vazia))")
  
  putStrLn $ "a*;a*;b"
  putStrLn $ verificaFramePDL [[(1, "a")], [],[(3,"b")]]  (criaArvore "Arvore \";\" (Arvore \"*\" (Arvore \"a\" Vazia Vazia) Vazia) (Arvore \";\" (Arvore \"*\" (Arvore \"a\" Vazia Vazia) Vazia) (Arvore \"b\" Vazia Vazia))")
  