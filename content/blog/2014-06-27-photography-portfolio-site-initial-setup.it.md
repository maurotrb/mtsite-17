+++
title      = "Sito per portfolio fotografico: impostazione iniziale"
date       = "2014-06-27T15:55:23+02:00"
type       = "article"
etichette  = [ "Programmazione", "Haskell", "Hakyll", "Foundation", "Fotografia" ]
slug       = "sito-per-portfolio-fotografico-impostazione-iniziale"
+++

Questo è il secondo post riguardante il progetto di sito di portfolio fotografico.
Se vuoi sapere di più circa il progetto, puoi leggere il
[primo post](/it/blog/2014/01/30/sito-per-portfolio-fotografico-un-nuovo-progetto/).
In questo post spiegherò le impostazioni iniziali del progetto e la creazione
di una pagina _home_ minimale per il sito.

<!--more-->
## Prima cosa da fare: un nuovo repository GitHub

Ho creato un nuovo [repository github](https://github.com/maurotrb/mtphotosite) per
ospitare il progetto. In questo e nei post seguenti sul progetto, farò riferimento
a specifici _commit_ di questo repository, in modo che potrai vedere i dettagli
del _changeset_.

## Gestire un progetto Haskell: cabal e sandbox

Uso [Hakyll](http://jaspervdj.be/hakyll/) per generare il sito web statico,
così ho impostato un progetto Haskell vero e proprio:

* creando un [cabalized project](http://www.haskell.org/haskellwiki/How_to_write_a_Haskell_program#Add_a_build_system)
  con `cabal init`, impostando Hakyll come dipendenza e creando un file sorgente con una funzione `Main` vuota
* creando una [sandbox](http://chromaticleaves.com/posts/cabal-sandbox-workflow.html)
  per lavorare in un ambiente isolato con `cabal sandbox init`
* installando tutte le dipendenze nella sandbox con `cabal install --only-dependencies`
* compilando il progetto con `cabal build` per controllare la presenza di errori: eseguendo il programma
  `./dist/build/mtphotosite/mtphotosite` non risultavano errori
* [congelando](http://blog.docmunch.com/blog/2013/haskell-version-freezing) la versione delle librerie con
  `cabal-constraints dist/setup-config > .cabal.config` (adesso con Cabal 1.20 puoi usare `cabal freeze`)

Puoi navigare il [codice](http://github.com/maurotrb/mtphotosite/tree/0a3c884ee0f3aaa2e801bdd4bb1d7349e8d82f4d)
o vedere la [commit](http://github.com/maurotrb/mtphotosite/commit/0a3c884ee0f3aaa2e801bdd4bb1d7349e8d82f4d)
fatta dopo questi passi.

## Creare un sito Hakyll con il template di default

Per verificare il setup iniziale, ho creato un sito Hakyll con il template di default
usando `hakyll-init`. Ho cambiato le cartelle di default nella configurazione per
mantenere ordinata la cartella radice: `site-src` per i file originari,
`site-pub` per il sito generato e `.hakyll-cache` per i file temporanei di Hakyll.

Dopo aver compilato con `cabal build`, ho provato il sito con `./dist/build/mtphotosite/mtphotosite watch`
e aperto il link `http://localhost:8000` con un _web browser_. Tutto funzionava!

Puoi navigare il [codice](http://github.com/maurotrb/mtphotosite/tree/5b2b7d25c2d1a95ad7ce3264012b65b8252dfd59)
o vedere la [commit](http://github.com/maurotrb/mtphotosite/commit/5b2b7d25c2d1a95ad7ce3264012b65b8252dfd59)
fatta dopo questi passi.

## Usare Zurb Foundation con la versione Sass

Per usare [Zurb Foundation](http://foundation.zurb.com/) lo dovevo integrare con Hakyll.

Al momento della stesura del post, è disponibile Foundation 5. Si può usare la versione
CSS oppure la versione Sass. La seconda permette di fare più personalizzazioni e
con i _Sass mixins_ si possono usare dei _markup_ HTML semantici.
Non conosco molto Sass, ma mi piace la promessa di flessibilità e la prendo come
occasione per impararne di più.

Sfortunatamente la versione Sass di Foundation richiede Ruby, Node.js, Grunt, Bower.
Mentre voglio imparare qualcosa di più su Sass, non sono molto interessato ad
imparare l'ecosistema Node.js per usare un _framework_ CSS. L'unica dipendenza
che posso accettare è con Ruby, dato che ce l'ho già installato per altri progetti.
Dopo qualche indagine nei gruppi di discussione di Foundation, ho scoperto che
esiste una versione Sass precompilata su [Github](https://github.com/zurb/bower-foundation)
che è aggiornata frequentemente e che ha un _tag_ per ogni release di Foundation.

Ho creato un _git submodule_ collegato a questo repository e impostato ad un _tag_ di
una specifica release.

Per integrare Foundation con Hakyll, ho [cancellato](https://github.com/maurotrb/mtphotosite/commit/63865dc2e190955919d0a39892bb03968bd0bbe2)
il file del template di default e ho modificato il file Main aggiungendo la
[compilazione](https://github.com/maurotrb/mtphotosite/commit/f8cfc42b34c43922c45dac0bfaa883dddf2379d4)
dei file Sass e la [copy](https://github.com/maurotrb/mtphotosite/commit/7be089f76839bba69ad04f30492cebe10d35e710)
dei file Javascript. Per compilare i file Sass ho installato il compilato Sass di Ruby.
Potrei probabilmente rimuovere questa dipendenza passando a [libsass](http://libsass.org/).
Per quanto riguarda i file javascript, ho copiato la versione _minified_ che contiene tutte le funzionalità
di Foundation. Potrei combinare e minimizzare solo il javascript necessario per le funzionalità a cui
sono interesato, per ridurre la dimensione del file. Queste ottimizzazioni sono interessanti, ma non essenziali
nella prima fase del progetto. Le affronterò in future evoluzioni.

## Creare un prototipo della pagina home

Finalmente ho [creato](https://github.com/maurotrb/mtphotosite/commit/77d4a6c84d291b701fbdd4c01c4433996510e5b9)
un prototipo per la pagina _home_ con una _top bar_, un _footer_ e una _grid_ con 12 immagini quadrate.
Ho creato questa pagina come HTML completo e poi l'ho
[convertita](https://github.com/maurotrb/mtphotosite/commit/297fa792b30c7e9ecd82d42ec2d3b71453641b9b)
in un template Hakyll.

Ho provato il sito con `./dist/build/mtphotosite/mtphotosite watch` e aperto il link
`http://localhost:8000` con il _web browser_. Tutto funzionava ancora!
