+++
title      = "Progetto Eulero in Haskell #3"
date       = "2012-04-12T16:03:00+02:00"
type       = "article"
etichette  = [ "Programmazione", "Haskell", "Progetto Eulero" ]
slug       = "progetto-eulero-in-haskell-3"
+++

## Descrizione del problema
[Link al problema 3 del Progetto Eulero](http://projecteuler.net/problem=3)

I fattori primi di 13195 sono 5, 7, 13 e 29.

Qual è il più grande fattore primo del numero 600851475143?

__ATTENZIONE__
_I prossimi paragrafi contengono la soluzione. Non leggere oltre se vuoi avere i benefici
del Progetto Eulero e non hai ancora risolto il problema._

<!--more-->
## Soluzione
Abbiamo bisogno di un generatore di numeri primi per trovare il fattore primo di un numero.
Invece di usare un _package_ scaricato da _Hackage_, preferisco creare un generatore da zero.

Userò l'algoritmo del Crivello di Eratostene, come descritto da
[Melissa E. O'Neill (PDF 217KB)](http://www.cs.hmc.edu/~oneill/papers/Sieve-JFP.pdf).

Il generatore proposto nell'articolo usa una coda di priorità come struttura dati.
Un coda di priorità semplice ed efficace, il `Pairing Heap`, è descritto da
[Louis Wasserman (PDF 396KB)](http://themonadreader.files.wordpress.com/2010/05/issue16.pdf).

Di seguito il codice, adattato per l'algoritmo del crivello, e senza usare la monade `Maybe`
per l'estrazione del valore minimo (per semplicità).

{{< highlight haskell >}}
data PairingHeap a  =  Empty
                    |  PairNode a [PairingHeap a]
                       deriving (Show)

(+++)              :: Ord a => PairingHeap a -> PairingHeap a -> PairingHeap a
Empty  +++  heap   =  heap
heap   +++  Empty  =  heap
heap1@(PairNode x1 ts1)  +++  heap2@(PairNode x2 ts2)
    | x1 <= x2     =  PairNode x1 (heap2:ts1)
    | otherwise    =  PairNode x2 (heap1:ts2)

-- Construction
empty  :: PairingHeap a
empty  =  Empty

singleton    :: a -> PairingHeap a
singleton x  =  PairNode x []

-- Insertion
insert      :: Ord a => a -> PairingHeap a -> PairingHeap a
insert x q  =  (singleton x) +++ q

-- Priority Queue
minValue                 :: PairingHeap a ->  a
minValue Empty           =  error "Empty queue!"
minValue (PairNode x _)  =  x

deleteMin                  :: Ord a => PairingHeap a -> PairingHeap a
deleteMin Empty            =  error "Empty queue!"
deleteMin (PairNode _ ts)  =  meldChildren ts
    where
      meldChildren (t1:t2:ts)  =  t1 +++ t2 +++ meldChildren ts
      meldChildren [t]         =  t
      meldChildren []          =  Empty

deleteMinAndInsert      :: Ord a => a -> PairingHeap a -> PairingHeap a
deleteMinAndInsert x q  =  insert x $ deleteMin q
{{< /highlight >}}

Questa implementazione del `Pairing Heap` non supporta nodi chiave/valore.
Così definisco un tipo dato `Iterator` per gestire il concetto di chiave/valore necessario per l'algoritmo.

{{< highlight haskell >}}
-- Iterator
data Iterator = Iterator Integer [Integer]
    deriving (Show)

instance Eq Iterator where
    (Iterator x _) == (Iterator y _) = x == y

instance Ord Iterator where
    compare (Iterator x _) (Iterator y _) = compare x y
{{< /highlight >}}

Creo anche un `Table` _type alias_ e qualche funzione di utilità per nascondere
all'algoritmo la specifica implementazione della coda di priorità.

{{< highlight haskell >}}
-- Table
type Table = PairingHeap Iterator

emptyTable  :: Table
emptyTable  =  empty

insertTable         :: Integer -> [Integer] -> Table -> Table
insertTable n is t  =  insert (Iterator n is) t

tableMinValue    :: Table -> Integer
tableMinValue t  =  n
    where
      (Iterator n _) = minValue t

tableMinValueIters    :: Table -> (Integer, [Integer])
tableMinValueIters t  =  (n, is)
    where
      (Iterator n is)  =  minValue t

tableDeleteMinAndInsert         :: Integer -> [Integer] -> Table -> Table
tableDeleteMinAndInsert n is t  =  deleteMinAndInsert (Iterator n is) t
{{< /highlight >}}

Con la coda di priorità completata, possiamo definire l'algoritmo del crivello:

* la funzione `sieve` filtra la sequenza in input e trova i numeri primi incrementalmente
* lo stream `wheel` e la funzione `spin` permettono di generare una sequenza di input
  senza la composizione dei numeri primi 2,3,5,7; questa ottimizzazione rende il crivello
  sette volte più veloce che con una sequenza di input completa `[2..]`
* lo stream `primes` è creato componendo la funzione `sieve` e lo _spinned wheel_

{{< highlight haskell >}}
sieve         :: [Integer] -> [Integer]
sieve []      =  []
sieve (x:xs)  =  x : sieve' xs (insertprime x xs emptyTable)
    where
      insertprime p xs table  =  insertTable (p*p) (map (*p) xs) table
      sieve' [] table  =  []
      sieve' (x:xs) table
          | nextComposite <= x  =  sieve' xs (adjust table)
          | otherwise           =  x : sieve' xs (insertprime x xs table)
          where
            nextComposite  =  tableMinValue table
            adjust table
                | n <= x     =  adjust (tableDeleteMinAndInsert n' ns table)
                | otherwise  =  table
                where
                  (n, n':ns)  =  tableMinValueIters table

wheel2357 :: [Integer]
wheel2357 = 2:4:2:4:6:2:6:4:2:4:6:6:2:6:4:2:6:4:6:8:4:2:4:2:4
            :8:6:4:6:2:4:6:2:6:6:4:2:4:6:2:6:4:2:4:2:10:2:10:wheel2357

spin           :: [Integer] -> Integer -> [Integer]
spin (x:xs) n  =  n : spin xs (n+x)

primes  :: [Integer]
primes  =  2:3:5:7: sieve (spin wheel2357 11)
{{< /highlight >}}

Uso il generatore di numeri primi per trovare il fattore primo di un intero.

{{< highlight haskell >}}
primeFactors    :: Integer -> [Integer]
primeFactors n  =  factors n primes
    where
      factors 1 _                   =  []
      factors m (p:ps) | m < p*p    =  [m]
                       | r == 0     =  p : factors q (p:ps)
                       | otherwise  =  factors m ps
                       where (q,r)  =  quotRem m p
{{< /highlight >}}

E finalmente la soluzione:

{{< highlight haskell >}}
solution = last $ primeFactors 600851475143
{{< /highlight >}}

Puoi trovare il codice in _Literate Haskell_ su [GitHub](https://github.com/maurotrb/mt-euler)
e su [Bitbucket](https://bitbucket.org/maurotrb/mt-euler).
