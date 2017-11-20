+++
title      = "Progetto Eulero in Haskell #2"
date       = "2012-04-10T12:59:00+02:00"
type       = "article"
etichette  = [ "Programmazione", "Haskell", "Progetto Eulero" ]
slug       = "progetto-eulero-in-haskell-2"
+++

## Descrizione del problema
[Link al problema 2 del Progetto Eulero](http://projecteuler.net/problem=2)

Ogni nuovo elemento nella sequenza di Fibonacci è generato sommando i due elementi precedenti.
Iniziando con 1 e 2, i primi 10 elementi saranno: 1,2,3,5,8,13,21,34,55,89, ...

Considerando gli elementi nella sequenza di Fibonacci i cui valori non eccedono
i quattro milioni, trovare la somma degli elementi pari.

__ATTENZIONE__
_I prossimi paragrafi contengono la soluzione. Non leggete oltre se volere avere i benefici
del Progetto Eulero e non avete ancora risolto il problema._

<!--more-->
## Soluzione
Ci sono molti modi di esprimere la
[sequenza di Fibonacci in Haskell](http://www.haskell.org/haskellwiki/The_Fibonacci_sequence).

Se scegliamo il più famoso, che fa buon uso delle liste _lazy_:

{{< highlight haskell >}}
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
{{< /highlight >}}

Possiamo semplicemente prendere i numeri di Fibonacci fino ai quattro milioni,
filtrare quelli pari e sommare il risultato.

{{< highlight haskell >}}
solution = (sum . filter even . takeWhile (<4000001)) fibs
{{< /highlight >}}

Potete trovare il codice in _Literate Haskell_ su [GitHub](https://github.com/maurotrb/mt-euler)
e su [Bitbucket](https://bitbucket.org/maurotrb/mt-euler).
