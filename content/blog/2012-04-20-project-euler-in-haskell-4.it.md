+++
title      = "Progetto Eulero in Haskell #4"
date       = "2012-04-20T13:47:00+02:00"
type       = "article"
etichette  = [ "Programmazione", "Haskell", "Progetto Eulero" ]
slug       = "progetto-eulero-in-haskell-4"
katex      = "true"
markup     = "mmark"
+++

## Descrizione del problema
[Link al problema 4 del Progetto Eulero](http://projecteuler.net/problem=4)

Un numero palindromo si legge nello stesso modo sia da destra che da sinistra.
Il più grande numero palindromo calcolato come prodotto di due numeri a due cifre è
$$9009=91\times99$$.

Trova il più grande numero palindromo calcolato dal prodotto di due numeri a tre cifre.

__ATTENZIONE__
_I prossimi paragrafi contengono la soluzione. Non leggere oltre se vuoi avere i benefici
del Progetto Eulero e non hai ancora risolto il problema._

<!--more-->
## Soluzione
Prima di tutto, ci serve una funzione per verificare se un numero sia palindromo.
Con `isPalindrome` convertiamo semplicemente il numero in una stringa e confrontiamo
la stringa con il suo inverso.

Nota che questa funzione non si applica solo ai numeri ma a tutti i tipi che implementano
la _typeclass_ `Show`.

{{< highlight haskell >}}
isPalindrome    :: Show a => a -> Bool
isPalindrome x  =  x' == reverse x' where x' = show x
{{< /highlight >}}

La soluzione semplice al problema usa la _list comprehension_ di Haskell.
Enumeriamo tutti i prodotti di due numeri a tre cifre, filtriamo quello che sono palindromi,
ed estraiamo quello più grande.

{{< highlight haskell >}}
solution  :: Integer
solution  =  maximum  [x*y | x <- [100..999], y <- [100..999]
                      , isPalindrome (x*y)]
{{< /highlight >}}

Possiamo migliorare questa soluzione, notando che la combinazione degli
stessi termini è considerata due volte: `x=123,y=456` e `x=456,y=123`.
Possiamo filtrare i palindromi potenziali per includere solo i prodotti
dove il primo termine è maggiore o uguale al secondo termine.

{{< highlight haskell >}}
solution'  :: Integer
solution'  =  maximum  [x*y | x <- [100..999], y <- [100..999]
                       , x >= y
                       , isPalindrome (x*y)]
{{< /highlight >}}

Inoltre, se esprimiamo i palindromi come un polinomio multivariato a sei termini,
dopo qualche semplificazione troviamo che tutti i palindromi di sei cifre
sono divisibili per 11.

$$
P=100000x+10000y+1000z+100z+10y+x\\
P=100001x+10010y+1100z\\
P=11(9091x+910y+100z)
$$

Possiamo filtrare i potenziali palindromi per includere solo i prodotti
dove almeno uno dei termini è divisibile per 11.

{{< highlight haskell >}}
solution''  :: Integer
solution''  =  maximum  [x*y | x <- [100..999], y <- [100..999]
                        , x >= y
                        , x `mod` 11 == 0 || y `mod` 11 == 0
                        , isPalindrome (x*y)]
{{< /highlight >}}

Ma, se vogliamo trovare una soluzione efficiente, dobbiamo cambiare metodo.
Contando a rovescio da 999, possiamo trovare la soluzione prima.

La funzione `euler4` viene eseguita ricorsivamente su una lista di termini
numerici decrescenti e, con il termine corrente fissato come primo termine,
esegue una ricorsione interna usando il resto della lista come fonte per il secondo termine.
Il prodotto risultante è verificato per trovare se si tratta di un palindromo.
Il risultato della ricorsione interna è confrontato con il palindromo candidato per
scegliere quello più grande.

La funzione `euler4` usa due tecniche di ottimizzazione:

* esce dalla ricorsione interna quando trova il primo palindromo:
  dato che il primo termine del prodotto è fissato, non potrebbe
  trovare un palindromo più grande
* esce dalla ricorsione esterna quando il palindromo candidato è
  più grande del quadrato del primo termine: dato che i termini
  successivi sono più piccoli, non potrebbe trovare una palindromo
  più grande

{{< highlight haskell >}}
euler4               :: (Ord a, Num a) => [a] -> a -> a
euler4 []         p  =  p
euler4 ns@(x:xs)  p  |  x*x < p    =  p
                     |  otherwise  =  euler4 xs $ max p $ maxPalindrome ns
                     where
                       maxPalindrome []        =  0
                       maxPalindrome (x':xs')  |  isPalindrome m  =  m
                                               |  otherwise       =  maxPalindrome xs'
                                               where
                                                 m = x * x'
{{< /highlight >}}

Troviamo la soluzione chiamando `euler4` con una lista da 999 a 100 e con 0 come
il palindromo candidato.

{{< highlight haskell >}}
solution'''  :: Integer
solution'''  =  euler4 [999,998..100] 0
{{< /highlight >}}

Nota che la funzione `euler4` potrebbe essere usato per trovare il più grande palindromo
creato dal prodotto di numeri con più di tre cifre, per ese. `euler4 [9999,9998..1000] 0`.

Puoi trovare il codice in _Literate Haskell_ su [GitHub](https://github.com/maurotrb/mt-euler)
e su [Bitbucket](https://bitbucket.org/maurotrb/mt-euler).
