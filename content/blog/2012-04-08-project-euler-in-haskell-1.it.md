+++
title      = "Progetto Eulero in Haskell #1"
date       = "2012-04-08T22:48:00+02:00"
type       = "article"
etichette  = [ "Programmazione", "Haskell", "Progetto Eulero" ]
slug       = "progetto-eulero-in-haskell-1"
katex      = "true"
markup     = "mmark"
+++

## Descrizione del problema
[Link al problema 1 del Progetto Eulero](http://projecteuler.net/problem=1)

Se elenchiamo tutti i numeri naturali inferiori a 10 che sono multipli di 3 o 5,
otteniamo 3, 5, 6 e 9. La somma di questi multipli è 23.

Trova la somma di tutti i multipli di 3 o 5 inferiori a 1000.

__ATTENZIONE__
_I prossimi paragrafi contengono la soluzione. Non leggere oltre se vuoi avere i benefici
del Progetto Eulero e non hai ancora risolto il problema._

<!--more-->
## Descrizione
La soluzione semplice è di passare tutti i numeri da 1 a 999 e verificare se
siano divisibili per 3 o 5. In Haskell si può usare la _list comprehension_:

{{< highlight haskell >}}
solution  =  sum [n | n <- [1..999], n `mod` 3 == 0 || n `mod` 5 == 0]
{{< /highlight >}}

Leggendo le note di soluzione dal sito del progetto, possiamo vedere che la soluzione
può essere espressa anche come:

{{< highlight haskell >}}
solution'  =  sum [n | n <- [1..999], n `mod` 3 == 0]  +
              sum [n | n <- [1..999], n `mod` 5 == 0]  -
              sum [n | n <- [1..999], n `mod` 15 == 0]
{{< /highlight >}}

Notando che:

$$
3+6+9+12+15+\dots+999 = 3\times(1+2+3+4+\dots+333)\\
5+10+15+\dots+995 = 5\times(1+2+\dots+199)
$$

dove $$333=\frac{999}{3}$$ and $$199=\frac{995}{5}$$ but also $$\frac{999}{5}$$
arrotondato per difetto all'intero più vicino.

E dall'espressione per le
[progressioni aritmetiche](https://it.wikipedia.org/wiki/Progressione_aritmetica):

$$
S_n=\frac{n}{2}(a_1+a_n)
$$

possiamo derivare che:

$$
1+2+3+\dots{}+p=\frac{p}{2}(1+p)
$$

Possiamo scrivere una soluzione efficiente:

{{< highlight haskell >}}
target = 999

sumDivisibleBy n = n * p * (1 + p) `div` 2
    where
      p = target `div` n

solution'' = sumDivisibleBy 3 + sumDivisibleBy 5 - sumDivisibleBy 15
{{< /highlight >}}

Puoi trovare il codice in _Literate Haskell_ su [GitHub](https://github.com/maurotrb/mt-euler)
e su [Bitbucket](https://bitbucket.org/maurotrb/mt-euler).
