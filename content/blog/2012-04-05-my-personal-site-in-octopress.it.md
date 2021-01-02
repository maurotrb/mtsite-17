+++
title      = "Il mio sito personale in Octopress"
date       = "2012-04-05T23:32:00+02:00"
type       = "article"
etichette  = [ "Programmazione", "Web", "Ruby", "Octopress" ]
slug       = "mio-sito-personale-in-octopress"
+++

Alcuni giorni fa ho pubblicato questo sito web. Ora voglio
condividere alcune informazioni sul perché e sul come l'ho fatto.

<!--more-->
__Attenzione! Questo articolo non è più attuale. Il sito web che stai leggendo non è più fatto in Octopress.__

## Perché l'ho fatto
Voglio usare un sito web personale come:

* un punto di raccordo della mia presenza sul web
* un posto dove condividere e commentare notizie ed articoli trovati sul web,
  libri che sto leggendo, ecc.
* un posto dove condividere i mie progetti personali e i miei studi
  (principalmente sul software e sulla programmazione)

## Come l'ho fatto
Pensando ai requisiti del sito, ho deciso che volevo un sito web
con una struttura semplice, con una frequenza di aggiornamento bassa
e che non costasse molto.

Ho concluso che la scelta migliore sarebbe stata un generatore di
siti web statici. Inoltre, mi sarei divertito imparando ad usarne uno.

Ho cercato e valutato vari generatori e finalmente ho scelto [Octopress](http://octopress.org).
La ragione principale? La sua semplicità.

> Octopress is a framework designed by Brandon Mathis for Jekyll, the blog aware static site generator powering Github Pages. To start blogging with Jekyll, you have to write your own HTML templates, CSS, Javascripts and set up your configuration. But with Octopress All of that is already taken care of. Simply clone or fork Octopress, install dependencies and the theme, and you’re set.

Con Octopress, seguendo la sua eccellente documentazione e solo modificando
il suo file di configurazione, è facile creare un blog con un layout _responsive_,
_mobile first_ e connesso con i principali siti _social_ (Twitter, Google Plus, etc.).
E se vuoi personalizzare Octopress, puoi arrivare molto lontano con solo una
conoscenza di base di ruby, html e css.

Come esempio, ecco una breve lista delle personalizzazioni che ho fatto:

* spostato i _post_ in una sotto sezione e creato una pagina _about me_ per la _home_
* cambiato caratteri e colori
* modificato il _plug-in_ di twitter per aggiungere i _retweet_
* aggiunto il supporto a bitbucket grazie a
  [c0der78](https://github.com/c0der78/Octopress-Bitbucket-Aside)

Se vuoi vedere i dettagli, puoi trovare il codice sorgente del sito su
[GitHub](https://github.com/maurotrb/mtsite) e su
[Bitbucket](https://bitbucket.org/maurotrb/mtsite).

## Racomando Octopress
Se stai cercando un generatore di siti statici che sia semplice,
ma molto personalizzabile, Octopress è una valida alternativa.
