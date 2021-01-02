+++
title      = "Provare la libreria Shake"
date       = "2012-05-18T00:02:00+02:00"
type       = "article"
etichette  = [ "Programmazione", "Haskell" ]
slug       = "provare-la-libreria-shake"
+++

Avevo un piccolo _task_ ripetitivo da automatizzare nel mio
progetto [mt-euler](https://github.com/maurotrb/mt-euler):
creare un pdf da una serie di file _Literate Haskell_ usando
`lhs2TeX` e `xelatex`.

Stavo cercando qualcosa tipo _make_ o _rake_, ma scritto in Haskell
e ho trovato [Shake](http://hackage.haskell.org/package/shake).

L'ho usato e sono soddisfatto del risultato.

<!--more-->
## Un piccolo task da automatizzare
Qualche mese fa ho deciso di risolvere alcuni dei problemi del [Progetto Eulero](http://projecteuler.net)
usando il linguaggio Haskell.

Dato che volevo scrivere insieme il codice e le spiegazioni, ho scelto di scrivere in
_Literate Haskell_ con stile _LaTeX_.

Ho strutturato il progetto con un file principale `hs-euler.lhs`, che contiene il preambolo LaTeX
e la struttura del documento, più una serie di file `lhs`, uno per ogni problema, inclusi nel file principale:
`hs-euler-001.lhs`, `hs-euler-002.lhs`, ...

In questo modo posso creare facilmente un file pdf formattato usando una sequenza di comandi `lhs2TeX`
e `xelatex` (uso XeTeX). Ma invocare questi comandi ripetutamente e nella sequenza corretta è
un processo noioso e soggetto ad errori. Questo _task_ era un candidato perfetto per qualche tipo di
automazione.

Stavo cercando qualcosa come _make_ o _rake_, ma scritto in Haskell, e ho trovato
[Shake](http://hackage.haskell.org/package/shake).

## Usare la libreria Shake
La libreria Shake è descritta bene dal suo creatore
[Neil Mitchell](http://neilmitchell.blogspot.it/):

> Shake is a Haskell library for writing build systems - designed as a replacement for make. To use Shake the user writes a Haskell program that imports the Shake library, defines some build rules, and calls shake. Thanks to do notation and infix operators, a simple Shake program is not too dissimilar from a simple Makefile. However, as build systems get more complex, Shake is able to take advantage of the excellent abstraction facilities offered by Haskell and easily support much larger projects.

Dopo aver letto la documentazione, guardato il codice sorgente e cercato sul web, ho realizzato il
seguente file di _build_.

{{< highlight haskell >}}
import Development.Shake
import Development.Shake.FilePath

main = shake shakeOptions $ do
         want ["hs-euler.pdf"]
         "*.pdf" *> \out -> do
           let tex = replaceExtension out "tex"
           need [tex]
           system' "xelatex" [tex]
           system' "xelatex" [tex]
         "*.tex" *> \out -> do
           let lhs = replaceExtension out "lhs"
           incl_lhs <- getDirectoryFiles "." $ dropExtension out ++ "-*.lhs"
           need $ lhs : incl_lhs
           system' "lhs2TeX" $ ["-o",out,lhs]
{{< /highlight >}}

Qualche nota:

* la regola `want` specifica il file `hs-euler.pdf` come _target_
* le due regole `*>` specificano come creare il pdf e il file tex usando `lhs2TeX` e `xelatex`
* le dipendenza sono specificate usando la regola `need`

La catena delle dipendeze può essere visualizzata in questo modo:
`want hs-euler.pdf → need hs-euler.tex → need [hs-euler.lhs, hs-euler-001.lhs, ...]`

Quando esegui per la prima volta il programma di _build_ con `runhaskell make.hs`,
Shake crea il file `hs-euler.pdf` e crea il file `.shake.database` dove salva le informazioni
di dipendenza.
Nelle esecuzioni successive, Shake usa le informazioni contenute in questo file
per verificare se qualcuna delle dipendenze sia cambiata, e eventualmente fa scattare
una nuova _build_.

## Commenti finali
Sono stato contento di aver usato Shake per il mio problema di automazione.
Il file _build_ risultante è corto e chiaro, e fa bene il suo lavoro.

Ma ci sono alcune considerazioni da fare.

Avevo solo un piccolo _task_ da automatizzare e di conseguenza non ho usato le
funzionalità avanzate di Shake.

Ho usato Shake per creare della documentazione, non un eseguibile. Se devi compilare una
libreria o un eseguibile Haskel, fai attenzione a quello che dice Neil Mitchell:

> If ghc --make or cabal is capable of building your project, use that instead. Custom build systems are necessary for many complex projects, but many projects are not complex.

Quindi, se pensi che i _tool_ standard di compilazione di Haskell non siano sufficienti
per il tuo progetto, o se hai da automatizzare qualche altro tipo di _task_,
penso che dovresti provare Shake.

Puoi trovare il codice in _Literate Haskell_ di mt-euler su
[GitHub](https://github.com/maurotrb/mt-euler) e su
[Bitbucket](https://bitbucket.org/maurotrb/mt-euler).
